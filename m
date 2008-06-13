From: Luke Sharkey <lukesharkey@hotmail.co.uk>
Subject: RE: acpi thermal sensors not working, laptop overheating
Date: Fri, 13 Jun 2008 20:58:42 +0100
Message-ID: <BAY114-W336FCEFBA1DC7DE44D891BFAAC0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_2e0ca403-bcd2-4328-8292-50a8d53359ff_"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bay0-omc3-s3.bay0.hotmail.com ([65.54.246.203]:48543 "EHLO
	bay0-omc3-s3.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753350AbYFMT6n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jun 2008 15:58:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

--_2e0ca403-bcd2-4328-8292-50a8d53359ff_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi

>> Example sensors output:
>> k8temp-pci-00c3
>> Adapter: PCI adapter
>> Core0 Temp: +54.0=B0C
>
> 54 degrees is fine.

It would be if that was the highest it went...!

I put that up as an example of the temperature I'm getting with the max cpu=
 frequency set to less than half speed *and* without any cpu load!!  Even b=
rowsing flash web pages at normal cpu frequency ranges can make it shoot up=
 to 60 C.  If I try running a 3D game the on-die temp can go above 70 C, so=
me outputs I recorded:

Adapter: PCI adapter Core0 Temp: +68.0=B0C
Adapter: PCI adapter Core0 Temp: +69.0=B0C
Adapter: PCI adapter Core0 Temp: +69.0=B0C
Adapter: PCI adapter Core0 Temp: +68.0=B0C
Adapter: PCI adapter Core0 Temp: +69.0=B0C
Adapter: PCI adapter Core0 Temp: +70.0=B0C
Adapter: PCI adapter Core0 Temp: +69.0=B0C

If I try unloading k8temp I get no sensor readings at all (except hddtemp).=
  None other are running to the best of my knowledge - see lsmod output bel=
ow.  As the owner of a valid XP licence I tried booting into windows to see=
 if had the same problem.

I ran swiftfan (popular windows sensor utility) it only detected the core a=
nd the hdd temp there too - no detection of an internal CPU temperature on =
windows either!!!  Surely there must be a sensor - how else would the BIOS =
control the fan?

Incidentally, the problem was just as on windows too, except because the us=
er has no control over cpu frequency core0 temperature was hovering around =
~63 C...

I think there's a 100,000 character limit on this list?  I've attached acpi=
dump output as requested, as a .tar.gz .

Cheers,
Luke

LSMOD

