From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: preparing toshiba_acpi driver release
Date: Mon, 26 Jan 2004 14:29:02 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8A54@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Wait.  I take video, not hotkey :)

Yes, I just mentioned hotkeys because that is the other part of the
platform dependent drivers which need a more generic solution.

> > I think video brightness control will be a very popular and visible
> > feature -- no pun intended;-)
>=20
> ATM I much prefer _CST though, even if there is no visible=20
> effect other
> than people may notice that their laptop will run longer on battery,
> and if they don't have some usb driver loaded.

I was thinking about ergonomics rather than power-savings -- though
probably brightness control has some power savings benefits too -- maybe
somebody on the list has numbers for screen power consumption?

> > In the back of my head I'm also wondering if we've got a=20
> missing piece
> > of the suspend/resume puzzle here too -- and I'd hate for=20
> ACPI to be the
> > "missing link" to get that key feature working.
>=20
> IMHO, there is a need at first to glue devices in the ACPI=20
> namespace and the
> devices enumerated by OS a la pnpbios...

For suspend/resume, or for something else?
PNP is only for ISA devices, yes?  Is it really still used?
When we were working on interrupts somebody suggested that we ask the
ISA bus driver about what ISA interrupts where taken rather than using a
table inside the ACPI code containing "conventions".  The conventions
are simple, and so far seem to be functional -- though one could argue
such heuristics are sort of a hack.

-Len


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
