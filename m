From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: Re: ACPI owner_id limit too low
Date: Thu, 08 Dec 2005 13:36:48 -0700
Message-ID: <1134074208.1907.6.camel@tdi>
References: <1134066095.32040.20.camel@tdi>  <4398963D.8040207@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4398963D.8040207-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-12-08 at 21:23 +0100, Carl-Daniel Hailfinger wrote:

> > -	for (i = 0; i < 32; i++) {
> > -		if (!(acpi_gbl_owner_id_mask & (1 << i))) {
> > +	for (i = 0; i < 64; i++) {
> > +		if (!(acpi_gbl_owner_id_mask & (1UL << i))) {
> 
> Shouldn't this be 1ULL if you intend it to be 64 bit wide on a
> 32 bit arch?

   Yes, sorry I overlooked that.  Here's an updated patch.  Thanks,

	Alex

Signed-off-by: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
---

diff -r 03055821672a drivers/acpi/utilities/utmisc.c
--- a/drivers/acpi/utilities/utmisc.c	Mon Dec  5 01:00:10 2005
+++ b/drivers/acpi/utilities/utmisc.c	Wed Dec  7 14:55:58 2005
@@ -84,14 +84,14 @@
 
 	/* Find a free owner ID */
 
-	for (i = 0; i < 32; i++) {
-		if (!(acpi_gbl_owner_id_mask & (1 << i))) {
+	for (i = 0; i < 64; i++) {
+		if (!(acpi_gbl_owner_id_mask & (1ULL << i))) {
 			ACPI_DEBUG_PRINT((ACPI_DB_VALUES,
-					  "Current owner_id mask: %8.8X New ID: %2.2X\n",
+					  "Current owner_id mask: %16.16lX New ID: %2.2X\n",
 					  acpi_gbl_owner_id_mask,
 					  (unsigned int)(i + 1)));
 
-			acpi_gbl_owner_id_mask |= (1 << i);
+			acpi_gbl_owner_id_mask |= (1ULL << i);
 			*owner_id = (acpi_owner_id) (i + 1);
 			goto exit;
 		}
@@ -106,7 +106,7 @@
 	 */
 	*owner_id = 0;
 	status = AE_OWNER_ID_LIMIT;
-	ACPI_REPORT_ERROR(("Could not allocate new owner_id (32 max), AE_OWNER_ID_LIMIT\n"));
+	ACPI_REPORT_ERROR(("Could not allocate new owner_id (64 max), AE_OWNER_ID_LIMIT\n"));
 
       exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_CACHES);
@@ -123,7 +123,7 @@
  *              control method or unloading a table. Either way, we would
  *              ignore any error anyway.
  *
- * DESCRIPTION: Release a table or method owner ID.  Valid IDs are 1 - 32
+ * DESCRIPTION: Release a table or method owner ID.  Valid IDs are 1 - 64
  *
  ******************************************************************************/
 
@@ -140,7 +140,7 @@
 
 	/* Zero is not a valid owner_iD */
 
-	if ((owner_id == 0) || (owner_id > 32)) {
+	if ((owner_id == 0) || (owner_id > 64)) {
 		ACPI_REPORT_ERROR(("Invalid owner_id: %2.2X\n", owner_id));
 		return_VOID;
 	}
@@ -158,8 +158,8 @@
 
 	/* Free the owner ID only if it is valid */
 
-	if (acpi_gbl_owner_id_mask & (1 << owner_id)) {
-		acpi_gbl_owner_id_mask ^= (1 << owner_id);
+	if (acpi_gbl_owner_id_mask & (1ULL << owner_id)) {
+		acpi_gbl_owner_id_mask ^= (1ULL << owner_id);
 	}
 
 	(void)acpi_ut_release_mutex(ACPI_MTX_CACHES);
diff -r 03055821672a include/acpi/acglobal.h
--- a/include/acpi/acglobal.h	Mon Dec  5 01:00:10 2005
+++ b/include/acpi/acglobal.h	Wed Dec  7 14:55:58 2005
@@ -211,7 +211,7 @@
 ACPI_EXTERN u32 acpi_gbl_rsdp_original_location;
 ACPI_EXTERN u32 acpi_gbl_ns_lookup_count;
 ACPI_EXTERN u32 acpi_gbl_ps_find_count;
-ACPI_EXTERN u32 acpi_gbl_owner_id_mask;
+ACPI_EXTERN u64 acpi_gbl_owner_id_mask;
 ACPI_EXTERN u16 acpi_gbl_pm1_enable_register_save;
 ACPI_EXTERN u16 acpi_gbl_global_lock_handle;
 ACPI_EXTERN u8 acpi_gbl_debugger_configuration;




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
