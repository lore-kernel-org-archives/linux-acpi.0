From: Eric Piel <Eric.Piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
Subject: [PATHC] Relaxed syntax for the processor PBLK length
Date: Sun, 30 Jan 2005 21:05:22 +0100
Message-ID: <41FD3E02.8010701@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090309010109090606080405"
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090309010109090606080405
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

In the original DSDT of my laptop (Acer TravelMate 614) the processor 
PBLK length is declared to be 5. The legal and only allowed value is 6. 
This is an error in the DSDT and actually it is 6. Allowing Linux ACPI 
to read also processor PBLK length of 5 works and permits the processor 
to have the C-states correctly detected. In turn it allows the processor 
to get less hot (so this is eventually useful).

I've noticed that some other Acer DSDT also have this length 
mis-indicated. The attached patch adds some logic to the ACPI to allow a 
processor PBLK length of 5 when the syntax is relaxed.

Hoping this can be useful,
Eric

Signed-off-by: Eric Piel <eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>

--------------090309010109090606080405
Content-Type: text/x-patch;
 name="acpi-processor-pblk-length-2.6.11-rc2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-processor-pblk-length-2.6.11-rc2.patch"

--- linux-2.6.11-rc2/drivers/acpi/processor_core.c.orig	2005-01-23 01:24:55.315650055 +0100
+++ linux-2.6.11-rc2/drivers/acpi/processor_core.c	2005-01-23 01:27:32.016020121 +0100
@@ -492,9 +492,16 @@ acpi_processor_get_info (
 	if (!object.processor.pblk_address)
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No PBLK (NULL address)\n"));
 	else if (object.processor.pblk_length != 6)
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid PBLK length [%d]\n",
-			object.processor.pblk_length));
-	else {
+		if (object.processor.pblk_length == 5 && !acpi_strict) {
+			printk(KERN_INFO PREFIX 
+				"PBLK length is 5 instead of 6, concidering "
+				"it is good anyway.\n");
+			goto PBLK_length_good;
+		} else
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid PBLK length [%d]\n",
+				object.processor.pblk_length));
+ 	else {
+PBLK_length_good:
 		pr->throttling.address = object.processor.pblk_address;
 		pr->throttling.duty_offset = acpi_fadt.duty_offset;
 		pr->throttling.duty_width = acpi_fadt.duty_width;

--------------090309010109090606080405--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
