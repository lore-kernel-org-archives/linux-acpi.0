From: Nigel Nigel <nigels@hotmail.com>
Subject: RE: acpid on gentoo
Date: Mon, 5 Mar 2007 11:05:02 +0000
Message-ID: <BAY123-W3799200C043D04F88F6F5D5840@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_6f801a6c-87ff-496b-96dc-07c872e3c0c5_"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bay0-omc3-s11.bay0.hotmail.com ([65.54.246.211]:63620 "EHLO
	bay0-omc3-s11.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933140AbXCELFD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Mar 2007 06:05:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brian Dunn <job17and9@sbcglobal.net>
Cc: linux-acpi@vger.kernel.org

--_6f801a6c-87ff-496b-96dc-07c872e3c0c5_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Thanks for replying, answers inline : -------------------------------------=
--- >=20
Date: Sun, 4 Mar 2007 13:09:36 -0800 > From: job17and9@sbcglobal.net > Subj=
ect: Re: acpid on gentoo > To: nigels@hotmail.com > >=20
Nigel:=20
> Have you started the acpid daemon?=20
Yes.=20
# ps -ef | grep [a]cpi
 root 8 5 0 09:29 ? 00:00:00 [kacpid]=20
root 4893 1 0 09:29 ? 00:00:00 /usr/sbin/acpid=20
102 5039 5033 0 09:29 ? 00:00:00 /usr/libexec/hald-addon-acpi=20

