From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 1/2] acpi: Toshiba failure handling
Date: Wed, 09 Mar 2005 00:56:41 -0800
Message-ID: <200503090857.j298v6Gd021823@shell0.pdx.osdl.net>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, panagiotis.issaris-hfxpx0nnwYVX2QMWbMbClIble9XqW/aP@public.gmane.org, takis-8nu/KwtRnEU@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: "Panagiotis Issaris" <panagiotis.issaris-hfxpx0nnwYVX2QMWbMbClIble9XqW/aP@public.gmane.org>

Adds the missing failure handling for a kmalloc in the Toshiba ACPI driver.

Signed-off-by: Panagiotis Issaris <takis-8nu/KwtRnEU@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/drivers/acpi/toshiba_acpi.c |    3 +++
 1 files changed, 3 insertions(+)

diff -puN drivers/acpi/toshiba_acpi.c~acpi-toshiba-failure-handling drivers/acpi/toshiba_acpi.c
--- 25/drivers/acpi/toshiba_acpi.c~acpi-toshiba-failure-handling	2005-03-09 00:54:55.000000000 -0800
+++ 25-akpm/drivers/acpi/toshiba_acpi.c	2005-03-09 00:54:55.000000000 -0800
@@ -263,6 +263,9 @@ dispatch_write(struct file* file, const 
 	 * destination so that sscanf can be used on it safely.
 	 */
 	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if(!tmp_buffer)
+		return -ENOMEM;
+
 	if (copy_from_user(tmp_buffer, buffer, count)) {
 		result = -EFAULT;
 	}
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