Module                  Size  Used by
k8temp                  7680  0
ipv6                  311720  8
binfmt_misc            14860  1
af_packet              27272  2
rfkill_input            6528  0
powernow_k8            16608  0
cpufreq_stats           8416  0
cpufreq_powersave       3200  0
cpufreq_conservative    10632  0
cpufreq_userspace       6180  0
cpufreq_ondemand       11152  1
freq_table              6464  3 powernow_k8,cpufreq_stats,cpufreq_ondemand
sbs                    17808  0
sbshc                   8960  1 sbs
container               6656  0
dock                   12960  0
aes_x86_64             26920  0
dm_crypt               16776  0
dm_mod                 71160  1 dm_crypt
sbp2                   27272  0
parport_pc             41128  0
lp                     14916  0
parport                44300  2 parport_pc,lp
joydev                 15488  0
pcmcia                 45976  0
snd_atiixp             24340  3
snd_ac97_codec        123224  1 snd_atiixp
ac97_bus                3840  1 snd_ac97_codec
snd_pcm_oss            47648  0
snd_pcm                92168  3 snd_atiixp,snd_ac97_codec,snd_pcm_oss
snd_mixer_oss          20224  1 snd_pcm_oss
snd_seq_dummy           5764  0
arc4                    3456  2
ecb                     5248  2
blkcipher               9476  1 ecb
snd_seq_oss            38912  0
snd_seq_midi           10688  0
snd_rawmidi            29856  1 snd_seq_midi
snd_seq_midi_event     10112  2 snd_seq_oss,snd_seq_midi
b43                   126760  0
evdev                  14976  8
snd_seq                63232  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_=
seq_midi_event
serio_raw               9092  0
rfkill                 10128  3 rfkill_input,b43
snd_timer              27912  2 snd_pcm,snd_seq
snd_seq_device         10644  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_=
rawmidi,snd_seq
mac80211              192532  1 b43
psmouse                46236  0
cfg80211               17680  1 mac80211
snd                    70856  17 snd_atiixp,snd_ac97_codec,snd_pcm_oss,snd_=
pcm,snd_mixer_oss,snd_seq_dummy,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,s=
nd_seq_device
led_class               7176  1 b43
hsfmc97ati             83744  0
hsfserial              28068  1 hsfmc97ati
pcspkr                  4992  0
soundcore              10400  1 snd
input_polldev           6928  1 b43
hsfengine            1608472  2 hsfmc97ati,hsfserial
snd_page_alloc         13200  2 snd_atiixp,snd_pcm
sdhci                  21508  0
hsfosspec             122384  4 hsfmc97ati,hsfserial,hsfengine
hsfsoar               108408  1 hsfmc97ati
tifm_7xx1               9984  0
mmc_core               59272  1 sdhci
tifm_core              13064  1 tifm_7xx1
yenta_socket           30092  1
rsrc_nonstatic         14080  1 yenta_socket
pcmcia_core            46116  3 pcmcia,yenta_socket,rsrc_nonstatic
video                  23444  0
output                  5632  1 video
battery                16776  0
fglrx                1804800  26
ac                      8328  0
wmi_acer               11076  0
button                 10912  0
i2c_piix4              11148  0
i2c_core               28544  1 i2c_piix4
shpchp                 38172  0
pci_hotplug            34608  1 shpchp
xt_tcpudp               4992  14
xt_limit                4608  2
nf_conntrack_ipv4      21904  17
xt_state                4096  17
ipt_LOG                 8192  2
ipt_REJECT              6528  2
nf_conntrack_ftp       11688  0
nf_conntrack           79216  3 nf_conntrack_ipv4,xt_state,nf_conntrack_ftp
iptable_filter          4608  1
ip_tables              24104  1 iptable_filter
x_tables               23560  6 xt_tcpudp,xt_limit,xt_state,ipt_LOG,ipt_REJ=
ECT,ip_tables
ext3                  149264  1
jbd                    57000  1 ext3
mbcache                11392  1 ext3
ide_cd                 35488  0
cdrom                  41512  1 ide_cd
ide_disk               19072  4
pata_atiixp            10496  0
ata_generic             9988  0
8139too                31104  0
pata_acpi               9856  0
libata                176304  3 pata_atiixp,ata_generic,pata_acpi
scsi_mod              178488  2 sbp2,libata
8139cp                 27776  0
mii                     7552  2 8139too,8139cp
ohci1394               36532  0
ieee1394              106968  2 sbp2,ohci1394
ssb                    37252  1 b43
atiixp                  6672  0 [permanent]
ide_core              136600  3 ide_cd,ide_disk,atiixp
ehci_hcd               41996  0
ohci_hcd               27524  0
usbcore               169904  4 hsfosspec,ehci_hcd,ohci_hcd
thermal                19744  0
processor              41448  3 powernow_k8,thermal
fan                     6792  0
fbcon                  46336  0
tileblit                4096  1 fbcon
font                   10112  1 fbcon
bitblit                 7424  1 fbcon
softcursor              3712  1 bitblit
fuse                   56112  5



_________________________________________________________________

http://clk.atdmt.com/UKM/go/msnnkmgl0010000002ukm/direct/01/=

--_2e0ca403-bcd2-4328-8292-50a8d53359ff_
Content-Type: application/x-gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="acpidump.txt.tar.gz"

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
AIACAA==

--_2e0ca403-bcd2-4328-8292-50a8d53359ff_--
