From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] ACPICA: Use acpi_os_allocate_zeroed
Date: Sat, 18 Jun 2016 12:20:23 +0530
Message-ID: <20160618065023.GA1839@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: linux-acpi@vger.kernel.org

acpi_os_allocate_zeroed combines acpi_os_allocate and memset 0.

The Coccinelle semantic patch used to make this change is as follows:
@@
type T;
T *d;
expression e;
statement S;
@@

        d =
-            acpi_os_allocate
+            acpi_os_allocate_zeroed
             (...);
        if (!d) S
-       memset(d, 0, sizeof(T));

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/acpi/acpica/uttrack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 60c406a..5ad2641 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -95,13 +95,11 @@ acpi_ut_create_list(char *list_name,
 {
 	struct acpi_memory_list *cache;
 
-	cache = acpi_os_allocate(sizeof(struct acpi_memory_list));
+	cache = acpi_os_allocate_zeroed(sizeof(struct acpi_memory_list));
 	if (!cache) {
 		return (AE_NO_MEMORY);
 	}
 
-	memset(cache, 0, sizeof(struct acpi_memory_list));
-
 	cache->list_name = list_name;
 	cache->object_size = object_size;
 
-- 
1.9.1
