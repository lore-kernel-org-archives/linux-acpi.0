From: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
Subject: [OOPS] Suspend-to-RAM op 2.6.17.7
Date: Mon, 7 Aug 2006 18:01:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0608071759410.8265@jdi.jdi-ict.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from jdi.jdi-ict.nl ([82.94.239.5]:21420 "EHLO jdi.jdi-ict.nl")
	by vger.kernel.org with ESMTP id S1750785AbWHGQB0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2006 12:01:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by jdi.jdi-ict.nl (8.13.7/8.12.11) with ESMTP id k77G1L4T003737
	for <linux-acpi@vger.kernel.org>; Mon, 7 Aug 2006 18:01:21 +0200
Received: from jdi.jdi-ict.nl (localhost [127.0.0.1])
	by jdi.jdi-ict.nl (8.13.7/8.12.11) with ESMTP id k77G19Gn019305
	for <linux-acpi@vger.kernel.org>; Mon, 7 Aug 2006 18:01:09 +0200
Received: from localhost (igmar@localhost)
	by jdi.jdi-ict.nl (8.13.7/8.12.11/Submit) with ESMTP id k77G19g5008151
	for <linux-acpi@vger.kernel.org>; Mon, 7 Aug 2006 18:01:09 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Hi,

2.6.17.7 oopses when doing a suspend-to-ram. See the bugreport below. I 
can easely test patches etc, it's 100% reproducable.


regards,


	Igmar 


[1.] One line summary of the problem:

Suspend-to-RAM oopses with 2.6.17.7

[2.] Full description of the problem/report:

Doing a echo 3 > /proc/acpi/sleep makes this system Oops. It's 100%
reproducable 2.6.15.x didn't had this behaviour

[3.] Keywords (i.e., modules, networking, kernel):

ACPI

[4.] Kernel version (from /proc/version):

Linux version 2.6.17.7-grsec (igmar@ouzo.office.jdi-ict.nl) (gcc version 3.4.5 20051201 (Red Hat 3.4.5-2)) #1 Mon Jul 31 08:35:13 CEST 2006

[5.] Most recent kernel version which did not have the bug:

2.6.14.x

[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Hand-copied :

EIP:    0060:[<0000e1ec>]    Not tainted VLI
EFLAGS: 00010006   (2.6.17.7-grsec #1)
EIP is at acpi_save_state_mem+0x3b/0x55
eax: 00000ff0   ebx: 00000003   ecx: 000003fc   edx: 00000300
esi: 0000f000   edi: c0001000   ebp: 00000002   esp: f68adeb0
ds: 0068   es: 0068   ss: 0068
Process standby (pid: 3978, threadinfo=f68ac000 task=f799ba50)
Stack: 00000003 00000000 00116e23 00000000 00000246 c062aec1 00000002 00031297
       00000003 00000000 00000003 00031329 00000003 00000003 f68adf2d c0116f0e
       00000003 00000000 00000001 00000000 00000003 00000004 00000005 f68adf2c
Call Trace:
 <00116e23> <00031297>
 <00031329> <00116f0e>
 <00116ff0> <0004ae5c>
 <0004af91> <00003bb7>

Code: 68 00 03 00 00 be 00 f0 00 00 68 00 30 5f c0 e8 73 ff ff ff 58 b8 f0 ff 00
00 2d 00 f0 00 00 89 c1 8b 3d 48 5b c6 c0 c1 e9 02 5a <f3> a5 89 c1 83 e1 03 74
02 f3 a4 a1 48 5b c6 c0 e8 5f 1e 00 00
EIP: [<0000e1ec>] acpi_save_state_mem+0x3b/0x55 SS:ESP 0068:f68adeb0

[8.1.] Software (add the output of the ver_linux script here)

Gnu C                  3.4.5
Gnu make               3.80
binutils               2.17
util-linux             2.12a
mount                  2.12a
module-init-tools      3.1-pre5
e2fsprogs              1.35
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   039
Modules Loaded         ieee80211_crypt_tkip lp sunrpc pcmcia yenta_socket rsrc_nonstatic pcmcia_core uhci_hcd ehci_hcd usbcore snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ipw2200 ieee80211 ieee80211_crypt

[8.2.] Processor information (from /proc/cpuinfo):


processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.70GHz
stepping        : 6
cpu MHz         : 600.000
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe up est tm2
bogomips        : 1197.54

[8.3.] Module information (from /proc/modules):

ieee80211_crypt_tkip 10397 2 - Live 0xc084a000 0xf88e5000
lp 10003 0 - Live 0xc0846000 0xf88e3000
sunrpc 148856 1 - Live 0xc0824000 0xf88d6000
pcmcia 33841 4 - Live 0xc081b000 0xf88e1000
yenta_socket 24364 4 - Live 0xc0814000 0xf88ca000
rsrc_nonstatic 12820 1 yenta_socket, Live 0xc0810000 0xf88d4000
pcmcia_core 38295 3 pcmcia,yenta_socket,rsrc_nonstatic, Live 0xc0805000 0xf88c8000
uhci_hcd 22399 0 - Live 0xc07fe000 0xf88d2000
ehci_hcd 30340 0 - Live 0xc07f5000 0xf88d0000
usbcore 125280 3 uhci_hcd,ehci_hcd, Live 0xc07d6000 0xf88ec000
snd_intel8x0 32146 2 - Live 0xc07ce000 0xf887d000
snd_ac97_codec 101697 1 snd_intel8x0, Live 0xc07b4000 0xf8876000
snd_ac97_bus 2022 1 snd_ac97_codec, Live 0xc07b2000 0xf8878000
snd_pcm_oss 43551 0 - Live 0xc07a6000 0xf8874000
snd_mixer_oss 19259 2 snd_pcm_oss, Live 0xc07a0000 0xf887b000
snd_pcm 82361 3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss, Live 0xc078b000 0xf8872000
snd_timer 21552 1 snd_pcm, Live 0xc0784000 0xf886c000
snd 48510 8 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer, Live 0xc0777000 0xf886a000
soundcore 7975 2 snd, Live 0xc0774000 0xf8870000
snd_page_alloc 8897 2 snd_intel8x0,snd_pcm, Live 0xc0770000 0xf886e000
ipw2200 107070 0 - Live 0xc0755000 0xf8866000
ieee80211 30995 1 ipw2200, Live 0xc074c000 0xf8861000
ieee80211_crypt 4499 2 ieee80211_crypt_tkip,ieee80211, Live 0xc074a000 0xf8864000


-- 
Igmar Palsenberg
JDI ICT

Zutphensestraatweg 85
6953 CJ Dieren
Tel: +31 (0)313 - 496741
Fax: +31 (0)313 - 420996
The Netherlands

mailto: i.palsenberg@jdi-ict.nl
