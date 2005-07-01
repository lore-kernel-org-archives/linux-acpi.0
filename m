From: Perry Hutchison <phutchis-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: RE: ACPI: RSDP - ERROR: Invalid checksum
Date: Fri, 1 Jul 2005 15:06:03 -0700 (PDT)
Message-ID: <200507012206.PAA91992@riparian.beaverton.windriver.com>
References: <971FCB6690CD0E4898387DBF7552B90E01FDC975@orsmsx403.amr.corp.intel.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E01FDC975-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> The actual ACPI CA core will continue until it finds a valid
> "RSD PTR " string with a valid table checksum, since at least
> 11/2004:
>
> + 19 November 2004.  Summary of changes for version 20041119:
>
> + Modified the RSDP memory scan mechanism to support the extended
> + checksum for ACPI 2.0 (and above) RSDPs. Note that the search
> + continues until a valid RSDP signature is found with a valid
> + checksum.
>
> Unfortunately, I believe that Linux still has two versions of
> the RSDP memory scan code, and the "other" version (not within
> the ACPI CA core) continues to be down-revved and incorrect.

At least as recently as 20050513, acpica-unix included common/a16find.c,
which contains (in AfFindRsdp()):

  /* Scan low memory */
  do
  {
    if (strncmp (Rove.ptr, RSDP_SIG, (size_t) 8) == 0)
    {
      /* TBD: Checksum check is invalid for X descriptor */
/*    if (AcpiTbChecksum (Rove.ptr, sizeof(RSDP_DESCRIPTOR)) != 0)
      {
 */
      AcpiOsPrintf ("RSDP found at %p (Lo block)\n", Rove.ptr);

IOW the checksum check is bypassed (and it is omitted entirely --
not even "present but commented out" -- in the second search loop).
If one of the Linux versions is derived from this file, and if
someone is keeping track of heritage, maybe an update to a16find.c
would be noticed as needing to be merged into the derived code.


BTW, while tracking this down -- I remembered the code, but not
its location -- I happened across a comment which could likely
use an update.  tables/tbinstal.c has

* 4) Table checksum must be valid (with the exception of the FACS
*    which has no checksum for some odd reason)

while tbutils.c has the more informative

* 4) Table checksum must be valid (with the exception of the FACS
*     which has no checksum because it contains variable fields)


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
