From: Jindrich Makovicka <makovick-/k6j/d2J2EitDQUhxP5w7+MCGPLT8p0O@public.gmane.org>
Subject: Enable C2 for processors without CST
Date: Sat, 02 Jul 2005 18:21:37 +0200
Message-ID: <da6eui$obf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070704050304070101020308"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

This is a multi-part message in MIME format.
--------------070704050304070101020308
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Hi,

this patch reenables power saving states for CPU when CST isn't
available. It is needed to make C2 work on my AMD XP-M 2600+ with
2.6.13-rc1-mm1 kernel.

Regards,
-- 
Jindrich Makovicka

--------------070704050304070101020308
Content-Type: text/plain;
 name="processor_idle.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="processor_idle.c.diff"

--- processor_idle.c.orig	2005-07-02 18:11:33.186334953 +0200
+++ processor_idle.c	2005-07-02 18:13:33.735687489 +0200
@@ -881,7 +881,7 @@
 	result = acpi_processor_get_power_info_cst(pr);
 	if ((result) || (acpi_processor_power_verify(pr) < 2)) {
 		result = acpi_processor_get_power_info_fadt(pr);
-		if (result)
+		if ((result) || acpi_processor_power_verify(pr) < 2)
 			result = acpi_processor_get_power_info_default_c1(pr);
 	}
 

--------------070704050304070101020308--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
