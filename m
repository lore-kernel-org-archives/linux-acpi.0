From: "Brown, Len" <len.brown@intel.com>
Subject: RE: + acpi-ec_transaction-second-try.patch added to -mm tree
Date: Thu, 24 Aug 2006 02:21:57 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB60151892C@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53119 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030330AbWHXGWI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Aug 2006 02:22:08 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: mzxreary@0pointer.de, "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org

Applied to acpi-test.
thanks,
-Len

>-----Original Message-----
>From: akpm@osdl.org [mailto:akpm@osdl.org] 
>Sent: Monday, August 21, 2006 6:53 PM
>To: mm-commits@vger.kernel.org
>Cc: mzxreary@0pointer.de; Brown, Len; Yu, Luming
>Subject: + acpi-ec_transaction-second-try.patch added to -mm tree
>
>
>The patch titled
>
>     acpi: ec_transaction()
>
>has been added to the -mm tree.  Its filename is
>
>     acpi-ec_transaction-second-try.patch
>
>See 
>http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
>out what to do about this
>
>------------------------------------------------------
>Subject: acpi: ec_transaction()
>From: Lennart Poettering <mzxreary@0pointer.de>
>
>Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>
>Cc: "Brown, Len" <len.brown@intel.com>
>Cc: "Yu, Luming" <luming.yu@intel.com>
>Signed-off-by: Andrew Morton <akpm@osdl.org>
>---
>
> drivers/acpi/ec.c    |  325 +++++++++++------------------------------
> include/linux/acpi.h |    3 
> 2 files changed, 98 insertions(+), 230 deletions(-)
>
>diff -puN drivers/acpi/ec.c~acpi-ec_transaction-second-try 
>drivers/acpi/ec.c
>--- a/drivers/acpi/ec.c~acpi-ec_transaction-second-try
>+++ a/drivers/acpi/ec.c
>@@ -122,12 +122,12 @@ union acpi_ec {
> 
> static int acpi_ec_poll_wait(union acpi_ec *ec, u8 event);
> static int acpi_ec_intr_wait(union acpi_ec *ec, unsigned int event);
>-static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, 
>u32 * data);
>-static int acpi_ec_intr_read(union acpi_ec *ec, u8 address, 
>u32 * data);
>-static int acpi_ec_poll_write(union acpi_ec *ec, u8 address, u8 data);
>-static int acpi_ec_intr_write(union acpi_ec *ec, u8 address, u8 data);
>-static int acpi_ec_poll_query(union acpi_ec *ec, u32 * data);
>-static int acpi_ec_intr_query(union acpi_ec *ec, u32 * data);
>+static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,
>+                                    const u8 *wdata, unsigned 
>wdata_len,
>+                                    u8 *rdata, unsigned rdata_len);
>+static int acpi_ec_intr_transaction(union acpi_ec *ec, u8 command,
>+                                    const u8 *wdata, unsigned 
>wdata_len,
>+                                    u8 *rdata, unsigned rdata_len);
> static void acpi_ec_gpe_poll_query(void *ec_cxt);
> static void acpi_ec_gpe_intr_query(void *ec_cxt);
> static u32 acpi_ec_gpe_poll_handler(void *data);
>@@ -302,110 +302,95 @@ end:
> }
> #endif /* ACPI_FUTURE_USAGE */
> 
>-static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
>+static int acpi_ec_transaction(union acpi_ec *ec, u8 command,
>+                               const u8 *wdata, unsigned wdata_len,
>+                               u8 *rdata, unsigned rdata_len)
> {
> 	if (acpi_ec_poll_mode)
>-		return acpi_ec_poll_read(ec, address, data);
>+		return acpi_ec_poll_transaction(ec, command, 
>wdata, wdata_len, rdata, rdata_len);
> 	else
>-		return acpi_ec_intr_read(ec, address, data);
>+		return acpi_ec_intr_transaction(ec, command, 
>wdata, wdata_len, rdata, rdata_len);
>+}
>+static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
>+{
>+        int result;
>+        u8 d;
>+        result = acpi_ec_transaction(ec, 
>ACPI_EC_COMMAND_READ, &address, 1, &d, 1);
>+        *data = d;
>+        return result;
> }
> static int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
> {
>-	if (acpi_ec_poll_mode)
>-		return acpi_ec_poll_write(ec, address, data);
>-	else
>-		return acpi_ec_intr_write(ec, address, data);
>+        u8 wdata[2] = { address, data };
>+        return acpi_ec_transaction(ec, ACPI_EC_COMMAND_WRITE, 
>wdata, 2, NULL, 0);
> }
>-static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, 
>u32 * data)
>+
>+static int acpi_ec_transaction_unlocked(union acpi_ec *ec, u8 command,
>+                                             const u8 *wdata, 
>unsigned wdata_len,
>+                                             u8 *rdata, 
>unsigned rdata_len)
> {
>-	acpi_status status = AE_OK;
>-	int result = 0;
>-	u32 glk = 0;
>+	int result;
> 
>+	acpi_hw_low_level_write(8, command, &ec->common.command_addr);
> 
>-	if (!ec || !data)
>-		return -EINVAL;
>+        result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>+	if (result)
>+		return result;
> 
>-	*data = 0;
>+        for (; wdata_len > 0; wdata_len --) {
> 
>-	if (ec->common.global_lock) {
>-		status = 
>acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
>-		if (ACPI_FAILURE(status))
>-			return -ENODEV;
>-	}
>+                acpi_hw_low_level_write(8, *(wdata++), 
>&ec->common.data_addr);
> 
>-	if (down_interruptible(&ec->poll.sem)) {
>-		result = -ERESTARTSYS;
>-		goto end_nosem;
>-	}
>-	
>-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,
>-				&ec->common.command_addr);
>-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>-	if (result)
>-		goto end;
>+                result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>+                if (result)
>+                        return result;
>+        }
> 
>-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
>-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
>-	if (result)
>-		goto end;
> 
>-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
>+        for (; rdata_len > 0; rdata_len --) {
>+                u32 d;
> 
>-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from 
>address [%02x]\n",
>-			  *data, address));
>+                result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
>+                if (result)
>+                        return result;
> 
>-      end:
>-	up(&ec->poll.sem);
>-end_nosem:
>-	if (ec->common.global_lock)
>-		acpi_release_global_lock(glk);
>+                acpi_hw_low_level_read(8, &d, &ec->common.data_addr);
>+                *(rdata++) = (u8) d;
>+        }
> 
>-	return result;
>+        return 0;
> }
> 
>-static int acpi_ec_poll_write(union acpi_ec *ec, u8 address, u8 data)
>+static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,
>+                                    const u8 *wdata, unsigned 
>wdata_len,
>+                                    u8 *rdata, unsigned rdata_len)
> {
>-	int result = 0;
> 	acpi_status status = AE_OK;
>+	int result;
> 	u32 glk = 0;
> 
>-
>-	if (!ec)
>+	if (!ec || (wdata_len && !wdata) || (rdata_len && !rdata))
> 		return -EINVAL;
> 
>+        if (rdata)
>+                memset(rdata, 0, rdata_len);
>+
> 	if (ec->common.global_lock) {
> 		status = 
>acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
> 		if (ACPI_FAILURE(status))
> 			return -ENODEV;
>-	}
>+        }
> 
> 	if (down_interruptible(&ec->poll.sem)) {
> 		result = -ERESTARTSYS;
> 		goto end_nosem;
> 	}
>-	
>-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE,
>-				&ec->common.command_addr);
>-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>-	if (result)
>-		goto end;
> 
>-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
>-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>-	if (result)
>-		goto end;
>-
>-	acpi_hw_low_level_write(8, data, &ec->common.data_addr);
>-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>-	if (result)
>-		goto end;
>-
>-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Wrote [%02x] to 
>address [%02x]\n",
>-			  data, address));
>-
>-      end:
>+        result = acpi_ec_transaction_unlocked(ec, command,
>+                                              wdata, wdata_len,
>+                                              rdata, rdata_len);
> 	up(&ec->poll.sem);
>+
> end_nosem:
> 	if (ec->common.global_lock)
> 		acpi_release_global_lock(glk);
>@@ -413,16 +398,18 @@ end_nosem:
> 	return result;
> }
> 
>-static int acpi_ec_intr_read(union acpi_ec *ec, u8 address, 
>u32 * data)
>+static int acpi_ec_intr_transaction(union acpi_ec *ec, u8 command,
>+                                    const u8 *wdata, unsigned 
>wdata_len,
>+                                    u8 *rdata, unsigned rdata_len)
> {
>-	int status = 0;
>+	int status;
> 	u32 glk;
> 
>-
>-	if (!ec || !data)
>+	if (!ec || (wdata_len && !wdata) || (rdata_len && !rdata))
> 		return -EINVAL;
> 
>-	*data = 0;
>+        if (rdata)
>+                memset(rdata, 0, rdata_len);
> 
> 	if (ec->common.global_lock) {
> 		status = 
>acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
>@@ -438,72 +425,12 @@ static int acpi_ec_intr_read(union acpi_
> 		printk(KERN_DEBUG PREFIX "read EC, IB not empty\n");
> 		goto end;
> 	}
>-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,
>-				&ec->common.command_addr);
>-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>-	if (status) {
>-		printk(KERN_DEBUG PREFIX "read EC, IB not empty\n");
>-	}
>-
>-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
>-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
>-	if (status) {
>-		printk(KERN_DEBUG PREFIX "read EC, OB not full\n");
>-		goto end;
>-	}
>-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
>-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from 
>address [%02x]\n",
>-			  *data, address));
>-
>-      end:
>-	up(&ec->intr.sem);
>-
>-	if (ec->common.global_lock)
>-		acpi_release_global_lock(glk);
>-
>-	return status;
>-}
>-
>-static int acpi_ec_intr_write(union acpi_ec *ec, u8 address, u8 data)
>-{
>-	int status = 0;
>-	u32 glk;
>-
>-
>-	if (!ec)
>-		return -EINVAL;
>-
>-	if (ec->common.global_lock) {
>-		status = 
>acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
>-		if (ACPI_FAILURE(status))
>-			return -ENODEV;
>-	}
>-
>-	WARN_ON(in_interrupt());
>-	down(&ec->intr.sem);
>-
>-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>-	if (status) {
>-		printk(KERN_DEBUG PREFIX "write EC, IB not empty\n");
>-	}
>-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE,
>-				&ec->common.command_addr);
>-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>-	if (status) {
>-		printk(KERN_DEBUG PREFIX "write EC, IB not empty\n");
>-	}
>-
>-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
>-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>-	if (status) {
>-		printk(KERN_DEBUG PREFIX "write EC, IB not empty\n");
>-	}
> 
>-	acpi_hw_low_level_write(8, data, &ec->common.data_addr);
>-
>-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Wrote [%02x] to 
>address [%02x]\n",
>-			  data, address));
>+        status = acpi_ec_transaction_unlocked(ec, command,
>+                                              wdata, wdata_len,
>+                                              rdata, rdata_len);
> 
>+end:
> 	up(&ec->intr.sem);
> 
> 	if (ec->common.global_lock)
>@@ -554,106 +481,44 @@ int ec_write(u8 addr, u8 val)
> 
> EXPORT_SYMBOL(ec_write);
> 
>-static int acpi_ec_query(union acpi_ec *ec, u32 * data)
>-{
>-	if (acpi_ec_poll_mode)
>-		return acpi_ec_poll_query(ec, data);
>-	else
>-		return acpi_ec_intr_query(ec, data);
>-}
>-static int acpi_ec_poll_query(union acpi_ec *ec, u32 * data)
>+extern int ec_transaction(u8 command,
>+                          const u8 *wdata, unsigned wdata_len,
>+                          u8 *rdata, unsigned rdata_len)
> {
>-	int result = 0;
>-	acpi_status status = AE_OK;
>-	u32 glk = 0;
>-
>-
>-	if (!ec || !data)
>-		return -EINVAL;
>-
>-	*data = 0;
>-
>-	if (ec->common.global_lock) {
>-		status = 
>acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
>-		if (ACPI_FAILURE(status))
>-			return -ENODEV;
>-	}
>-
>-	/*
>-	 * Query the EC to find out which _Qxx method we need 
>to evaluate.
>-	 * Note that successful completion of the query causes 
>the ACPI_EC_SCI
>-	 * bit to be cleared (and thus clearing the interrupt source).
>-	 */
>-	if (down_interruptible(&ec->poll.sem)) {
>-		result = -ERESTARTSYS;
>-		goto end_nosem;
>-	}
>-	
>-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,
>-				&ec->common.command_addr);
>-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
>-	if (result)
>-		goto end;
>+	union acpi_ec *ec;
> 
>-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
>-	if (!*data)
>-		result = -ENODATA;
>+	if (!first_ec)
>+		return -ENODEV;
> 
>-      end:
>-	up(&ec->poll.sem);
>-end_nosem:
>-	if (ec->common.global_lock)
>-		acpi_release_global_lock(glk);
>+	ec = acpi_driver_data(first_ec);
> 
>-	return result;
>+	return acpi_ec_transaction(ec, command, wdata, 
>wdata_len, rdata, rdata_len);
> }
>-static int acpi_ec_intr_query(union acpi_ec *ec, u32 * data)
>-{
>-	int status = 0;
>-	u32 glk;
> 
>+EXPORT_SYMBOL(ec_transaction);
> 
>-	if (!ec || !data)
>-		return -EINVAL;
>-	*data = 0;
>+static int acpi_ec_query(union acpi_ec *ec, u32 * data) {
>+        int result;
>+        u8 d;
> 
>-	if (ec->common.global_lock) {
>-		status = 
>acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
>-		if (ACPI_FAILURE(status))
>-			return -ENODEV;
>-	}
>+        if (!ec || !data)
>+                return -EINVAL;
> 
>-	down(&ec->intr.sem);
>+        /*
>+         * Query the EC to find out which _Qxx method we need 
>to evaluate.
>+         * Note that successful completion of the query 
>causes the ACPI_EC_SCI
>+         * bit to be cleared (and thus clearing the interrupt source).
>+         */
> 
>-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
>-	if (status) {
>-		printk(KERN_DEBUG PREFIX "query EC, IB not empty\n");
>-		goto end;
>-	}
>-	/*
>-	 * Query the EC to find out which _Qxx method we need 
>to evaluate.
>-	 * Note that successful completion of the query causes 
>the ACPI_EC_SCI
>-	 * bit to be cleared (and thus clearing the interrupt source).
>-	 */
>-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,
>-				&ec->common.command_addr);
>-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
>-	if (status) {
>-		printk(KERN_DEBUG PREFIX "query EC, OB not full\n");
>-		goto end;
>-	}
>-
>-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
>-	if (!*data)
>-		status = -ENODATA;
>+        result = acpi_ec_transaction(ec, 
>ACPI_EC_COMMAND_QUERY, NULL, 0, &d, 1);
>+        if (result)
>+                return result;
> 
>-      end:
>-	up(&ec->intr.sem);
>+        if (!d)
>+                return -ENODATA;
> 
>-	if (ec->common.global_lock)
>-		acpi_release_global_lock(glk);
>-
>-	return status;
>+        *data = d;
>+        return 0;
> }
> 
> /* 
>---------------------------------------------------------------
>-----------
>diff -puN include/linux/acpi.h~acpi-ec_transaction-second-try 
>include/linux/acpi.h
>--- a/include/linux/acpi.h~acpi-ec_transaction-second-try
>+++ a/include/linux/acpi.h
>@@ -494,6 +494,9 @@ void acpi_pci_unregister_driver(struct a
> 
> extern int ec_read(u8 addr, u8 *val);
> extern int ec_write(u8 addr, u8 val);
>+extern int ec_transaction(u8 command,
>+                          const u8 *wdata, unsigned wdata_len,
>+                          u8 *rdata, unsigned rdata_len);
> 
> #endif /*CONFIG_ACPI_EC*/
> 
>_
>
>Patches currently in -mm which might be from mzxreary@0pointer.de are
>
>acpi-ec_transaction-second-try.patch
>
