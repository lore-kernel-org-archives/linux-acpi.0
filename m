From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: Power button events unavailable after resume
Date: Tue, 12 Oct 2004 13:43:24 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200410121343.31099.barr.156@osu.edu>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Recently, I have been unable to get power button events from my notebook after 
a Software Suspend 2 (version 2.1-rc1) resume without removing and 
re-inserting the ACPI button driver. Pressing the power button has no effect, 
but pressing it and then reloading the driver causes an event to be 
triggered. It is like the events are "queued", and are written 
to /proc/acpi/event after I reload the driver. My BIOS has not changed in a 
long time, this behavior started a long time after my last BIOS upgrade. I am 
using the latest ACPI patch (20040816) to kernel 2.6.8.1. Does anyone know 
what could be causing this, or, better yet, what I can do to fix it?

Andrew

P.S. My DSDT is for BIOS A07 of the Dell Inspiron 300m, available at:
http://acpi.sourceforge.net/dsdt/view.php?id=218

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBbBfDhuM+Z62a52oRAhd/AKCSrTCPqSSsta28BhheWoCtMF4ieACcD+Ta
5pq5AUip3Wz9yDrCKD7hVB8=
=XWpK
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
