From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: ACPI on RH9 - just Hangs during Init
Date: Thu, 08 Apr 2004 15:25:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081434348.4723.8.camel@darkstar>
References: <C386328088ED7F4E9F81AFBABDDF60DA04F67A78@wdmyexch02.my.asia.wdc.com>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA04F67A78-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ow Mun Heng <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Cc: "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Arindam Dey (E-mail)" <adey-bmTD0NCZhtfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-04-08 at 09:59, Ow Mun Heng wrote:
> Hi,
>=20
> 	I'm having some issues getting ACPI to work for a default RH9
> install with kernel 2.4.20-8.=20
>=20
> Just unchecked apm and selected acpi nothing else. Did not want to=20
> mess around with anything else. KErnel compiled just fine but then it=20
> reaches init and before the messages start it just bloody sits=20
> there doing nothing nothing at all. No msgs no cpu light=20
> nothing. Its  very creepy.
>=20
> This is a Samsung Laptop.
>=20
> Can I buy a clue here???

Hi!
yes kernel 2.4.20-8 have at least "6" months and  IIRC (if I recall
correctly), doesn't have new acpi CA, is old ACPI and it does not
maintained.
Applying acpi-patches is not possible, directly or I don't recommend,=20
so you can try use the main stock kernel from kernel.org.

best regards=20
>=20
> Cheers,                                                 .^.
> Mun Heng, Ow                                            /V\
> H/M Engineering                                       /(   )\
> Western Digital M'sia                                  ^^-^^
> DID : 03-7870 5168                          The Linux Advocate
>=20
>        =20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
