From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI owner_id limit too low
Date: Thu, 8 Dec 2005 15:18:30 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E03A96A14@orsmsx403.amr.corp.intel.com>
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
To: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

If you felt ambitious, you could take a look at making the change to not
allocate owner IDs for the static tables (tables that cannot be
unloaded). This would really take the pressure off the Owner ID.
Requires a change to the shutdown mechanism to make sure that the
namespace is completely deleted.


> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-VXdhtT5mjnY@public.gmane.org]
> Sent: Thursday, December 08, 2005 2:21 PM
> To: Moore, Robert
> Cc: Brown, Len; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; acpi-
> devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: RE: [ACPI] ACPI owner_id limit too low
>=20
> On Thu, 2005-12-08 at 14:03 -0800, Moore, Robert wrote:
> > We have increased the number of owner IDs to 255 in the most recent
> > version of ACPICA, 20051202. This should hit Linux soon.
> >
> > Additionally, we plan to conserve OwnerIDs by not using them for
tables
> > that can never be unloaded, to be implemented in a future release.
> > However, 255 Ids should be plenty for now.
> >
> > Here is the text from the release memo:
> >
> > Increased the number of available Owner Ids for namespace object
> > tracking from 32 to 255. This should eliminate the OWNER_ID_LIMIT
> > exceptions seen on some machines with a large number of ACPI tables
> > (either static or dynamic).
>=20
> Hi Bob,
>=20
>    Sorry if I wasn't clear, I'm worried about what happens in the
> interim.  The problem will be fixed in ACPICA 20051202, but we have at
> least one, likely two stable kernels that will be tagged before that
> ACPICA version hits the upstream kernel.  We can hit the owner_id
limit
> fairly easily on a few development systems.  How many stable kernels
do
> we want out in the wild with such a low owner_id limit?  Bumping it up
> to 64, while not ideal, is sufficient for our current usage, and I
think
> the patch is trivial enough that it could be included quickly.
Thanks,
>=20
> 	Alex
>=20
> --
> Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
