From: Jaap Hogenberg <hogenberg11-RSh1/+X/PmFmR6Xm/wNWPw@public.gmane.org>
Subject: Re: Kernel with acpi hangs on compaq presario 1700
Date: Sun, 15 Dec 2002 14:47:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212151447.06379.hogenberg11@zonnet.nl>
References: <200212142221.15212.hogenberg11@zonnet.nl> <3DFB9888.2050803@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3DFB9888.2050803-hi6Y0CQ0nG0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Saturday 14 December 2002 21:46, Heiko Ettelbrueck wrote:
> Hi Jaap,
>
> if you don't want to use ACPI because of its IRQ routing, you could
> simply try adding "pci=3Dnoacpi" at the boot prompt (or into lilo.conf =
/
> grub's menu.lst) for your acpi kernel and try once again. I have a
> Compaq Evo N160 and had the same problem (hang during boot) before I
> tried the above kernel option.
>
> > I've tried kernel 2.4.20 with the acpi patches of 12052002 and 121220=
02
> > as well as a 2.5.51 with and without patch (12132002) and when I incl=
ude
> > acpi support , the kernel will hang when probing the PCI bus.
> >

Yes , this works. But that presents me with another problem, upon
inserting pcmcia cards, I get the message "request IRQ:resource in use"
and  "resorce temporarily unavailable" messages.

Are there any other ways to set up the interrupt routing for this machine=
 ?
Or should I try compiling all the drivers into the kernel instead of modu=
les ?

Regards,
Jaap


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
