From: akpm-3NddpPZAyC0@public.gmane.org
Subject: [patch 05/12] acpi: sleep-while-atomic during S3 resume from ram
Date: Wed, 23 Feb 2005 01:53:00 -0800
Message-ID: <200502230953.j1N9rFj1020702@shell0.pdx.osdl.net>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, linux-kernel-Ki4U9mvT0kswryQfseakQg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


From: Christian Borntraeger <linux-kernel-Ki4U9mvT0kswryQfseakQg@public.gmane.org>

During the wakeup from suspend-to-ram I get several warnings.

Signed-off-by: Christian Borntraeger <linux-kernel-Ki4U9mvT0kswryQfseakQg@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
---

 25-akpm/drivers/acpi/osl.c      |    4 ++--
 25-akpm/drivers/acpi/pci_link.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/osl.c~acpi-sleep-while-atomic-during-s3-resume-from-ram drivers/acpi/osl.c
--- 25/drivers/acpi/osl.c~acpi-sleep-while-atomic-during-s3-resume-from-ram	2005-02-23 01:48:02.000000000 -0800
+++ 25-akpm/drivers/acpi/osl.c	2005-02-23 01:48:02.000000000 -0800
@@ -145,7 +145,7 @@ acpi_os_vprintf(const char *fmt, va_list
 void *
 acpi_os_allocate(acpi_size size)
 {
-	return kmalloc(size, GFP_KERNEL);
+	return kmalloc(size, GFP_ATOMIC);
 }
 
 void
@@ -905,7 +905,7 @@ acpi_os_wait_semaphore(
 
 	ACPI_DEBUG_PRINT ((ACPI_DB_MUTEX, "Waiting for semaphore[%p|%d|%d]\n", handle, units, timeout));
 
-	if (in_atomic())
+	if (in_atomic() || irqs_disabled())
 		timeout = 0;
 
 	switch (timeout)
diff -puN drivers/acpi/pci_link.c~acpi-sleep-while-atomic-during-s3-resume-from-ram drivers/acpi/pci_link.c
--- 25/drivers/acpi/pci_link.c~acpi-sleep-while-atomic-during-s3-resume-from-ram	2005-02-23 01:48:02.000000000 -0800
+++ 25-akpm/drivers/acpi/pci_link.c	2005-02-23 01:48:02.000000000 -0800
@@ -315,7 +315,7 @@ acpi_pci_link_set (
 	if (!link || !irq)
 		return_VALUE(-EINVAL);
 
-	resource = kmalloc( sizeof(*resource)+1, GFP_KERNEL);
+	resource = kmalloc( sizeof(*resource)+1, GFP_ATOMIC);
 	if(!resource)
 		return_VALUE(-ENOMEM);
 
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
