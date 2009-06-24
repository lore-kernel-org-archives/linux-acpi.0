From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH] wmi: Fix kernel panic when stack protection enabled.
Date: Wed, 24 Jun 2009 18:54:01 +0100
Message-ID: <20090624175401.16564.37550.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:36175 "EHLO
	pegasus." rhost-flags-OK-OK-FAIL-FAIL) by vger.kernel.org with ESMTP
	id S1751333AbZFXSSf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jun 2009 14:18:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

From: Costantino Leandro <lcostantino@gmail.com>

Summary:
Kernel panic arise when stack protection is enabled, since strncat will
add a null terminating byte '\0'; So in functions
like this one (wmi_query_block):
        char wc[4]="WC";
	....
	strncat(method, block->object_id, 2);
        ...
the length of wc should be n+1 (wc[5]) or stack protection
fault will arise. This is not noticeable when stack protection is
disabled,but , isn't good either.
Config used: [CONFIG_CC_STACKPROTECTOR_ALL=y,
	      CONFIG_CC_STACKPROTECTOR=y]

Panic Trace
------------
       .... stack-protector: kernel stack corrupted in : fa7b182c
       2.6.30-rc8-obelisco-generic
       call_trace:
           [<c04a6c40>] ? panic+0x45/0xd9
	   [<c012925d>] ? __stack_chk_fail+0x1c/0x40
	   [<fa7b182c>] ? wmi_query_block+0x15a/0x162 [wmi]
	   [<fa7b182c>] ? wmi_query_block+0x15a/0x162 [wmi]
	   [<fa7e7000>] ? acer_wmi_init+0x00/0x61a [acer_wmi]
	   [<fa7e7135>] ? acer_wmi_init+0x135/0x61a [acer_wmi]
	   [<c0101159>] ? do_one_initcall+0x50+0x126

[cc: Fixes kernel bugzilla bug 13514]

Signed-off-by: Costantino Leandro <lcostantino@gmail.com>
Cc: stable@kernel.org
Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/platform/x86/wmi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 21aa70a..d03e30a 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -299,7 +299,7 @@ u32 method_id, const struct acpi_buffer *in, struct acpi_buffer *out)
 	acpi_status status;
 	struct acpi_object_list input;
 	union acpi_object params[3];
-	char method[4] = "WM";
+	char method[5] = "WM";
 
 	if (!find_guid(guid_string, &wblock))
 		return AE_ERROR;
@@ -357,8 +357,8 @@ struct acpi_buffer *out)
 	acpi_status status, wc_status = AE_ERROR;
 	struct acpi_object_list input, wc_input;
 	union acpi_object wc_params[1], wq_params[1];
-	char method[4];
-	char wc_method[4] = "WC";
+	char method[5];
+	char wc_method[5] = "WC";
 
 	if (!guid_string || !out)
 		return AE_BAD_PARAMETER;
@@ -439,7 +439,7 @@ const struct acpi_buffer *in)
 	acpi_handle handle;
 	struct acpi_object_list input;
 	union acpi_object params[2];
-	char method[4] = "WS";
+	char method[5] = "WS";
 
 	if (!guid_string || !in)
 		return AE_BAD_DATA;

