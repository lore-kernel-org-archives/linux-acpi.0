From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ACPI EC address space handler - Re: ACPI key events
	handling
Date: Fri, 11 Mar 2005 10:23:38 +0800
Message-ID: <1110507818.3692.4.camel@sli10-desk.sh.intel.com>
References: <16A54BF5D6E14E4D916CE26C9AD30575015B5180@pdsmsx402.ccr.corp.intel.com>
	 <42307593.8040501@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <42307593.8040501-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Paulo Vitor Magacho da Silva <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is an updated patch.
It fixes:
1. changed *value when write
2. wrong address offset for read/write with bit width > 8
and some cleanup.

Thanks,
Shaohua

---

 2.5-root/drivers/acpi/ec.c |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

diff -puN drivers/acpi/ec.c~ec_addr_space_handler drivers/acpi/ec.c
--- 2.5/drivers/acpi/ec.c~ec_addr_space_handler	2005-03-08 09:19:05.000000000 +0800
+++ 2.5-root/drivers/acpi/ec.c	2005-03-11 10:18:25.595072776 +0800
@@ -441,7 +441,7 @@ acpi_ec_space_handler (
 {
 	int			result = 0;
 	struct acpi_ec		*ec = NULL;
-	u32			temp = 0;
+	u64			temp = *value;
 	acpi_integer		f_v = 0;
 	int 			i = 0;
 
@@ -450,10 +450,9 @@ acpi_ec_space_handler (
 	if ((address > 0xFF) || !value || !handler_context)
 		return_VALUE(AE_BAD_PARAMETER);
 
-	if(bit_width != 8) {
+	if (bit_width != 8 && acpi_strict) {
 		printk(KERN_WARNING PREFIX "acpi_ec_space_handler: bit_width should be 8\n");
-		if (acpi_strict)
-			return_VALUE(AE_BAD_PARAMETER);
+		return_VALUE(AE_BAD_PARAMETER);
 	}
 
 	ec = (struct acpi_ec *) handler_context;
@@ -461,11 +460,11 @@ acpi_ec_space_handler (
 next_byte:
 	switch (function) {
 	case ACPI_READ:
-		result = acpi_ec_read(ec, (u8) address, &temp);
-		*value = (acpi_integer) temp;
+		temp = 0;
+		result = acpi_ec_read(ec, (u8) address, (u32 *)&temp);
 		break;
 	case ACPI_WRITE:
-		result = acpi_ec_write(ec, (u8) address, (u8) *value);
+		result = acpi_ec_write(ec, (u8) address, (u8) temp);
 		break;
 	default:
 		result = -EINVAL;
@@ -474,19 +473,18 @@ next_byte:
 	}
 
 	bit_width -= 8;
-	if(bit_width){
-
-		if(function == ACPI_READ)
-			f_v |= (acpi_integer) (*value) << 8*i;
-		if(function == ACPI_WRITE)
-			(*value) >>=8; 
+	if (bit_width) {
+		if (function == ACPI_READ)
+			f_v |= temp << 8 * i;
+		if (function == ACPI_WRITE)
+			temp >>= 8;
 		i++;
+		(u8)address ++;
 		goto next_byte;
 	}
 
-
-	if(function == ACPI_READ){
-		f_v |= (acpi_integer) (*value) << 8*i;
+	if (function == ACPI_READ) {
+		f_v |= temp << 8 * i;
 		*value = f_v;
 	}
 
@@ -505,8 +503,6 @@ out:
 	default:
 		return_VALUE(AE_OK);
 	}
-	
-
 }
 
 
_




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