(i also tried running without the ald-addon-acpi  process to see if this ma=
kes it difference, it doesn't )
Also note:=20
# lsof |grep "/proc/acpi/event"=20
acpid 13843 root 3r REG 0,3 0 4026532088 /proc/acpi/event=20
daemon is running and "listening" to /proc/acpi/event=20
> I've had much success with that same gentoo kernel...=20
> what are your /etc/acpid config files looking like?
 # pwd /etc/acpi lithium acpi=20
# ls -R=20
.: actions default.sh events ./actions: pmg_switch_runlevel.sh ./events: de=
fault pmg_ac_adapter pmg_battery=20
# /usr/sbin/acpid -d 1=20
[Mon Mar 5 11:46:44 2007] starting up=20
[Mon Mar 5 11:46:44 2007] DBG: parsing conf file /etc/acpi/events/default=20
[Mon Mar 5 11:46:44 2007] DBG: parsing conf file /etc/acpi/events/pmg_ac_ad=
apter=20
[Mon Mar 5 11:46:44 2007] DBG: parsing conf file /etc/acpi/events/pmg_batte=
ry=20
[Mon Mar 5 11:46:44 2007] 3 rules loaded=20
[Mon Mar 5 11:46:47 2007] client connected from 5039[102:441]=20
[Mon Mar 5 11:46:47 2007] 1 client rule loaded=20
Apart from the pmg files, I have not modified the defaults of the other fil=
es.=20

Config files attached.

> got any logger commands in there?=20
Yes, but only stuff like this:=20
[Mon Mar 5 09:29:15 2007] starting up=20
[Mon Mar 5 09:29:16 2007] 3 rules loaded=20
[Mon Mar 5 09:29:17 2007] client connected from 5039[102:441]=20
[Mon Mar 5 09:29:17 2007] 1 client rule loaded=20
[Mon Mar 5 09:29:20 2007] client connected from 5699[0:0]=20
[Mon Mar 5 09:29:20 2007] 1 client rule loaded=20
[Mon Mar 5 11:46:37 2007] exiting=20

How have you come to
 > the conclusion that acpid is not receiving acpi=20
> events?=20

Start the daemon on the command line with "-d 1" No events are seen.=20
Tried attaching "strace -v -p "=20
Nothing more than this is ever shown:=20
poll(=20
Yes, that's right, with just the one side open bracket.=20
Both of the above are independant of where it logs information.=20
In both instances output is written to the terminal.=20

> > when i was setting mine up some months ago, the
 > default handler that shipped with acpid tried to log=20
> events with the system logger, not in a /var/log/acpi > file. check the s=
ystem log, and the /etc/acpid event > handlers.

I wish my problem were as simple as looking in the wrong place for the logs=
.
Have a reread of my initial post.

I don't necessarily need someone to just give me the immediate solution, bu=
t any tips that I could use to further debug what the problem might be.

At this point I'm guessing kernel config problem.

Thanks
Nigel.

 > > hope that helps.=20
> /brian


 > > --- Nigel Nigel wrote: > > > > > Hello, > > > > I have been trying to =
get acpid to receive events on > > gentoo without any success. > > I an on =
kernel 2.6.17 (with rev 10 gentoo patched) > > acpid: 1.0.4-r4 > > Toshiba =
Tecra M3 > > > > I have been following the guide at: > > > http://www.gento=
o.org/doc/en/power-management-guide.xml > > > > I'm on 2.6.17 > > > > So, w=
hatever they suggested to compile in the kernel > > or as a module that is =
what I have done. > > > > When I look at /var/log/acpi no events are being =
> > generated. > > > > With this test : > > on_ac_power && echo AC availabl=
e || echo Running on > > batteries > > > > It shows "AC available" when the=
 ac is plugged in, > > take the cable out, and it shows "Running on > > bat=
teries" > > > > Code: > > > > # acpitool -e > > Kernel version : 2.6.17 - A=
CPI version : > > 20060127 > > > > > --------------------------------------=
--------------------- > > Battery #1 : present > > Remaining capacity : 394=
41 mWh, 82.47%, 00:27:29 > > Design capacity : 50760 mWh > > Last full capa=
city : 47822 mWh, 94.21% of design > > capacity > > Capacity loss : 5.788% =
> > Present rate : 18295 mW > > Charging state : charging > > Battery type =
: rechargeable, Li-ION > > Model number : G71C0004G810 > > Serial number : =
0100027803 > > Battery #2 : slot empty > > > > AC adapter : on-line > > Fan=
 : off > > > > CPU type : Intel(R) Pentium(R) M > > processor 2.13GHz > > C=
PU speed : 800.000 MHz > > Cache size : 2048 KB > > Bogomips : 1600.29 > > =
Processor ID : 0 > > Bus mastering control : yes > > Power management : yes=
 > > Throttling control : no > > Limit interface : no > > Active C-state : =
C3 > > C-states (incl. C0) : 4 > > Usage of state C1 : 10 (0.0 %) > > Usage=
 of state C2 : 161443 (35.8 %) > > Usage of state C3 : 144440 (32.1 %) > > =
> > Thermal info : > > > > wakeup devices : > > > > > > I can modify this: =
> > > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor > > and the pro=
cessor speed with follow the governor > > which I set. > > > > I can also r=
un: acpitool -l 4 > > for example, and dim the lcd display. > > > > Also, I=
 have th battery indicator applet in gnome, > > this also changes correctly=
 with respect to having > > the power connected, or not. > > > > Most thing=
s seem to work as they should, except > > acpid is not receiving events. > =
> > > Code: > > > > # ls -R /proc/acpi/ > > /proc/acpi/: > > ac_adapter dsd=
t event info > > processor > > battery embedded_controller fadt > > power_r=
esource toshiba > > > > /proc/acpi/ac_adapter: > > ADP1 > > > > /proc/acpi/=
ac_adapter/ADP1: > > state > > > > /proc/acpi/battery: > > BAT1 BAT2 > > > =
> /proc/acpi/battery/BAT1: > > alarm info state > > > > /proc/acpi/battery/=
BAT2: > > alarm info state > > > > /proc/acpi/embedded_controller: > > > > =
/proc/acpi/power_resource: > > > > /proc/acpi/processor: > > CPU0 > > > > /=
proc/acpi/processor/CPU0: > > info limit power throttling > > > > /proc/acp=
i/toshiba: > > fan keys lcd version video > > > > > > Modules at run time :=
 > > Code: > > > > # lsmod > > Module Size Used by > > cisco_ipsec 545996 0=
 > > snd_pcm_oss 16992 0 > > snd_mixer_oss 12928 1 snd_pcm_oss > > snd_seq_=
oss 23872 0 > > snd_seq_midi_event 5184 1 snd_seq_oss > > snd_seq 37456 4 >=
 > snd_seq_oss,snd_seq_midi_event > > snd_seq_device 5708 2 snd_seq_oss,snd=
_seq > > snd_intel8x0 24924 0 > > snd_ac97_codec 78496 1 snd_intel8x0 > > s=
nd_ac97_bus 1792 1 snd_ac97_codec > > snd_pcm 54472 3 > > snd_pcm_oss,snd_i=
ntel8x0,snd_ac97_codec > > snd_timer 15236 2 snd_seq,snd_pcm > > snd_page_a=
lloc 6728 2 snd_intel8x0,snd_pcm > > toshiba_acpi 4756 0 > > speedstep_cent=
rino 5456 1 > > processor 16896 1 speedstep_centrino > > ipw2200 140268 0 >=
 > nvidia 4541396 12 > > sky2 28740 0 > > > > > > > > The AC and battery mo=
dules are compiled in kernel as > > the guide suggests. > > > > > > # acpi_=
available; echo $? > > 0 > > > > # grep -i "^config_acpi" .config > > CONFI=
G_ACPI=3Dy > > CONFIG_ACPI_AC=3Dy > > CONFIG_ACPI_BATTERY=3Dy > > CONFIG_AC=
PI_BUTTON=3Dm > > CONFIG_ACPI_VIDEO=3Dm > > CONFIG_ACPI_FAN=3Dm > > CONFIG_=
ACPI_PROCESSOR=3Dm > > CONFIG_ACPI_THERMAL=3Dm > > CONFIG_ACPI_TOSHIBA=3Dm =
> > CONFIG_ACPI_BLACKLIST_YEAR=3D0 > > CONFIG_ACPI_EC=3Dy > > CONFIG_ACPI_P=
OWER=3Dy > > CONFIG_ACPI_SYSTEM=3Dy > > > > # lsof |grep "/proc/acpi/event"=
 > > acpid 13843 root 3r REG 0,3 > > 0 4026532088 /proc/acpi/event > > > > =
> > Even if I run strace against acpid I can't seen > > anything happening.=
 > > > > > > One interesting though, if I do : modprobe button > > then eve=
ry 30 seconds or so I get: > > received event "battery BAT1 00000080 000000=
01" > > > > Even when i do rmmod button I still keep getting > > these even=
ts. > > The only way to go back to "normal" behaviour is to > > reboot. > >=
 > > Any suggestions as to what might be my problem here > > ? > > > > TIA =
> > Nigel. > > > > > > > =3D=3D=3D message truncated =3D=3D=3D >

_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=3D7+wonders+world&mkt=3Den-US&form=3DQ=
BRE=

--_6f801a6c-87ff-496b-96dc-07c872e3c0c5_
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="acpiconf.tar.gz"

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
Vmur/+zgq6iiiiqqqKKKKvoJ9C8I6IZvACgAAA==

--_6f801a6c-87ff-496b-96dc-07c872e3c0c5_--
