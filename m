From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] ACPI: implement UUID-labelled vendor-defined resources
Date: Tue, 20 Sep 2005 16:16:37 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E02C8E63F@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I'll get to this a bit later.
Thx
Bob


> -----Original Message-----
> From: Bjorn Helgaas [mailto:bjorn.helgaas-VXdhtT5mjnY@public.gmane.org]
> Sent: Tuesday, September 20, 2005 4:10 PM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Cc: Moore, Robert; Brown, Len; Alex Williamson; Luck, Tony; linux-
> ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [ACPI] [PATCH] ACPI: implement UUID-labelled
vendor-defined
> resources
>=20
> On Monday 19 September 2005 9:31 am, Bjorn Helgaas wrote:
> > > BTW, Please explain in more detail what support is needed in
ACPICA
> for
> > > the ACPI 3.0 vendor-defined resource.  Also, any idea how we are
> > > supposed to determine if the UUID data exists within the
descriptor?
> > > (i.e., how do we differentiate an ACPI 2.0 vendor descriptor from
an
> > > ACPI 3.0 descriptor?)
> >
> > There's no mark that distinguishes 2.0 and 3.0 vendor descriptors.
> > As far as I can tell, a 3.0 descriptor (that contains a UUID and
> > sub-type) is also a perfectly valid 2.0 descriptor.
> >
> > ACPI 3.0 "strongs recommends," but apparently doesn't actually
> > require a UUID, so a 2.0 vendor descriptor should also be a valid
> > 3.0 descriptor.
> >
> > The idea is that we just look through all the vendor descriptors
> > for the supplied UUID.  If we find one, we return the information.
> > There's a small possibility that an ACPI 2.0, non-UUID-labelled
> > descriptor will contain data that happens to match the random
> > 16-byte UUID, and we'll return it by mistake.  But that possibility
> > is pretty remote, I think.
>=20
> Ping...  Did this make any sense, or did I answer the wrong questions?


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
