From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] fix pnpacpi regression resulting from ACPICA 20051117
Date: Thu, 5 Jan 2006 03:13:18 -0500
Message-ID: <200601050313.18715.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: akpm-3NddpPZAyC0@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew,
I just pushed this patch to the test branch of the acpi git tree.
Please pull my tree again or apply this patch before you ship
the next -mm if possible.

Thanks to Shaohua Li for keeping me awake helping me to fix this:-)

thanks,
-Len

In ACPICA 20051117, acpi_walk_resources() started
sending ACPI_RESOURCE_TYPE_END_TAG to the callback
routine which wasn't prepared for it, causing
_CRS to fail and PnPACPI to not recognize any devices:

pnp: ACPI device : hid PNP0C02
pnp: PnPACPI: unknown resource type 7
pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c02

Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

---

 drivers/acpi/resources/rsxface.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

ed349a8a0a780ed27e2a765f16cee54d9b63bfee
diff --git a/drivers/acpi/resources/rsxface.c b/drivers/acpi/resources/rsxface.c
index 50a956b..5408e5d 100644
--- a/drivers/acpi/resources/rsxface.c
+++ b/drivers/acpi/resources/rsxface.c
@@ -286,6 +286,12 @@ acpi_walk_resources(acpi_handle device_h
 			break;
 		}
 
+		/* end_tag indicates end-of-list */
+
+		if (resource->type == ACPI_RESOURCE_TYPE_END_TAG) {
+			break;
+		}
+
 		/* Invoke the user function, abort on any error returned */
 
 		status = user_function(resource, context);
@@ -298,12 +304,6 @@ acpi_walk_resources(acpi_handle device_h
 			break;
 		}
 
-		/* end_tag indicates end-of-list */
-
-		if (resource->type == ACPI_RESOURCE_TYPE_END_TAG) {
-			break;
-		}
-
 		/* Get the next resource descriptor */
 
 		resource =
-- 
1.0.6-g58e3
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
