From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] restore _OS object to "Linux" for ia64
Date: Mon, 13 Sep 2004 15:11:29 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05501FB49C2@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gerald Pfeifer <gp-l3A5Bk7waGM@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I don't know what the specific machines were.  There was lots of
discussion on the Linux/ACPI list before we did this.  I think they were
all 32-bit machines, however.


> -----Original Message-----
> From: Gerald Pfeifer [mailto:gp-l3A5Bk7waGM@public.gmane.org]
> Sent: Monday, September 13, 2004 2:30 PM
> To: Moore, Robert
> Cc: Brown, Len; Alex Williamson; linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ACPI
> Developers
> Subject: RE: [ACPI] [PATCH] restore _OS object to "Linux" for ia64
>=20
> On Mon, 13 Sep 2004, Moore, Robert wrote:
> > Not only is the !Windows code path apparently untested for the most
> > part, we have discovered many machines that simply do not work
properly
> > unless we report "Microsoft Windows NT" for the _OS string.
>=20
> Can you name some of these (broken) systems?
>=20
> Given that we apparently did not encounter this with our 2.6.5-based
SLES9
> kernel so far, I'm a bit sceptical that many (if any) ia64 machines
are
> affected.
>=20
> Gerald


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
