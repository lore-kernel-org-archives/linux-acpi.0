From: =?iso-8859-2?Q?Zden=ECk?= OGAR =?iso-8859-2?Q?Skal=E1k?=
	<skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>
Subject: Re: Starting AML
Date: Fri, 30 Apr 2004 08:46:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4091F662.EF7F0B1C@monetplus.cz>
References: <20040429192133.GI28420@gaspode.nextlink.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Andrews <tandrews-Dza9YrynN5pWaveUIWBRJg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

	 I have Compar Armada 110 and I already patched few DSDT for Compaq note=
books
as Armada 110, Evo N110, Evo N800c and similar (they are nearly the same =
:-). =

	The symptons were the same - lot of syntax compile errors, off-by-one er=
ror,
battery status not reading properly, ..... You could try to search this l=
ist for
messages from me and try to repare yourself, or you could send me you dsd=
t and I
will try :-)

	As for debuging DSDT, you could you DSDT's debug facility, ex: Store("So=
me text
you want to be printed",Debug)

	Bye
		Zdenek OGAR Skalak

Thomas Andrews wrote:
> =

> Hi Everyone,
> =

> I want to try to understand how to debug my DSDT properly, so I'd
> appreciate some hints for debugging. I've started reading through the
> ACPI specification available at http://www.acpi.info/spec.htm
> =

> Firstly, how do I find out in the AML where the relevant pieces of code=

> are ? For example, the battery voltage reported is wrong; how do I figu=
re
> out which bits to edit ?
> =

> Secondly, how can I output debugging messages ? Is there some way I can=

> use something like printf/printk ?
> =

> I have already fixed the "syntax errors" produced by compiling the
> original BIOS DSDT. That didn't fix anything BTW.
> =

> I have also read the (very helpful) docs and howtos on SF. Thanks.
> The laptop is a Compaq Evo N150, for which there seem to be no fixes
> made public.
> =

> Many thanks,
> Thomas
> =

> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g=
=2E
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- =

Ing. Zden=ECk OGAR Skal=E1k
Monet+ a.s.	        <http://www.monetplus.cz>
Z=E1meck=E1 365
763 14 Zl=EDn - =A9t=EDpa, CZ
Tel: +420 / 577 110 411,  Fax: +420 / 577 914 557


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
