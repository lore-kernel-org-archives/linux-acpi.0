From: Aman Gupta <themastermind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Radeon S3/resume: VGA ROM POST from kernel
Date: Mon, 19 Jul 2004 21:29:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <e1c05edd0407191329560b8193@mail.gmail.com>
References: <yzoy8lggx6v.fsf_-_@localhost.localdomain> <200407191938.17104.stefandoesinger@gmx.at>
Reply-To: aman-e31a5gnSYeGubukWoKzokaxOck334EZe@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200407191938.17104.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ole.rohne-vJEk5272eHo@public.gmane.org, aman-e31a5gnSYeGubukWoKzokaxOck334EZe@public.gmane.org, emmanuel.thome-/zGXu1G9BXs@public.gmane.org, software-v2/BnvaKusE@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Haven't tried it yet, but I was having problems just doing basic
suspend/resume with 2.6.8-rcX as well. After a resume with an
unpatched kernel I was unable to get the machine to respond to
commands to reboot the VGA bios or spin the harddrive. Something
changed between .7 and .8 but I'm not sure what - its not in the
radeon specific code since I didn't have that loaded in the kernel.

  Aman Gupta

On Mon, 19 Jul 2004 19:38:16 +0200, Stefan D=F6singer
<stefandoesinger-RbZlAiThDcE@public.gmane.org> wrote:
> Hello,
> > I've implemented VGA POSTing using a real-mode tunnel from kernel
> > space. IMO, this has some advantages over user space methods:
> Great!!!!
> For some reason, it doesn't work for me(Kernel 2.6.8-rc2). I cleaned up m=
y
> source directory and I'll try again with a clean build again. If it doesn=
't
> work I'll try 2.6.7.
>=20
> Do I need any other patches?
>=20
> > 1. It works with the aty/radeon_pm.c resume code. I don't see how to
> >    easily achieve this with user space methods.
> Do you have radeonfb and fbcon loaded(or compiled into the kernel)?
>=20
> > 2. Real mode seems faster than userspace vm86
>=20
> > 3. It is the right way. Bringing up the hardware is clearly the
> >    responsibility of the kernel/drivers resume code.
> Agreed. Someone wrote that this reset can't be performed by kernel code.
>=20
> This is really great, and as soon as it works for me I'll upload it to my
> website.
>=20
> Cheers,
> Stefan
>


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
