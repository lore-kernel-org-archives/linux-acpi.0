From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: Re: Warn user when battery goes critical
Date: Mon, 12 Apr 2004 21:45:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081802715.3428.40.camel@darkstar>
References: <20040405211032.GA3575@elf.ucw.cz>
	 <20040408171527.GH23710@message-id.gmane0305.slipkontur.de>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040408171527.GH23710-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>, hegbloom-tbDHPZwbsQQ@public.gmane.org
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,
I am think in reply to this question a long time, well because I not a
man of the code, it is goes my reflection, I turn acpi debug on because
I want to know in /var/log em battery got one "bat low 2" but is very
annoying applet monitor every time that ask battery stat appears :
[ACPI Debug] String: Length 0x24, "---------------------------- AC _PSR"
[ACPI Debug] String: Length 0x27, "---------------------------- AC on
line"
[ACPI Debug] String: Length 0x30, "--------- VIA SOFTWARE SMI PMIO 2Fh
------
 this messages are written in DSDT, so is just select the more imports
and the DEBUG messages from DSDT.

Bye=20


On Thu, 2004-04-08 at 18:15, Stefan Seyfried wrote:
> On Mon, Apr 05, 2004 at 11:10:32PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > When battery is going critical, perhaps user should know? It already
> > helped me when power was turned off at expansion cord...
>=20
> > +		if (!res && (bst->state & 0x04))
> > +			printk(KERN_CRIT "Battery status: critical\n");
>=20
> This should go into userspace IMO. There are some applications that will
> handle this, so no need for code bloat in the kernel.
>=20
> Hey! I'd never thought i could one day accuse Pavel of "eyecandy bloat" ;=
-)
>=20
>=20
> Happy Easter,
>=20
>     Stefan
--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
