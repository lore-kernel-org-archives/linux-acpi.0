From: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Subject: RE: [PATCH] sbs: Use i2c_smbus_xfer
Date: Fri, 16 Feb 2007 08:54:25 +0300
Message-ID: <8E389A5F2FEABA4CB1DEC35A25CB39CEA642CD@mssmsx411>
References: <20070215215215.ccb9c132.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13607 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932601AbXBPFyb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Feb 2007 00:54:31 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20070215215215.ccb9c132.khali@linux-fr.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-acpi@vger.kernel.org

Yes, you are right, but we are going to remove i2c objects from sbs
driver in near future.

Thanks.
Vladimir.

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Thursday, February 15, 2007 11:52 PM
To: Lebedev, Vladimir P
Cc: linux-acpi@vger.kernel.org
Subject: [PATCH] sbs: Use i2c_smbus_xfer

Use i2c_smbus_xfer() in the ACPI SBS driver, instead of explicitely
calling the i2c bus driver's smbus_xfer() function. This is the right
thing to do for two reasons:
* i2c-core takes care of concurrent accesses to the bus.
* i2c-core can emulate SMBus transactions over an I2C bus. This will
make
  it possible to use the sbs driver on top of other i2c bus drivers than
  i2c_ec.

As a side effect, I fixed a bug in acpi_battery_smbus_err_handler(),
which was starting an SMBus block read transaction instead of an SMBus
word read.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/acpi/sbs.c |   37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

--- linux-2.6.21-pre.orig/drivers/acpi/sbs.c	2007-02-15
20:38:33.000000000 +0100
+++ linux-2.6.21-pre/drivers/acpi/sbs.c	2007-02-15 20:46:03.000000000
+0100
@@ -189,10 +189,9 @@ static void acpi_battery_smbus_err_handl
 
 	data.word = 0;
 
-	result = smbus->adapter.algo->
-	    smbus_xfer(&smbus->adapter,
-		       ACPI_SB_SMBUS_ADDR,
-		       0, I2C_SMBUS_READ, 0x16, I2C_SMBUS_BLOCK_DATA,
&data);
+	result = i2c_smbus_xfer(&smbus->adapter, ACPI_SB_SMBUS_ADDR, 0,
+				I2C_SMBUS_READ, 0x16,
I2C_SMBUS_WORD_DATA,
+				&data);
 
 	err_number = (data.word & 0x000f);
 
@@ -242,13 +241,12 @@ acpi_sbs_smbus_read_word(struct acpi_ec_
 	}
 
 	for (i = 0; i < MAX_SMBUS_ERR; i++) {
-		result =
-		    smbus->adapter.algo->smbus_xfer(&smbus->adapter,
addr, 0,
-						    I2C_SMBUS_READ,
func,
-						    I2C_SMBUS_WORD_DATA,
&data);
+		result = i2c_smbus_xfer(&smbus->adapter, addr, 0,
+					I2C_SMBUS_READ, func,
+					I2C_SMBUS_WORD_DATA, &data);
 		if (result) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "try %i:
smbus->adapter.algo->smbus_xfer() failed\n",
+					  "try %i: i2c_smbus_xfer()
failed\n",
 					  i));
 			if (err_handler) {
 				err_handler(smbus);
@@ -276,14 +274,12 @@ acpi_sbs_smbus_read_str(struct acpi_ec_s
 	}
 
 	for (i = 0; i < MAX_SMBUS_ERR; i++) {
-		result =
-		    smbus->adapter.algo->smbus_xfer(&smbus->adapter,
addr, 0,
-						    I2C_SMBUS_READ,
func,
-
I2C_SMBUS_BLOCK_DATA,
-						    &data);
+		result = i2c_smbus_xfer(&smbus->adapter, addr, 0,
+					I2C_SMBUS_READ, func,
+					I2C_SMBUS_BLOCK_DATA, &data);
 		if (result) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "try %i:
smbus->adapter.algo->smbus_xfer() failed\n",
+					  "try %i: i2c_smbus_xfer()
failed\n",
 					  i));
 			if (err_handler) {
 				err_handler(smbus);
@@ -315,14 +311,13 @@ acpi_sbs_smbus_write_word(struct acpi_ec
 	data.word = word;
 
 	for (i = 0; i < MAX_SMBUS_ERR; i++) {
-		result =
-		    smbus->adapter.algo->smbus_xfer(&smbus->adapter,
addr, 0,
-						    I2C_SMBUS_WRITE,
func,
-						    I2C_SMBUS_WORD_DATA,
&data);
+		result = i2c_smbus_xfer(&smbus->adapter, addr, 0,
+					I2C_SMBUS_WRITE, func,
+					I2C_SMBUS_WORD_DATA, &data);
 		if (result) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					  "try %i: smbus->adapter.algo"
-					  "->smbus_xfer() failed\n",
i));
+					  "try %i: i2c_smbus_xfer()
failed\n",
+					  i));
 			if (err_handler) {
 				err_handler(smbus);
 			}


-- 
Jean Delvare
