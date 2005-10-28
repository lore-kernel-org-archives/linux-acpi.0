From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 3/9] git-acpi build fix
Date: Fri, 28 Oct 2005 14:59:49 -0700
Message-ID: <200510282159.j9SLxVet021610@shell0.pdx.osdl.net>
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, maeda.naoaki-+CUm20s59erQFUHtdCDX3A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: MAEDA Naoaki <maeda.naoaki-+CUm20s59erQFUHtdCDX3A@public.gmane.org>

This patch fix the following compile error on ia64.

arch/ia64/kernel/acpi-ext.c: In function `acpi_vendor_resource_match':
arch/ia64/kernel/acpi-ext.c:38: error: structure has no member named `id'

Signed-off-by: MAEDA Naoaki <maeda.naoaki-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 arch/ia64/kernel/acpi-ext.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/ia64/kernel/acpi-ext.c~git-acpi-build-fix-3 arch/ia64/kernel/acpi-ext.c
--- 25/arch/ia64/kernel/acpi-ext.c~git-acpi-build-fix-3	Fri Oct 28 14:59:06 2005
+++ 25-akpm/arch/ia64/kernel/acpi-ext.c	Fri Oct 28 14:59:06 2005
@@ -35,7 +35,7 @@ acpi_vendor_resource_match(struct acpi_r
 	struct acpi_vendor_descriptor *descriptor;
 	u32 length;
 
-	if (resource->id != ACPI_RSTYPE_VENDOR)
+	if (resource->type != ACPI_RSTYPE_VENDOR)
 		return AE_OK;
 
 	vendor = (struct acpi_resource_vendor *)&resource->data;
_


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
