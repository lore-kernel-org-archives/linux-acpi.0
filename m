From: Chris Howells <chrish-puGfsi27rH1aa/9Udqfwiw@public.gmane.org>
Subject: Re: Not enough IRQs for multiple PCMCIA cards
Date: Sat, 10 May 2003 17:57:27 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305101757.28014.chrish@gmx.co.uk>
References: <200305100148.12713.chrish@gmx.co.uk> <20030510160610.4cb621e6.nils@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030510160610.4cb621e6.nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Content-Description: clearsigned data
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Nils,

On Saturday 10 May 2003 15:06, Nils Faerber wrote:
> For the record:
> 	I have exactly the same problem.

Whew, in some ways that's a relief :)

> > Regrettably, my BIOS (Award Asus L3800C BIOS) does not give me any
> > control how IRQs are designed or PnP OS settings.
>
> I have even the same machine :)

Yeah, I remember you helped answer a few questions of mine when I was think=
ing=20
of buying the machine. I don't know if this particular machine is bad at=20
controlling IRQ settings, or if all machines these days have such problems.

> OK.
> It is quite important to know a litle more about your setup.
> Why?
> I have tried with several kernels, pcmcia packages and configurations.
> Some worked, some not.

I'm currently using SuSE 8.2 with the stock SuSE 8.2 2.4.20-4GB kernel. I'm=
=20
using the pcmcia-cs provided with SuSE 8.2 as well, and I've tried with bot=
h=20
the orinoco and hostap drivers.

chris@galadriel:~> rpm -qa | grep pcmcia
pcmcia-3.2.3-47

> Do you use kernel pcmcia or the PCMCIA drivers from pcmcia-cs?

I'm using kernel PCMCIA, I've tried pcmcia-cs (just a matter of changing a=
=20
setting in /etc/sysconfig/pcmcia on SuSE), but it didn't help.

> 	I currently use kernel pcmcia which currently does not work with twi
> cards.
>
> Which PCMCIA (cardbus) chipset driver do you use?
> 	I strongly recommend to use the kernel yenta socket driver! This gives
> best results with cardbus cards.

I must admit I haven't really tried any different kernels. I wonder if=20
upgrading to 2.4.21-pre would help....

chris@galadriel:~> /sbin/lsmod | grep yenta
yenta_socket            9760   2
pcmcia_core            41824   0 [serial_cs hostap_cs ds yenta_socket]

> Some earlier kernel version with ACPI patch applied worked with
> pci=3Dnoacpi but this seems to have almost no effect on more recent
> kernels. I currently use 2.4.21-pre4 with ACPI 20030228.

Yeah, using ACPI for IRQ routing seems to work sometimes, though only very=
=20
rarely. Is there any reason why it doesn't seem possible to control the way=
=20
that ACPI allocates IRQs?

> Then there are some problems with certain PCMCIA drivers.
> In theory they should be able to share the one assigned interrupt. The
> serial_cs driver does so AFAIK. But many other drivers don't, like
> ide_cs. So some combinations may work, some not.

Ah, that's interesting. What kind of devices can serial_cs share IRQs with?=
=20
PCI devices? How do I make it do that? Does it do it by default?

> This whole situation is, like you said, very unsatisfying :(

Yes, indeed. Previously it worked _sometimes_ (finding a valid IRQ to use) =
but=20
it's stopped working now, I don't know why.

It's quite frustrating that Windows XP manages to handle IRQ allocation in =
a=20
more satisfactory manner. (e.g. it gives the PCMCIA cards their own IRQ whi=
le=20
making more of the PCI devices share their own IRQs).

> It is a real pain that there is no decent APIC in uniprocessor systems

I must admit I'm not too familiar with APICs. Does the Asus laptop have one=
 at=20
all?

> in order to have more than those shitty 15 IRQs... it's a shame... x86
> hardware is really crappy at times but there is not much of an
> alternative especially for notebooks :( (Oh oh ... no flame war start
> please!)

Yeah. I'm pretty sure my next laptop will be a Apple PowerBook :) Having a=
=20
laptop which doesn't overheat if I use it on the bed will also be a novelty=
=20
:)

=2D --=20
Cheers, Chris Howells -- chris-NvB7AskkBIqIudiWw5vspbVCufUGDwFn@public.gmane.org, howells@kde.org
Web: http://chrishowells.co.uk, PGP ID: 33795A2C
KDE: http://www.koffice.org, http://printing.kde.org, http://usability.kde.=
org

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD4DBQE+vS93F8Iu1zN5WiwRAtRRAJinMjTl0KjtqYx7vEDgtoEnEx49AJ4misgZ
Py/oxp12CUb7r54meWBqnA=3D=3D
=3D+C0Q
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
