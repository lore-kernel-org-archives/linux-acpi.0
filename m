From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI _DSD sub-node parsing broken in linux-next?
Date: Tue, 22 Aug 2017 01:42:18 +0200
Message-ID: <3017279.6rhHp0hW77@aspire.rjw.lan>
References: <7A4F467111FEF64486F40DFE7DF3500A03EE8B36@ORSMSX111.amr.corp.intel.com> <7A4F467111FEF64486F40DFE7DF3500A03EE8F49@ORSMSX111.amr.corp.intel.com> <8ae7a257-2461-0f9f-b272-95dc08b8647c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61561 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932065AbdHUXuv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Aug 2017 19:50:51 -0400
In-Reply-To: <8ae7a257-2461-0f9f-b272-95dc08b8647c@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@intel.com>
Cc: Bob Moore <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Yang, Hyungwoo" <hyungwoo.yang@intel.com>, Lv Zheng <lv.zheng@intel.com>

On Monday, August 21, 2017 2:56:44 PM CEST Sakari Ailus wrote:
> Hi Bob, Rafael, others,
> 
> There seem to be a problem with this patch recently merged to linux-pm
> tree for v4.13:
> 
> <URL:https://git.linuxtv.org/media_tree.git/patch/drivers/acpi/acpica/nsxfeval.c?id=2d2a954375a0405fc721928f0dcc5ad1418996bc>
> 
> Some callers and acpi_nonsubnode_data_ok() in particular call
> acpi_evaluate_object_typed() with NULL pathname argument which I
> understand was fine before that patch. After that patch, pathname is 
> mandatory.
> 
> 

Does the patch below help (untested here)?

---
 drivers/acpi/acpica/nsxfeval.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/acpica/nsxfeval.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsxfeval.c
+++ linux-pm/drivers/acpi/acpica/nsxfeval.c
@@ -100,9 +100,13 @@ acpi_evaluate_object_typed(acpi_handle h
 		free_buffer_on_error = TRUE;
 	}
 
-	status = acpi_get_handle(handle, pathname, &target_handle);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+	if (pathname) {
+		status = acpi_get_handle(handle, pathname, &target_handle);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+	} else {
+		target_handle = handle;
 	}
 
 	full_pathname = acpi_ns_get_external_pathname(target_handle);


