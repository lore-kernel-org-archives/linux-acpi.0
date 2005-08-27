From: Fred Blaise <chapeaurouge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: issues with acpi events
Date: Sat, 27 Aug 2005 10:19:51 +0200
Message-ID: <9cfa1502050827011924cf0304@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello all

I own a Dell Inspiron 5150, 3.06Ghz bought about 1 1/2 year ago.
Running Ubuntu Hoary.
I have several issues with acpi, and would like to get your thought on
them. Loaded modules at the bottom of the mail.

My acpi version:
ii  acpi           0.07-3       =20
ii  acpi-support   0.21    =20
ii  acpid          1.0.4-1ubuntu4

My main problem is battery. If I start up the machine with the battery
plugged in, then linux will see it, and show me percentage remaining,
etc.. however, once linux is started, i do not receive any events from
the battery. I can plug/unplug it, nothing comes through. Any idea?
Note: When I unplug/plug my AC power, i get the events.

Cpufreq works with powernowd deamon. The CPU speed is going up/down
quite nicely depending on load. However, one day, I let my CPU at
383Mhz (the lowest it can) for a while, and my battery didn't seem to
tell me it could last any longer than when running at 3.06Ghz. But I
guess it could be related to the above problem.

Suspend-2-ram works fine. I still need to on Suspend-2-disk, however.
It tells me if frees memory for a while.. then screen goes black, but
it never shuts down, forcing me to do a 'hard' shutdown.

Do you think I need to upgrade my Dell BIOS? I looked on Dell's
website, there has been quite a few out since I bought the laptop, but
I haven't seen anything in their Changelog directly related to my
issues.

Thanks a lot.

Fred
-----------------------
Loaded modules:
Module                  Size  Used by
af_packet              21640  2=20
vmnet                  30844  14=20
vmmon                 171340  0=20
binfmt_misc            11464  1=20
proc_intf               4004  0=20
cpufreq_powersave       1632  0=20
cpufreq_userspace       4348  1=20
cpufreq_ondemand        6300  0=20
video                  15940  0=20
battery                 9988  0=20
container               4320  0=20
button                  6480  0=20
pcc_acpi               11008  0=20
sony_acpi               5928  0=20
ac                      4676  0=20
ipv6                  255136  13=20
pcmcia                 22468  2=20
driverloader          333712  0=20
ohci1394               34596  0=20
yenta_socket           22048  1=20
pcmcia_core            59552  2 pcmcia,yenta_socket
b44                    22148  0=20
mii                     4960  1 b44
snd_intel8x0           32704  2=20
snd_ac97_codec         76384  1 snd_intel8x0
snd_pcm_oss            53572  1=20
snd_mixer_oss          19904  1 snd_pcm_oss
snd_pcm                95496  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              24484  1 snd_pcm
snd                    55012  8 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd=
_mixe
r_oss,snd_pcm,snd_timer
soundcore               9664  2 snd
snd_page_alloc          9956  2 snd_intel8x0,snd_pcm
usbhid                 32544  0=20
ehci_hcd               32740  0=20
uhci_hcd               33296  0=20
usbcore               119928  5 driverloader,usbhid,ehci_hcd,uhci_hcd
pci_hotplug            33072  0=20
pcspkr                  3336  0=20
rtc                    11800  0=20
md                     47408  0=20
dm_snapshot            19004  0=20
dm_mod                 61660  9 dm_snapshot
p4_clockmod             4872  0=20
speedstep_lib           4068  1 p4_clockmod
freq_table              4036  1 p4_clockmod
nvidia               3922684  10=20
agpgart                34376  1 nvidia
tsdev                   7680  0=20
evdev                   9536  1=20
joydev                  9920  0=20
sr_mod                 17444  0=20
sbp2                   23976  0=20
scsi_mod              128704  2 sr_mod,sbp2
ieee1394              110040  2 ohci1394,sbp2
psmouse                21864  0=20
mousedev               11416  1=20
parport_pc             37476  0=20
lp                     11656  0=20
parport                36872  2 parport_pc,lp
ide_cd                 42500  0=20
cdrom                  41340  2 sr_mod,ide_cd
reiserfs              269360  8=20
ext2                   67240  0=20
ext3                  139048  0=20
jbd                    57848  1 ext3
mbcache                 7940  2 ext2,ext3
ide_generic             1312  0=20
ide_disk               20896  5=20
piix                   10436  1=20
ide_core              131180  4 ide_cd,ide_generic,ide_disk,piix
unix                   27284  1095=20
thermal                13288  0=20
processor              22196  1 thermal
fan                     4388  0


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
