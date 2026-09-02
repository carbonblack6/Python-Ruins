$previewDir = Join-Path $PSScriptRoot 'music-previews'
New-Item -ItemType Directory -Path $previewDir -Force | Out-Null
$source = @'
using System;
using System.IO;
using System.Text;
public static class RuinsMusicPreviews {
  const int Rate=11025, Count=Rate*5;
  static double Env(double p,double d,double a=.02,double r=.12){if(p<0||p>=d)return 0;return Math.Min(Math.Min(1,p/a),Math.Min(1,(d-p)/r));}
  static double Tone(double t,double s,double d,double f,double v,int voice=0){double p=t-s,e=Env(p,d);if(e<=0)return 0;double q=2*Math.PI*f*p;if(voice==1)return v*e*(Math.Sin(q)*.7+Math.Sin(q*2.03)*.22+Math.Sin(q*3.9)*.08)*Math.Exp(-5.5*p);if(voice==2)return v*e*(Math.Sin(q)*.84+Math.Sin(q*2)*.1+Math.Sin(q*3)*.06);return v*e*Math.Sin(q);}
  static double Drum(double t,double s,double v){double p=t-s;if(p<0||p>=.22)return 0;double f=92-55*(p/.22);return v*Math.Sin(2*Math.PI*f*p)*Math.Exp(-18*p);}
  static readonly double[,] Ambient={{.35,.72,293.66},{1.32,.58,349.23},{2.18,.82,261.63},{3.28,.62,392},{4.10,.72,329.63}};
  static readonly double[] Drums={0,.63,1.05,1.68,2.08,2.74,3.16,3.78,4.18,4.68};
  static readonly double[,] Woods={{.20,220},{.82,293.66},{1.28,261.63},{1.90,329.63},{2.30,246.94},{2.96,369.99},{3.42,293.66},{4.02,392},{4.43,329.63},{4.82,246.94}};
  static readonly double[,] Temple={{.08,.70,220},{.56,.72,277.18},{1.05,.85,329.63},{1.78,.75,246.94},{2.34,.88,369.99},{3.12,.74,293.66},{3.68,.82,415.30},{4.34,.62,329.63}};
  static double Sample(double t,int option){double v=0;if(option==1){v=Tone(t,0,5,73.42,.13)+Tone(t,0,5,110,.055);for(int n=0;n<Ambient.GetLength(0);n++)v+=Tone(t,Ambient[n,0],Ambient[n,1],Ambient[n,2],.16,2);v+=Tone(t,1.02,.12,510,.16,1)+Tone(t,2.73,.12,440,.14,1)+Tone(t,4.56,.12,585,.14,1);}else if(option==2){v=Tone(t,0,5,82.41,.065);foreach(double d in Drums)v+=Drum(t,d,.58);for(int n=0;n<Woods.GetLength(0);n++)v+=Tone(t,Woods[n,0],.24,Woods[n,1],.34,1);}else{v=Tone(t,0,5,55,.1)+Tone(t,0,5,82.41,.07);for(int n=0;n<Temple.GetLength(0);n++){v+=Tone(t,Temple[n,0],Temple[n,1],Temple[n,2],.17,2);v+=Tone(t,Temple[n,0]+.19,Temple[n,1]*.62,Temple[n,2]*1.5,.055);}}return Math.Max(-.92,Math.Min(.92,v));}
  public static void Write(string path,int option){using(var w=new BinaryWriter(File.Open(path,FileMode.Create))){int size=Count*2;w.Write(Encoding.ASCII.GetBytes("RIFF"));w.Write(36+size);w.Write(Encoding.ASCII.GetBytes("WAVEfmt "));w.Write(16);w.Write((short)1);w.Write((short)1);w.Write(Rate);w.Write(Rate*2);w.Write((short)2);w.Write((short)16);w.Write(Encoding.ASCII.GetBytes("data"));w.Write(size);for(int i=0;i<Count;i++)w.Write((short)(Sample(i/(double)Rate,option)*32767));}}
}
'@
Add-Type -TypeDefinition $source -Language CSharp
[RuinsMusicPreviews]::Write((Join-Path $previewDir '01-ambient-jungle-ruins-v2.wav'),1)
[RuinsMusicPreviews]::Write((Join-Path $previewDir '02-tribal-exploration.wav'),2)
[RuinsMusicPreviews]::Write((Join-Path $previewDir '03-mystical-temple.wav'),3)
Get-ChildItem -LiteralPath $previewDir -Filter '*.wav' | Select-Object Name,Length
