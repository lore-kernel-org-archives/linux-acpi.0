From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: [ACPI] RE: [ACPI-sppt] merge acpi-support into acpi-devel?
Date: Mon, 6 Oct 2003 18:33:29 -0500
Sender: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD106610CB5@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-support-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-support>,
	<mailto:acpi-support-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-support>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi support <acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Brown, Len [mailto:len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
> To: Matthew Wilcox
> > Personally, I'm really not interested in any of the x86=20
> > shitty BIOS IRQ routing type issues.
>=20
> > - acpi-x86 (for x86 specific problems)
> > - acpi-core (for everything else)
>=20
> We need to work through the configuration issues on x86 to enable a
> successful broad Linux ACPI deployment.  Based on the type of=20
> bugs that
> are getting fixed today, I'm hopeful that these are deployment pains
> that we'll fix and put behind us.  So in the long-term I=20
> don't think we
> should need a special list to segregate them from other linux acpi
> topics.
>=20
> thanks,
> -Len

I agree - one list.  I think if separate the lists you'll just end up
with acpi-x86 getting 95% of the issues even if half of them are
problems in the core.  The vast majority of Linux ACPI implementations
will be x86 for a long time.  I think if it weren't for the laptop
users we probably wouldn't have ACPI for Linux, and it will be a long
time before you'll see a Itanium laptop.

Regards,
John


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
