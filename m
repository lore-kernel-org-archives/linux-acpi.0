From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: ACPI DSDT BIOS bug workaround - exceeding operation regions
Date: Fri, 18 Mar 2005 19:01:30 +0100
Message-ID: <423B177A.6050302@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: kernel-l3A5Bk7waGM@public.gmane.org
Cc: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I got one report of a broken DSDT on a Medion P4 HT machine (#72391).
I could only work on a forced compiled broken DSDT on my own system.
Another report seems to be similar (Medion P4 HT EM64T), waiting for
dsdt whether it's the same bug.

In both cases speedstep (possibly other things, too) do not work..


The problem are those lines in the DSDT (- broken, + fixed):
(Tested fixed DSDT on the broken system -> works)

     OperationRegion (PORT, SystemIO, 0x80, 0x01)
-    Field (PORT, WordAcc, NoLock, Preserve)
+    Field (PORT, ByteAcc, NoLock, Preserve)
     {
         P80H,   8
     }
The Operation Region or data field is declared to be one byte in size (last
argument). The access on the region is declared WordAcc (2 bytes).
Even the variable inside the field is only declared 1 byte (8 bit), the kernel
will try to read/write 2 bytes as declared in the header of the field (WordAcc).
I found out that there is already a hook in drivers/acpi/executer/exfldio.c
for buggy DSDTs. It allows to read/write outside the OperationRegion:
______________________

if (acpi_gbl_enable_interpreter_slack) {
                        /*
                         * Slack mode only:  We will go ahead and allow access to this
                         * field if it is within the region length rounded up to the next
                         * access width boundary.
                         */
______________________

So in the above case the kernel allows when DSDT code access P80H to read byte
0x80 and 0x81. This seems to fail on the new Medions, probably when writing to byte 0x81.


                     OperationRegion (EVGR, PCI_Config, 0x00, 0x02)
-                    Field (EVGR, DWordAcc, NoLock, Preserve)
+                    Field (EVGR, WordAcc, NoLock, Preserve)
                     {
                         EVID,   16
                     }
Same here, but 32 bit should be read (DWordAcc), even the region is only 16
bit.

My patch below shortens the access of the field unit (P80H) to the next byte width,
by considering the bit_length of the field unit (8), not the whole field declaration (WordAcc, 16).
In this case the bit width is 8, so it's shortened to 1 byte, reading/writing only 0x80.

Differences should only come in place on a buggy BIOS, where a field exceeds the operation region.
Therefore I think it should be safe?


--- linux-2.6.11/drivers/acpi/executer/exfldio.c	2005-03-02 08:37:53.000000000 +0100
+++ linux-2.6.11_i386_ExceedingRegion/drivers/acpi/executer/exfldio.c	2005-03-17 18:02:44.000000000 +0100
@@ -134,7 +134,8 @@
 			/*
 			 * Slack mode only:  We will go ahead and allow access to this
 			 * field if it is within the region length rounded up to the next
-			 * access width boundary.
+			 * access width boundary, the access will be cut if necessary
+			 * later in acpi_ex_access_region below
 			 */
 			if (ACPI_ROUND_UP (rgn_desc->region.length,
 					   obj_desc->common_field.access_byte_width) >=
@@ -248,8 +249,24 @@

 	/* Invoke the appropriate address_space/op_region handler */

-	status = acpi_ev_address_space_dispatch (rgn_desc, function,
-			  address, ACPI_MUL_8 (obj_desc->common_field.access_byte_width), value);
+	if (rgn_desc->region.length < (obj_desc->common_field.base_byte_offset
+				       + field_datum_byte_offset
+				       + obj_desc->common_field.access_byte_width)) {
+		/* Access exceeds region, try to cut it down
+		 * only read bit length of the field unit, don't care about
+		 * region access (e.g. ByteAcc ...), round up to next byte */
+			ACPI_DEBUG_PRINT ((ACPI_DB_INFO, "Workaround BIOS bug - field exceeds region: "
+					   "cut access from %d bits to %d", ACPI_MUL_8 (obj_desc->common_field.access_byte_width),
+					   (obj_desc->common_field.bit_length + 7 ) & ~7));
+			status = acpi_ev_address_space_dispatch (rgn_desc, function,
+								 address, (obj_desc->common_field.bit_length + 7) & ~7, value);
+	}
+	else{
+		status = acpi_ev_address_space_dispatch (rgn_desc, function,
+							 address, ACPI_MUL_8 (obj_desc->common_field.access_byte_width), value);
+	}
+
+

 	if (ACPI_FAILURE (status)) {
 		if (status == AE_NOT_IMPLEMENTED) {


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
