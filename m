From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org>
Subject: Re: Kernel 2.4.22?
Date: 03 Apr 2003 14:53:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1049378019.1769.24.camel@darkstar.portugal>
References: <20030403140709.75be5865.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030403140709.75be5865.hanno-Mmb7MZpHnFY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hanno =?ISO-8859-1?Q?B=F6ck?= <hanno-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This has already been discussed, and for "Marcelo team " is a to big
patch to be included in kernel tree. I had thought about an solution, I
think that Andrew Grover has reason.
What we need to do, is prove that the code that not is under
drivers/acpi, does not have any effect to others functionality in
kernel, and put acpi has experimental. =20

On Thu, 2003-04-03 at 13:07, Hanno B=F6ck wrote:
> As Marcello recently announced that he'll soon enter the rc-stage for
> kernel 2.4.21, is there any chance that the ACPI-patch will enter the
> 2.4.22-pre-versions?
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: ValueWeb:=20
> Dedicated Hosting for just $79/mo with 500 GB of bandwidth!=20
> No other company gives more support or power for your dedicated server
> http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=E9rgio Basto
Technology Project Manager
onevision design studios
Rua Prof. Mota Pinto
42F-S2.30
4100-353 PORTO
tel. + 351 22 532 0300
fax. + 351 22 616 0182
email: sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org
web: http://www.onevision-design.com



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
