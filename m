From: Rakib Mullick <rakib.mullick@gmail.com>
Subject: [PATCH] acpi: Fix section mismatch warning in osl.c
Date: Mon, 1 Nov 2010 13:21:13 +0600
Message-ID: <AANLkTimWOytXT=jDWTobyvL=xdD7xW7oRqXshULgoF6R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Function acpi_os_initialize1() calls acpi_osi_setup_late() which is in
.init.text section and gets called from acpi_bus_init which is in
.init.text section. So mark acpi_os_initialize1() with __init. And
declaration of __init acpi_osi_setup_late has been removed, cause its
defination is above called function.


 WARNING: drivers/acpi/acpi.o(.text+0x460): Section mismatch in
reference from the function acpi_os_initialize1() to the function
.init.text:acpi_osi_setup_late()
The function acpi_os_initialize1() references
the function __init acpi_osi_setup_late().
This is often because acpi_os_initialize1 lacks a __init
annotation or the annotation of acpi_osi_setup_late is wrong.


Thanks,
Rakib


Signed-off-by: Rakib Mullick <rakib.mullick@gmail.com>
---

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 966fedd..81de639 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -113,8 +113,6 @@ static DEFINE_SPINLOCK(acpi_ioremap_lock);
 #define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
 static char osi_setup_string[OSI_STRING_LENGTH_MAX];

-static void __init acpi_osi_setup_late(void);
-
 /*
  * The story of _OSI(Linux)
  *
@@ -1530,7 +1528,7 @@ acpi_status __init acpi_os_initialize(void)
 	return AE_OK;
 }

-acpi_status acpi_os_initialize1(void)
+acpi_status __init acpi_os_initialize1(void)
 {
 	kacpid_wq = create_workqueue("kacpid");
 	kacpi_notify_wq = create_workqueue("kacpi_notify");
