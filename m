From: Luca <kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Thu, 19 Aug 2004 19:43:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040819174319.GB6913@dreamland.darkstar.lan>
References: <1091139240.26511.9.camel@6-allhosts> <200408051453.55710.stefandoesinger@gmx.at> <200408051914.39445.anib@anib.de> <200408052153.25467.stefandoesinger@gmx.at>
Reply-To: kronos-0Y2hHv2PMqFeoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: Quoted-Printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200408052153.25467.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: anib-La3J9u0raUk@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Il Thu, Aug 05, 2004 at 09:53:25PM +0200, Stefan D=F6singer ha scritto:=20
> *the boot-radeon.c program can ROM-post the radeon card(compile with gc=
c=20
> boot-radeon.c -o boot-radeon -llrmi) You need the lrmi libs+headers. Ca=
ll it=20
> after resuming from S3.

Is this radeon specific? AFAICS it should POST any card, right?

Oh, one small bug:

> void err(char *function, int exitval) {
> 	fprintf(stderr, "%s():\n");

fprintf(stderr, "%s():\n", function);


Luca
--=20
Home: http://kronoz.cjb.net
Runtime error 6D at f000:a12f : user incompetente


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
