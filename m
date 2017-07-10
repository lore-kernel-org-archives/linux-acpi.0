From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/16] ACPICA: linuxize: cleanup typedef definitions
Date: Mon, 10 Jul 2017 15:23:15 +0800
Message-ID: <b8b298d1b5b511e085f3bcae2308dbaa2d7d1a72.1499671182.git.lv.zheng@intel.com>
References: <cover.1499671181.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:28301 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751835AbdGJHXS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 Jul 2017 03:23:18 -0400
In-Reply-To: <cover.1499671181.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 894e49ef22db354eb1685cdb6f5f991766351d3c

acpisrc now has capability to convert both the followings:
1. Form 1:
  typedef struct/union foo {         struct/union foo {
     ....                       -->      ...
  } FOO;                             }
2. Form 2:
  typedef struct/union foo FOO; -->  typedef struct/union foo foo;
It becomes unable to handle the following:
3. Form3:
  typedef struct/union foo { /* comment */
      ...
  } FOO;
    -->
  strut/union foo { /* comment */
      ...
  };

As:
1. The purpose of acpisrc is to convert formatted code (ACPICA coding
   style) into linux coding style,
2. acpisrc is a very simple tool that doesn't fully handle C language.
This commit changes the definitions side in order not to regress and we
shall make "no comments in struct/union line" as a new ACPICA coding style
rule. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/894e49ef
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acobject.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 27c3f98..549f227 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -122,7 +122,9 @@ struct acpi_object_integer {
 	_type                           *pointer; \
 	u32                             length;
 
-struct acpi_object_string {	/* Null terminated, ASCII characters only */
+/* Null terminated, ASCII characters only */
+
+struct acpi_object_string {
 	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_BUFFER_INFO(char)	/* String in AML stream or allocated string */
 };
 
@@ -211,7 +213,9 @@ struct acpi_object_method {
 	union acpi_operand_object       *notify_list[2];    /* Handlers for system/device notifies */\
 	union acpi_operand_object       *handler;	/* Handler for Address space */
 
-struct acpi_object_notify_common {	/* COMMON NOTIFY for POWER, PROCESSOR, DEVICE, and THERMAL */
+/* COMMON NOTIFY for POWER, PROCESSOR, DEVICE, and THERMAL */
+
+struct acpi_object_notify_common {
 ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
 
 struct acpi_object_device {
@@ -258,7 +262,9 @@ ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
 	u8                              access_length;	/* For serial regions/fields */
 
 
-struct acpi_object_field_common {	/* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */
+/* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */
+
+struct acpi_object_field_common {
 	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_operand_object *region_obj;	/* Parent Operation Region object (REGION/BANK fields only) */
 };
 
-- 
2.7.4

