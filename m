From: "Magenheimer, Dan (HP Labs Fort Collins)" <dan.magenheimer-VXdhtT5mjnY@public.gmane.org>
Subject: One-line patch for systems with ACPI enabled but incomplete tree
Date: Tue, 5 Jul 2005 12:11:01 -0700
Message-ID: <516F50407E01324991DD6D07B0531AD54FA3DF@cacexc12.americas.cpqcorp.net>
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The attached patch allows systems for which ACPI is enabled,
but a full tree is not present, to avoid a horrible kernel crash.
Systems with this characteristic include the ia64 HP simulator
(with ACPI enabled) and some future virtualized environments
(e.g. Xen, specifically Xen/ia64).

If no objections, please apply.  If discussion ensues, please
cc me as I am not a subscriber to this list.

Thanks,
Dan Magenheimer
HP Labs

--- 1.6/drivers/acpi/motherboard.c	Wed Nov 10 15:57:35 2004
+++ 1.7/drivers/acpi/motherboard.c	Fri Apr 22 16:47:41 2005
@@ -120,6 +120,7 @@
 static void __init
 acpi_reserve_resources (void)
 {
+	if (!acpi_gbl_FADT) return;


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
