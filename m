From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: Re: Acpi-devel digest, Vol 1 #1632 - 7 msgs
Date: Mon, 1 Mar 2004 11:54:16 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA045C6D7B@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Robert M. Peterson" <robertmpeterson-Bdlq13kUjeyLZ21kGMrzwg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Robert M. Peterson [mailto:robertmpeterson-Bdlq13kUjeyLZ21kGMrzwg@public.gmane.org]
> Sent: Sunday, February 29, 2004 7:15 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] Re: Acpi-devel digest, Vol 1 #1632 - 7 msgs
>=20
>=20
> On Sat, 2004-02-28 at 17:09, acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> wrote:
>=20
> >=20
> > Message: 5
> > From: "Robert M. Peterson" <robertmpeterson-Bdlq13kUjeyLZ21kGMrzwg@public.gmane.org>
> > The button to turn the lcd screen off (as when the lid is=20
> closed) has
> > isn't functional. Also, I found this error in Dmesg: Dell=20
> Inspiron with
> > broken BIOS detected. Refusing to enable the local APIC.=20
> Other areas of
> > ACPI seem to be functioning properly as the battery status
> > (charging/discharging) and charge level are accurately reported.
> >=20
> > Any help would be welcome
>=20
> I have never used mailing lists before, so if my ettiquette is a bit
> off, please excuse me; I did some more research and I have found out
> that acpi does in fact properly detect my lid button events... however
> it doesn't do anything after that. I am not sure if the=20
> problem is with
> suspend states or what.
>=20

You have to get a script that can parse the acpid events which=20
whenever one of the buttons is pressed.

I'm using a perl based control script from Mike Hardy I think.
I can't remember.

Try googling for D800 + mike hardy (???)


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
