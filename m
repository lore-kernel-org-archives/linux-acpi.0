From: Matt Hempel <mhempel@twentybricks.com>
Subject: No THERMAL on the Asus P5LD2
Date: Wed, 31 Jan 2007 08:51:09 -0800
Message-ID: <45C0C8FD.6040604@twentybricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([63.240.77.82]:46509 "EHLO
	sccrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932975AbXAaRAp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Jan 2007 12:00:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by private.twentybricks.com (Postfix) with ESMTP id 4870D9A0668
	for <linux-acpi@vger.kernel.org>; Wed, 31 Jan 2007 08:51:09 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


I'm running Ubuntu 6.10 (Edgy Eft) on an Asus P5LD2 motherboard. 

I've tried a few things to get thermal readings off my Pentium D 3.4, 
but thus far have failed. 

Adding pnpacpi=off didn't fix it.  Changing ACPI versions in the BIOS 
didn't fix it, either.

I don't know if it's relevant, but I do get thermal readings off my 
NVIDIA card's GPU.

Following are kernel versions, /proc/acpi tree and lsmod output.  Any 
help is appreciated.

--m

mhempel@mhempel-desktop:~$ uname -a
Linux mhempel-desktop 2.6.17-10-generic #2 SMP Tue Dec 5 22:28:26 UTC 
2006 i686 GNU/Linux
mhempel@mhempel-desktop:~$

mhempel@mhempel-desktop:~$ find /proc/acpi/
/proc/acpi/
/proc/acpi/video
/proc/acpi/wmi
/proc/acpi/sony
/proc/acpi/hotkey
/proc/acpi/hotkey/info
/proc/acpi/hotkey/action
/proc/acpi/hotkey/poll_config
/proc/acpi/hotkey/event_config
/proc/acpi/button
/proc/acpi/button/power
/proc/acpi/button/power/PWRB
/proc/acpi/button/power/PWRB/info
/proc/acpi/button/power/PWRF
/proc/acpi/button/power/PWRF/info
/proc/acpi/battery
/proc/acpi/ac_adapter
/proc/acpi/thermal_zone
/proc/acpi/processor
/proc/acpi/processor/CPU2
/proc/acpi/processor/CPU2/power
/proc/acpi/processor/CPU2/limit
/proc/acpi/processor/CPU2/throttling
/proc/acpi/processor/CPU2/info
/proc/acpi/processor/CPU1
/proc/acpi/processor/CPU1/power
/proc/acpi/processor/CPU1/limit
/proc/acpi/processor/CPU1/throttling
/proc/acpi/processor/CPU1/info
/proc/acpi/fan
/proc/acpi/wakeup
/proc/acpi/alarm
/proc/acpi/sleep
/proc/acpi/event
/proc/acpi/fadt
/proc/acpi/dsdt
/proc/acpi/info
/proc/acpi/power_resource
/proc/acpi/embedded_controller
mhempel@mhempel-desktop:~$


mhempel@mhempel-desktop:~$ lsmod | sort
ac                      6788  0
af_packet              24584  0
agpgart                34888  2 nvidia,intel_agp
asus_acpi              17688  0
ata_piix               11780  2
battery                11652  0
binfmt_misc            13448  1
bitblit                 7168  1 fbcon
bluetooth              53476  4 rfcomm,l2cap
button                  7952  0
capability              5896  0
cdrom                  38944  1 ide_cd
commoncap               8704  1 capability
container               5632  0
cpufreq_conservative     8712  0
cpufreq_ondemand        8876  2
cpufreq_powersave       2944  0
cpufreq_stats           7744  0
cpufreq_userspace       5408  0
dev_acpi               12292  0
ehci_hcd               34696  0
evdev                  11392  1
exportfs                7296  1 nfsd
ext2                   71432  1
ext3                  142728  1
fan                     6020  0
fat                    56348  1 vfat
fbcon                  41504  0
floppy                 63044  0
font                    9344  1 fbcon
freq_table              6048  2 speedstep_centrino,cpufreq_stats
generic                 6276  0
hotkey                 11556  0
i2c_core               23424  2 nvidia,i2c_ec
i2c_ec                  6272  1 sbs
ide_cd                 33696  0
ide_generic             2432  0
intel_agp              26012  1
it821x                  9860  0 [permanent]
jbd                    62228  1 ext3
l2cap                  27136  5 rfcomm
libata                 74892  1 ata_piix
libusual               17040  1 usb_storage
lockd                  67976  2 nfsd
lp                     12964  0
Module                  Size  Used by
nfsd                  234276  13
nls_cp437               6912  0
nls_utf8                3200  0
nvidia               6830836  22
parport                39496  2 lp,parport_pc
parport_pc             37796  1
pcc_acpi               14080  0
pci_hotplug            32828  1 shpchp
pcspkr                  4352  0
piix                   11780  1
processor              31560  2 speedstep_centrino,thermal
psmouse                41352  0
rfcomm                 42260  0
sbs                    16804  0
scsi_mod              144648  4 usb_storage,sg,sd_mod,libata
sd_mod                 22656  5
serio_raw               8452  0
sg                     37404  0
shpchp                 42144  0
sk98lin               191700  0
sky2                   43012  0
snd                    58372  10 
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
snd_hda_codec         164608  1 snd_hda_intel
snd_hda_intel          20116  2
snd_mixer_oss          19584  1 snd_pcm_oss
snd_page_alloc         11400  2 snd_hda_intel,snd_pcm
snd_pcm                84612  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_pcm_oss            47360  0
snd_timer              25348  1 snd_pcm
softcursor              3328  1 bitblit
sony_acpi               6412  0
soundcore              11232  1 snd
speedstep_centrino      9760  1
sunrpc                165948  8 nfsd,lockd
tc1100_wmi              8324  0
thermal                15624  0
tileblit                3840  1 fbcon
tsdev                   9152  0
uhci_hcd               24968  0
usbcore               134912  6 
usbhid,usb_storage,libusual,ehci_hcd,uhci_hcd
usbhid                 45152  0
usb_storage            75072  1
vesafb                  9244  0
vfat                   14720  0
video                  17540  0
vmmon                 118668  0
vmnet                  41900  3
mhempel@mhempel-desktop:~$
