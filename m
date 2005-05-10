From: forum.viennet-GANU6spQydw@public.gmane.org
Subject: Cpufreq fails to stop on my laptop (athlon 64 3700+ socket 754 / kernel 2.6.11-6 )
Date: Tue, 10 May 2005 22:41:55 +0200
Message-ID: <1115757715.42811c933aa6f@imp5-q.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hellow

I've a problem with cpufreq on my laptop (fujitsu-siemens amilo 1630-3702
with athlon 64 3700+ socket 754).
I've installed Mandrake 10.2 32 bits with the kernel 2.6.11-6,
but the computer won't shutdown.

When the computer runs, it seems to be OK.

I've tried the 64 bits version, and there is the same problem.
The problem is with kernel-2.6.11-6 and kernel-2.6.11-6-smp.

Without cpufreq and acpi, it is OK, but it works only 800 Mhz !!

Help please !

Excuse my bad english, I'm french.

Olivier V

/var/log/messages :

May=A0=A07=A019:33:48=A0localhost=A0cpufreqd:=A0Arr=EAt=A0de=A0cpufreqd=A0=
succeeded
May=A0=A07=A019:33:48=A0localhost=A0cpufreq:=A0D=E9chargement=A0des=A0mod=
ules=A0cpufreq=A0:=A0
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0Unable=A0to=A0handle=A0kern=
el=A0NULL=A0pointer
dereference at virtual address 0000002c
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0printing=A0eip:
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0f8fc4f14
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0*pde=A0=3D=A037532001
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0Oops:=A00000=A0[#1]
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0Modules=A0linked=A0in:=A0nl=
s_iso8859-1=A0nls_cp437
cpufreq_ondemand powernow-k8 raw md5 ipv6 rfcomm l2cap bluetooth
snd-seq-dummy snd-seq-oss snd-seq-midi-event snd-seq snd-seq-device
snd-pcm-oss snd-mixer-oss snd-intel8x0 snd-ac97-codec snd-pcm snd-timer
snd-page-alloc snd soundcore af_packet pcmcia yenta_socket rsrc_nonstatic
pcmcia_core video thermal tc1100-wmi processor fan container button batte=
ry
ac eth1394 sis900 ide-cd ohci1394 ieee1394 loop nls_cp850 vfat fat
nls_iso8859-15 ntfs sis-agp amd64-agp agpgart nvram evdev sd_mod
usb-storage scsi_mod ehci-hcd ohci-hcd usbcore ext3 jbd
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0CPU:=A0=A0=A0=A00
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0EIP:=A0=A0=A0=A00060:[pg0+9=
51295764/1068971008]=A0=A0=A0
Not tainted VLI
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0EIP:=A0=A0=A0=A00060:[<f8fc=
4f14>]=A0=A0=A0=A0Not=A0tainted
VLI
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0EFLAGS:=A000010286=A0=A0=A0=
(2.6.11-6mdk)=A0
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0EIP=A0is=A0at
acpi_processor_unregister_performance+0x24/0x48 [processor]
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0eax:=A000000000=A0=A0=A0ebx=
:=A0f79ac000=A0=A0=A0ecx:
f8c3d280=A0=A0=A0edx:=A0f76d7880
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0esi:=A0f7583d80=A0=A0=A0edi=
:=A0f7583dfc=A0=A0=A0ebp:
f77fbe50=A0=A0=A0esp:=A0f77fbe4c
May=A0=A07=A019:33:48=A0localhost=A0cpufreq:=A0/etc/rc0.d/K35cpufreq:=A0l=
ine=A0199:=A013411
Segmentation fault=A0=A0=A0=A0=A0=A0rmmod=A0$MODULE=A02>/dev/null
May=A0=A07=A019:33:48=A0localhost=A0cpufreq:=A0=A0failed
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0ds:=A0007b=A0=A0=A0es:=A000=
7b=A0=A0=A0ss:=A00068
May=A0=A07=A019:33:48=A0localhost=A0cpufreq:=A0^[[65G[^[[1;31m
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0Process=A0rmmod=A0(pid:=A01=
3411,
threadinfo=3Df77fa000 task=3Df7079570)
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0Stack:=A0f76d7880=A0f77fbe6=
0=A0f8c3cfc3=A0f76d78ac
00000000 f77fbe74 f8c3d2aa f76d7880
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0=A0=A0=A0=A0=A0=A0f7583d=
80=A000000002=A0f77fbe90=A0c02cdfae
f7583d80 00000002 c0434d88 c03b7918
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0=A0=A0=A0=A0=A0=A0c03b19=
fc=A0f77fbea8=A0c0280d78=A0c0434d88
f8c3d360 f8c3e920 00000000 f77fbeb8
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0Call=A0Trace:
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[show_stack+127/160]=A0s=
how_stack+0x7f/0xa0
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<c0103c4f>]=A0show_stac=
k+0x7f/0xa0
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[show_registers+342/464]
show_registers+0x156/0x1d0
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<c0103de6>]=A0show_regi=
sters+0x156/0x1d0
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[die+200/336]=A0die+0xc8=
/0x150
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<c0103fe8>]=A0die+0xc8/=
0x150
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[do_page_fault+1146/1818=
]
do_page_fault+0x47a/0x71a
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<c011637a>]=A0do_page_f=
ault+0x47a/0x71a
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[error_code+43/48]=A0err=
or_code+0x2b/0x30
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<c01038eb>]=A0error_cod=
e+0x2b/0x30
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[pg0+947593155/106897100=
8]
powernow_k8_cpu_exit_acpi+0x23/0x30 [powernow-k8]
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<f8c3cfc3>]
powernow_k8_cpu_exit_acpi+0x23/0x30 [powernow-k8]
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[pg0+947593898/106897100=
8]
powernowk8_cpu_exit+0x2a/0x60 [powernow-k8]
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<f8c3d2aa>]
powernowk8_cpu_exit+0x2a/0x60 [powernow-k8]
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[cpufreq_remove_dev+206/=
240]
cpufreq_remove_dev+0xce/0xf0
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<c02cdfae>]=A0cpufreq_r=
emove_dev+0xce/0xf0
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[sysdev_driver_unregiste=
r+104/176]
sysdev_driver_unregister+0x68/0xb0
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<c0280d78>]
sysdev_driver_unregister+0x68/0xb0
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[cpufreq_unregister_driv=
er+48/65]
cpufreq_unregister_driver+0x30/0x41
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<c02ceab0>]
cpufreq_unregister_driver+0x30/0x41
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[pg0+947594098/106897100=
8]
powernowk8_exit+0x12/0x14 [powernow-k8]
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<f8c3d372>]=A0powernowk=
8_exit+0x12/0x14
[powernow-k8]
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[sys_delete_module+588/6=
08]
sys_delete_module+0x24c/0x260
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<c0188bdc>]
sys_delete_module+0x24c/0x260
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[sysenter_past_esp+82/11=
7]
sysenter_past_esp+0x52/0x75
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0=A0[<c0102e5d>]=A0sysenter_=
past_esp+0x52/0x75
May=A0=A07=A019:33:48=A0localhost=A0kernel:=A0Code:=A031=A0c0=A08b=A05d=A0=
fc=A0c9=A0c3=A055=A089=A0e5=A053=A0ff
0d 4c 75 fc f8 0f 88 a8 00 00 00 8b 45 0c 8b 1c 85 c4 76 fc f8 85 db 74 1=
9
8b 83 6c 02 00 00 <ff> 70 2c e8 f4 59 1d c7 c7 83 6c 02 00 00 00 00 00 00
59 ff 05
May=A0=A07=A019:33:48=A0localhost=A0cpufreq:=A0=C9CHEC=A0
May=A0=A07=A019:33:48=A0localhost=A0cpufreq:=A0
May=A0=A07=A019:33:48=A0localhost=A0rc:=A0Arr=EAt=A0de=A0cpufreq=A0:=A0=A0=
failed



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
