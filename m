From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: RV: differences between acpidump and disassembling
Date: Tue, 20 Apr 2004 20:09:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1082488182.28680.14.camel@darkstar>
References: <000701c425f8$6157aef0$0301a8c0@portatil>
	 <200404191309.45870.emejia@ieee.org> <1082409395.11663.63.camel@darkstar>
	 <200404200024.18432.emejia@ieee.org>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200404200024.18432.emejia-EkmVulN54Sk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: emejia-EkmVulN54Sk@public.gmane.org
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Your DSDT don't have any problem just one warning, that can be
ignored, so you don't need override your DSDT because DSDT it is
correct.
My laptop have the same warning.

Try last kernel 2.4.26=20

And don't forget disable all APICs to work with ACPI :)

regards,=20

On Mon, 2004-04-19 at 23:24, Emilio Mejia Fernandez de Velasco wrote:
> Hello,
> here I send you the binary file using pmtools.
> By the way, the computer is a Microstar (also known as Medion) model MD 9=
648
> I have found pages about similar models explaining the configuration, and=
 they=20
> say that it's necessary to use acpi, but they have been luckier than me.
> Here are some links:
> http://www.david-guembel.de/linux-md9630.html
> http://www.linuxstuff.de/md-9631-en.htm
>=20
> > let me know what computer we are talking about ?
> > and send me the binary in a gz (acpidmp DSDT )
> >
> > regards,
--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
