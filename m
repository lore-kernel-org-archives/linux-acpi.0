From: "Magenheimer, Dan (HP Labs Fort Collins)" <dan.magenheimer-VXdhtT5mjnY@public.gmane.org>
Subject: RE: One-line patch for systems with ACPI enabled but incomplete tree
Date: Tue, 30 Aug 2005 09:27:24 -0700
Message-ID: <516F50407E01324991DD6D07B0531AD56953D4@cacexc12.americas.cpqcorp.net>
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

I see this didn't make it into 2.6.13 so am re-posting.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

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
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
