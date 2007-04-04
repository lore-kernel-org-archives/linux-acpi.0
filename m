From: Dominique Michel <dominique.michel@citycable.ch>
Subject: Re: system freeze with acpi
Date: Wed, 4 Apr 2007 08:12:33 +0200
Message-ID: <20070404081233.2f9aa6cf@localhost>
References: <20070331121551.2b9c5dce@localhost>
	<1175642355.3457.14.camel@monteirov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.alinto.citycable.ch ([85.218.0.110]:53861 "HELO
	citycable.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S2992802AbXDDJ6A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Apr 2007 05:58:00 -0400
In-Reply-To: <1175642355.3457.14.camel@monteirov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sergio@sergiomb.no-ip.org, linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

Le Wed, 04 Apr 2007 00:19:15 +0100,
Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> a =C3=A9crit :

> On Sat, 2007-03-31 at 12:15 +0200, Dominique Michel wrote:
>=20
> >=20
> > My problem is at I really want to use CONFIG_X86_PM_TIMER in the AC=
PI
> > config.
> >=20
> > Cheers,
> > Dominique
>=20
>=20
> you should put all this information on bugzilla=20
> http://bugzilla.kernel.org/enter_bug.cgi?product=3DPlatform%20Specifi=
c%2FHardware
>=20

I will do that straight away.

>=20
> and _attach_ all the information on this email,
> what is yours CPU ?
>=20

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 7
cpu MHz         : 2400.154
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4802.05=20
clflush size    : 64

>=20
> Regards=20

Best,
Dominique
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
