From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: redhat9 and kernel2.4.22 and failed patch for 2.4.20
Date: 09 Apr 2003 23:54:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1049928853.1539.23.camel@darkstar.portugal>
References: <200304080228.h382STJ12272@throb.netspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200304080228.h382STJ12272-7GtV0IYKK74tA4QZiFxQkx2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Thanks for the tip , Now I do compile kernel for redhat2.4.20-8 with
acpi-20021212 patch=20
I don't had to make any modification, I had ignored the only rejected
file because don't need to include acpi.h (I guess).
The problem of your tip is the time for compiling kernel, that is 3 or
more time of my personal kernel configuration that I am working for
since I had the laptop.
And is cool kde and gnome read battery charge correctly.

but I think, that we can't compile the kernel with last acpi, I am not
sure.
redhat have already available a new kernel version and a bug fix to
gcc3.2, so more tests to go.

thanks all.

On Tue, 2003-04-08 at 03:28, bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org wrote:
> Suggestion:
> =20
> Use 2.4.21.   Copy the /boot/config-2.4.xx.xx.xx into
> .config into the top level linux source directory before compiling.
> Do a=20
>=20
> make menuconfig
>=20
> and take a look and make sure everything looks
> reasonable. Save the config. Do:
>=20
> make dep clean modules modules_install install
>=20
> Compile reboot, make any small changes to the config you might need.
>=20
> I did this without too much trouble on RH8.
>=20
> --
> Hello, Justice Department?  I'd like to report a subversive penguin. =20
>   --Tom Tomorrow "This Modern World"
> Brian Perkins                bperkins-ooduxAEi7gVg9hUCZPvPmw@public.gmane.org=20
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
