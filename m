From: devzero@web.de
Subject: =?iso-8859-15?Q?Re:_acpi=5Fps=5Fexecute=5Fmethod_OOPS_(Re:_some_minor_?=
 =?iso-8859-15?Q?issues_with_2.6.25-rc6-git7-default)?=
Date: Thu, 27 Mar 2008 22:43:52 +0100
Message-ID: <215201015@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmmailgate09.web.de ([217.72.192.184]:49223 "EHLO
	fmmailgate09.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756262AbYC0Vny convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Mar 2008 17:43:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: akpm@linux-foundation.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

> What CPU/chipset is this?

opensuse103:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.80GHz
stepping        : 8
cpu MHz         : 1798.691
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca =
cmov pat clflush dts acpi mmx fxsr sse sse2 ss up pebs bts
bogomips        : 3627.10
clflush size    : 64

opensuse103:~ # lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host=
 bridge (rev 01)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP b=
ridge (rev 01)
00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 08)
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 0=
1)
00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB
00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 08)
00:0f.0 VGA compatible controller: VMware Inc Abstract SVGA II Adapter
00:10.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-=
X Fusion-MPT Dual Ultra320 SCSI (rev 01)
00:11.0 PCI bridge: VMware Inc Unknown device 0790 (rev 02)
02:00.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet=
32 LANCE] (rev 10)


to make sure that you didn`t miss my last post - i already found a poss=
ible correlation:

>i searched into this and found that it only happens after modprobe net=
sc520 ;modprobe -r netsc520.
>so maybe this is no acpi problem at all but corruption (sort of?) intr=
oduced by netsc520 module !?

regards
roland



> -----Urspr=FCngliche Nachricht-----
> Von: "Rafael J. Wysocki" <rjw@sisk.pl>
> Gesendet: 27.03.08 22:09:28
> An: devzero@web.de
> CC: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, akpm@lin=
ux-foundation.org, linux-kernel@vger.kernel.org
> Betreff: Re: acpi_ps_execute_method OOPS (Re: some minor issues with =
2.6.25-rc6-git7-default)


>=20
> On Thursday, 27 of March 2008, devzero@web.de wrote:
> > > On Tuesday 25 March 2008, devzero@web.de wrote:
> > > ...
> > > > this one looks more serious (happened with modprobe -r ac),
> > > > because kernel has problems afterwards (cannot load/anload any =
other module afterwards)=20
> > >=20
> > > any idea when this started happening?
> > > Any chance you can snag the output from acpidump
> > > and attach it to a sighting here?:
> > > http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
> > >=20
> > > thanks,
> > > -Len
> >=20
> > i searched into this and found that it only happens after modprobe =
netsc520 ;modprobe -r netsc520.
> > so maybe this is no acpi problem at all but corruption (sort of?) i=
ntroduced by netsc520 module !?
>=20
> What CPU/chipset is this?
>=20
> Rafael
>=20


_______________________________________________________________________=
__
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten=
!=20
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=3D021114

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
