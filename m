From: "Karl H. Beckers" <karl.h.beckers-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: 2.6.14.3 suspend/resume with SMP (HT)
Date: Mon, 19 Dec 2005 21:20:38 +0100
Message-ID: <1135023638.18094.4.camel@localhost.localdomain>
References: <59D45D057E9702469E5775CBB56411F10120CC53@pdsmsx406>
	 <1134764243.27534.4.camel@localhost.localdomain>
	 <43A35C09.9040809@ch.risto.ph>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-v24DE48Kcc+7+bPeRMBO"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <43A35C09.9040809-TsugTnnrXQsdc6zLPptBHg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Christoph Galler <listen-TsugTnnrXQsdc6zLPptBHg@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-v24DE48Kcc+7+bPeRMBO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Christoph, Shaohua,

I do have hotplug_cpu configured into my kernel and disabling/enabling
CPUs works just as well in the situation where I did my suspend, s.
below.

Could it be the setting idle=halt is causing problems? I need that (or
max_cstate=1 to keep my CPU up to speed) ... otherwise I get boottimes
of an hour) found a patch that didn't help me, so I sticked to the boot
param. Haven't gotten round to testing without the param because it
would take a matter of hours to boot and suspend :S
Probable cause here?

Thanks,

Karl.






--=-v24DE48Kcc+7+bPeRMBO
Content-Disposition: attachment; filename=typescript
Content-Type: text/plain; name=typescript; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Script started on Mon Dec 19 21:04:00 2005
root@ubuntu:~# lsmod=20
Module                  Size  Used by
wbsd                   19080  0=20
mmc_core               25088  1 wbsd
floppy                 63364  0=20
pcspkr                  4072  0=20
rtc                     9748  0=20
ohci1394               35508  0=20
tpm_atmel               6144  0=20
tpm_infineon            9872  0=20
tpm_nsc                 7168  0=20
tpm                    10656  3 tpm_atmel,tpm_infineon,tpm_nsc
shpchp                 98180  0=20
pci_hotplug            29764  1 shpchp
intel_agp              23708  1=20
agpgart                35920  1 intel_agp
vfat                   14336  0=20
fat                    54428  1 vfat
dm_mod                 59804  4=20
sbp2                   24324  0=20
ieee1394              101720  2 ohci1394,sbp2
psmouse                38788  0=20
parport_pc             36548  1=20
lp                     12420  0=20
parport                37960  2 parport_pc,lp
st                     42144  0=20
scsi_mod              141320  2 sbp2,st
ext3                  142088  4=20
jbd                    63764  1 ext3
thermal                13576  0=20
processor              25924  1 thermal
fan                     4868  0=20
usbhid                 39136  0=20
8139too                29184  0=20
8139cp                 22912  0=20
mii                     5888  2 8139too,8139cp
usbcore               123520  2 usbhid
ide_cd                 42628  0=20
cdrom                  40480  1 ide_cd
ide_disk               19200  4=20
ide_generic             1536  0 [permanent]
piix                   10884  0 [permanent]
generic                 4868  0 [permanent]
ide_core              130128  5 ide_cd,ide_disk,ide_generic,piix,generic
unix                   29584  2=20
root@ubuntu:~# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 21:01 ?        00:00:01 init [S]        =20
root         2     1  0 21:01 ?        00:00:00 [migration/0]
root         3     1  0 21:01 ?        00:00:00 [ksoftirqd/0]
root         4     1  0 21:01 ?        00:00:00 [migration/1]
root         5     1  0 21:01 ?        00:00:00 [ksoftirqd/1]
root         6     1  0 21:01 ?        00:00:00 [events/0]
root         7     1  0 21:01 ?        00:00:00 [events/1]
root         8     1  0 21:01 ?        00:00:00 [khelper]
root         9     1  0 21:01 ?        00:00:00 [kthread]
root        12     9  0 21:01 ?        00:00:00 [kacpid]
root       100     9  0 21:01 ?        00:00:00 [kblockd/0]
root       101     9  0 21:01 ?        00:00:00 [kblockd/1]
root       130     9  0 21:01 ?        00:00:00 [pdflush]
root       131     9  0 21:01 ?        00:00:00 [pdflush]
root       132     1  0 21:01 ?        00:00:00 [kswapd0]
root       133     9  0 21:01 ?        00:00:00 [aio/0]
root       134     9  0 21:01 ?        00:00:00 [aio/1]
root       721     9  0 21:01 ?        00:00:00 [kseriod]
root       759     1  0 21:01 ?        00:00:00 [kirqd]
root      4886     9  0 21:01 ?        00:00:00 [khubd]
root      9201     1  0 21:01 ?        00:00:00 [kjournald]
root      9557     1  0 21:01 ?        00:00:00 udevd --daemon
root     13607     1  0 21:01 ?        00:00:00 [khpsbpkt]
root     13927     1  0 21:01 ?        00:00:00 [kjournald]
root     13928     1  0 21:01 ?        00:00:00 [kjournald]
root     13929     1  0 21:01 ?        00:00:00 [kjournald]
root     14207     1  0 21:01 ?        00:00:00 [shpchpd_event]
root     15061     1  0 21:01 ?        00:00:00 [knodemgrd_0]
root     16185     1  0 21:01 tty1     00:00:00 init [S]        =20
root     16190 16185  0 21:01 tty1     00:00:00 bash
root     17165 16190  0 21:04 tty1     00:00:00 script
root     17166 17165  0 21:04 tty1     00:00:00 script
root     17167 17166  0 21:04 ttyp0    00:00:00 bash -i
root     17177 17167  0 21:04 ttyp0    00:00:00 ps -ef
root@ubuntu:~# echo "platform"=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08=
 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08=08 =08echo 0 > /sys/d=
evices/system/cpu/cpu=07
cpu0/ cpu1/=20
root@ubuntu:~# echo 0 > /sys/devices/system/cpu/cpu1/online
root@ubuntu:~# echo 0 > /sys/devices/system/cpu/cpu1/online=08=08=08=08=08=
=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=08=
=08=08=08=08=08=08=08=08=08=1B[1P=1B[1@1
root@ubuntu:~# echo /sys/devices/system/cpu/cp=07u1/=08 =08=08 =08?/online
/sys/devices/system/cpu/cpu0/online /sys/devices/system/cpu/cpu1/online
root@ubuntu:~# echo /sys/devices/system/cpu/cpu?/online=0Droot@ubuntu:~# ec=
ho=08=1B[1P=08=1B[1P=08=1B[1P=08=1B[1P=1B[1@c=1B[1@a=1B[1@t
1
1
root@ubuntu:~# gre=08 =08=08 =08=08 =08=07g=08 =08zgrep -i ht=08 =08otplug_=
cpu /proc/config.gz=20
CONFIG_ACPI_HOTPLUG_CPU=3Dy
CONFIG_HOTPLUG_CPU=3Dy
root@ubuntu:~# exit

Script done on Mon Dec 19 21:06:43 2005

--=-v24DE48Kcc+7+bPeRMBO--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
