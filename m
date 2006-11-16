From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Fri, 17 Nov 2006 00:56:05 +0300
Message-ID: <455CDE75.3050001@linux.intel.com>
References: <200611142303.47325.david-b@pacbell.net> <200611160803.04152.david-b@pacbell.net> <455C907A.8080600@linux.intel.com> <200611160853.48748.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000409070501090302090001"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:53296 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1424722AbWKPV4O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Nov 2006 16:56:14 -0500
In-Reply-To: <200611160853.48748.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000409070501090302090001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David,

It looks like problem with recent changes to EC driver, so could you 
please try to revert those patches one-by-one in order to
find problematic one... I'm attaching patches: ec_x1 is the first in 
series and ec_x7 is the last...

Thanks in advance,
    Alex.



David Brownell wrote:
> On Thursday 16 November 2006 8:23 am, Alexey Starikovskiy wrote:
>   
>> David Brownell wrote:
>>     
>>> On Thursday 16 November 2006 7:41 am, Alexey Starikovskiy wrote:
>>>   
>>>       
>>>> Looks like either EC GPE or whole ACPI irq got disabled... Could you 
>>>> check that ACPI interrupts still arrive after
>>>> you notice AE_TIME?
>>>>     
>>>>         
>>> If I unplug AC, /proc/interrrupts reports 2 IRQs going to ACPI.
>>> Then on replug, it reports 10-12 IRQs going to ACPI.
>>>   
>>>       
>> What is the state of kacpid and kacpid_notify ?
>>     
>
> Not clear what you mean by this, but:
>
> $ ps ax | grep acpi
>    51 ?        S<     0:00 [kacpid]
>    52 ?        S<     0:00 [kacpi_notify]
>  2971 ?        Ss     0:00 /usr/sbin/acpid -c /etc/acpi/events.ignore
> 19240 pts/2    R+     0:00 grep acpi
> $ 
>
>
>   
>>>   
>>>       
>>>> Also, may be attached patch will help?
>>>>     
>>>>         
>>> I'l give it a try next time I can reboot (presumably by this PM).
>>>
>>> - Dave
>>>
>>>
>>>   
>>>       
>>>> Regards,
>>>>     Alex.
>>>>
>>>> David Brownell wrote:
>>>>     
>>>>         
>>>>> On Wednesday 15 November 2006 1:56 pm, David Brownell wrote:
>>>>>   
>>>>>       
>>>>>           
>>>>>> On Wednesday 15 November 2006 6:48 am, Alexey Starikovskiy wrote:
>>>>>>     
>>>>>>         
>>>>>>             
>>>>>>> ec1.patch
>>>>>>>
>>>>>>>
>>>>>>> Always enable GPE after return from notify handler.
>>>>>>>
>>>>>>> From:  Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
>>>>>>>
>>>>>>>
>>>>>>> ---
>>>>>>>       
>>>>>>>           
>>>>>>>               
>>>>>> Yes, this seems to resolve the regression as well as Len's ec_intr=0 boot param.
>>>>>>     
>>>>>>         
>>>>>>             
>>>>> Whoops, I spoke too soon.  It does get rid of SOME of the AE_TIME errors.  But
>>>>> the system is still confused about whether or not the AC is connected, and
>>>>> whether the battery is charging or not; and the CPU is still relatively hot.
>>>>> Even with this patch I later got:
>>>>>
>>>>> ACPI Exception (evregion-0424): AE_TIME, Returned by Handler for [EmbeddedControl] [20060707]
>>>>> ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [OpcodeName unavailable] [2006070
>>>>> 7]
>>>>> ACPI Error (psparse-0537): Method parse/execution failed [\_TZ_.THRM._TMP] (Node ffff810002032d10), AE
>>>>> _TIME
>>>>>
>>>>> In short, better but evidently not yet good enough...
>>>>>
>>>>> - Dave
>>>>>
>>>>>
>>>>>
>>>>>   
>>>>>       
>>>>>           
>>>>>> IMO this should get merged into 2.6.19 ASAP ...
>>>>>>
>>>>>>
>>>>>>     
>>>>>>         
>>>>>>             
>>>>>>>  drivers/acpi/ec.c |    2 --
>>>>>>>  1 files changed, 0 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>>>>>>> index e6d4b08..937eafc 100644
>>>>>>> --- a/drivers/acpi/ec.c
>>>>>>> +++ b/drivers/acpi/ec.c
>>>>>>> @@ -465,8 +465,6 @@ static u32 acpi_ec_gpe_handler(void *dat
>>>>>>>  
>>>>>>>         if (value & ACPI_EC_FLAG_SCI) {
>>>>>>>                 status = acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
>>>>>>> -               return status == AE_OK ?
>>>>>>> -                   ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
>>>>>>>         }
>>>>>>>         acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
>>>>>>>         return status == AE_OK ?
>>>>>>>       
>>>>>>>           
>>>>>>>               
>>>>     
>>>>         
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   


--------------000409070501090302090001
Content-Type: text/plain;
 name="ec_x7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ec_x7.patch"

commit ab9e43c640b2b7d6e296fc39dd8cbcb96f9ae393
Author: Lennart Poettering <mzxreary@0pointer.de>
Date:   Tue Oct 3 22:49:00 2006 -0400

    ACPI: EC: export ec_transaction() for msi-laptop driver
    
    Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ae05e8c..e6d4b08 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -384,6 +384,8 @@ extern int ec_transaction(u8 command,
 				   wdata_len, rdata, rdata_len);
 }
 
+EXPORT_SYMBOL(ec_transaction);
+
 static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 {
 	int result;

--------------000409070501090302090001
Content-Type: text/plain;
 name="ec_x1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ec_x1.patch"

commit d7a76e4cb3b4469b1eccb6204c053e3ebcd4c196
Author: Lennart Poettering <mzxreary@0pointer.de>
Date:   Tue Sep 5 12:12:24 2006 -0400

    ACPI: consolidate functions in acpi ec driver
    
    Unify the following functions:
    
        acpi_ec_poll_read()
        acpi_ec_poll_write()
        acpi_ec_poll_query()
        acpi_ec_intr_read()
        acpi_ec_intr_write()
        acpi_ec_intr_query()
    
    into:
    
        acpi_ec_poll_transaction()
        acpi_ec_intr_transaction()
    
    These new functions take as arguments an ACPI EC command, a few bytes
    to write to the EC data register and a buffer for a few bytes to read
    from the EC data register. The old _read(), _write(), _query() are
    just special cases of these functions.
    
    Then unified the code in acpi_ec_poll_transaction() and
    acpi_ec_intr_transaction() a little more. Both functions are now just
    wrappers around the new acpi_ec_transaction_unlocked() function. The
    latter contains the EC access logic, the two original
    function now just do their special way of locking and call the the
    new function for the actual work.
    
    This saves a lot of very similar code. The primary reason for doing
    this, however, is that my driver for MSI 270 laptops needs to issue
    some non-standard EC commands in a safe way. Due to this I added a new
    exported function similar to ec_write()/ec_write() which is called
    ec_transaction() and is essentially just a wrapper around
    acpi_ec_{poll,intr}_transaction().
    
    Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>
    Acked-by: Luming Yu <luming.yu@intel.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index e5d7963..a0dcbad 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -122,12 +122,12 @@ union acpi_ec {
 
 static int acpi_ec_poll_wait(union acpi_ec *ec, u8 event);
 static int acpi_ec_intr_wait(union acpi_ec *ec, unsigned int event);
-static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, u32 * data);
-static int acpi_ec_intr_read(union acpi_ec *ec, u8 address, u32 * data);
-static int acpi_ec_poll_write(union acpi_ec *ec, u8 address, u8 data);
-static int acpi_ec_intr_write(union acpi_ec *ec, u8 address, u8 data);
-static int acpi_ec_poll_query(union acpi_ec *ec, u32 * data);
-static int acpi_ec_intr_query(union acpi_ec *ec, u32 * data);
+static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,
+                                    const u8 *wdata, unsigned wdata_len,
+                                    u8 *rdata, unsigned rdata_len);
+static int acpi_ec_intr_transaction(union acpi_ec *ec, u8 command,
+                                    const u8 *wdata, unsigned wdata_len,
+                                    u8 *rdata, unsigned rdata_len);
 static void acpi_ec_gpe_poll_query(void *ec_cxt);
 static void acpi_ec_gpe_intr_query(void *ec_cxt);
 static u32 acpi_ec_gpe_poll_handler(void *data);
@@ -302,110 +302,95 @@ end:
 }
 #endif /* ACPI_FUTURE_USAGE */
 
-static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
+static int acpi_ec_transaction(union acpi_ec *ec, u8 command,
+                               const u8 *wdata, unsigned wdata_len,
+                               u8 *rdata, unsigned rdata_len)
 {
 	if (acpi_ec_poll_mode)
-		return acpi_ec_poll_read(ec, address, data);
+		return acpi_ec_poll_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
 	else
-		return acpi_ec_intr_read(ec, address, data);
+		return acpi_ec_intr_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
+}
+static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
+{
+        int result;
+        u8 d;
+        result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_READ, &address, 1, &d, 1);
+        *data = d;
+        return result;
 }
 static int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
 {
-	if (acpi_ec_poll_mode)
-		return acpi_ec_poll_write(ec, address, data);
-	else
-		return acpi_ec_intr_write(ec, address, data);
+        u8 wdata[2] = { address, data };
+        return acpi_ec_transaction(ec, ACPI_EC_COMMAND_WRITE, wdata, 2, NULL, 0);
 }
-static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, u32 * data)
+
+static int acpi_ec_transaction_unlocked(union acpi_ec *ec, u8 command,
+                                             const u8 *wdata, unsigned wdata_len,
+                                             u8 *rdata, unsigned rdata_len)
 {
-	acpi_status status = AE_OK;
-	int result = 0;
-	u32 glk = 0;
+	int result;
 
+	acpi_hw_low_level_write(8, command, &ec->common.command_addr);
 
-	if (!ec || !data)
-		return -EINVAL;
+        result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	if (result)
+		return result;
 
-	*data = 0;
+        for (; wdata_len > 0; wdata_len --) {
 
-	if (ec->common.global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-	}
+                acpi_hw_low_level_write(8, *(wdata++), &ec->common.data_addr);
 
-	if (down_interruptible(&ec->poll.sem)) {
-		result = -ERESTARTSYS;
-		goto end_nosem;
-	}
-	
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,
-				&ec->common.command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
-		goto end;
+                result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+                if (result)
+                        return result;
+        }
 
-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (result)
-		goto end;
 
-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
+        for (; rdata_len > 0; rdata_len --) {
+                u32 d;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address [%02x]\n",
-			  *data, address));
+                result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
+                if (result)
+                        return result;
 
-      end:
-	up(&ec->poll.sem);
-end_nosem:
-	if (ec->common.global_lock)
-		acpi_release_global_lock(glk);
+                acpi_hw_low_level_read(8, &d, &ec->common.data_addr);
+                *(rdata++) = (u8) d;
+        }
 
-	return result;
+        return 0;
 }
 
-static int acpi_ec_poll_write(union acpi_ec *ec, u8 address, u8 data)
+static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,
+                                    const u8 *wdata, unsigned wdata_len,
+                                    u8 *rdata, unsigned rdata_len)
 {
-	int result = 0;
 	acpi_status status = AE_OK;
+	int result;
 	u32 glk = 0;
 
-
-	if (!ec)
+	if (!ec || (wdata_len && !wdata) || (rdata_len && !rdata))
 		return -EINVAL;
 
+        if (rdata)
+                memset(rdata, 0, rdata_len);
+
 	if (ec->common.global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status))
 			return -ENODEV;
-	}
+        }
 
 	if (down_interruptible(&ec->poll.sem)) {
 		result = -ERESTARTSYS;
 		goto end_nosem;
 	}
-	
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE,
-				&ec->common.command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
-		goto end;
 
-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
-		goto end;
-
-	acpi_hw_low_level_write(8, data, &ec->common.data_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
-		goto end;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Wrote [%02x] to address [%02x]\n",
-			  data, address));
-
-      end:
+        result = acpi_ec_transaction_unlocked(ec, command,
+                                              wdata, wdata_len,
+                                              rdata, rdata_len);
 	up(&ec->poll.sem);
+
 end_nosem:
 	if (ec->common.global_lock)
 		acpi_release_global_lock(glk);
@@ -413,16 +398,18 @@ end_nosem:
 	return result;
 }
 
-static int acpi_ec_intr_read(union acpi_ec *ec, u8 address, u32 * data)
+static int acpi_ec_intr_transaction(union acpi_ec *ec, u8 command,
+                                    const u8 *wdata, unsigned wdata_len,
+                                    u8 *rdata, unsigned rdata_len)
 {
-	int status = 0;
+	int status;
 	u32 glk;
 
-
-	if (!ec || !data)
+	if (!ec || (wdata_len && !wdata) || (rdata_len && !rdata))
 		return -EINVAL;
 
-	*data = 0;
+        if (rdata)
+                memset(rdata, 0, rdata_len);
 
 	if (ec->common.global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
@@ -438,72 +425,12 @@ static int acpi_ec_intr_read(union acpi_
 		printk(KERN_DEBUG PREFIX "read EC, IB not empty\n");
 		goto end;
 	}
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_READ,
-				&ec->common.command_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "read EC, IB not empty\n");
-	}
-
-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "read EC, OB not full\n");
-		goto end;
-	}
-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Read [%02x] from address [%02x]\n",
-			  *data, address));
-
-      end:
-	up(&ec->intr.sem);
-
-	if (ec->common.global_lock)
-		acpi_release_global_lock(glk);
-
-	return status;
-}
-
-static int acpi_ec_intr_write(union acpi_ec *ec, u8 address, u8 data)
-{
-	int status = 0;
-	u32 glk;
-
-
-	if (!ec)
-		return -EINVAL;
-
-	if (ec->common.global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-	}
-
-	WARN_ON(in_interrupt());
-	down(&ec->intr.sem);
-
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "write EC, IB not empty\n");
-	}
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_WRITE,
-				&ec->common.command_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "write EC, IB not empty\n");
-	}
-
-	acpi_hw_low_level_write(8, address, &ec->common.data_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "write EC, IB not empty\n");
-	}
 
-	acpi_hw_low_level_write(8, data, &ec->common.data_addr);
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Wrote [%02x] to address [%02x]\n",
-			  data, address));
+        status = acpi_ec_transaction_unlocked(ec, command,
+                                              wdata, wdata_len,
+                                              rdata, rdata_len);
 
+end:
 	up(&ec->intr.sem);
 
 	if (ec->common.global_lock)
@@ -554,106 +481,44 @@ int ec_write(u8 addr, u8 val)
 
 EXPORT_SYMBOL(ec_write);
 
-static int acpi_ec_query(union acpi_ec *ec, u32 * data)
-{
-	if (acpi_ec_poll_mode)
-		return acpi_ec_poll_query(ec, data);
-	else
-		return acpi_ec_intr_query(ec, data);
-}
-static int acpi_ec_poll_query(union acpi_ec *ec, u32 * data)
+extern int ec_transaction(u8 command,
+                          const u8 *wdata, unsigned wdata_len,
+                          u8 *rdata, unsigned rdata_len)
 {
-	int result = 0;
-	acpi_status status = AE_OK;
-	u32 glk = 0;
-
-
-	if (!ec || !data)
-		return -EINVAL;
-
-	*data = 0;
-
-	if (ec->common.global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-	}
-
-	/*
-	 * Query the EC to find out which _Qxx method we need to evaluate.
-	 * Note that successful completion of the query causes the ACPI_EC_SCI
-	 * bit to be cleared (and thus clearing the interrupt source).
-	 */
-	if (down_interruptible(&ec->poll.sem)) {
-		result = -ERESTARTSYS;
-		goto end_nosem;
-	}
-	
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,
-				&ec->common.command_addr);
-	result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (result)
-		goto end;
+	union acpi_ec *ec;
 
-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
-	if (!*data)
-		result = -ENODATA;
+	if (!first_ec)
+		return -ENODEV;
 
-      end:
-	up(&ec->poll.sem);
-end_nosem:
-	if (ec->common.global_lock)
-		acpi_release_global_lock(glk);
+	ec = acpi_driver_data(first_ec);
 
-	return result;
+	return acpi_ec_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
 }
-static int acpi_ec_intr_query(union acpi_ec *ec, u32 * data)
-{
-	int status = 0;
-	u32 glk;
 
+EXPORT_SYMBOL(ec_transaction);
 
-	if (!ec || !data)
-		return -EINVAL;
-	*data = 0;
+static int acpi_ec_query(union acpi_ec *ec, u32 * data) {
+        int result;
+        u8 d;
 
-	if (ec->common.global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-	}
+        if (!ec || !data)
+                return -EINVAL;
 
-	down(&ec->intr.sem);
+        /*
+         * Query the EC to find out which _Qxx method we need to evaluate.
+         * Note that successful completion of the query causes the ACPI_EC_SCI
+         * bit to be cleared (and thus clearing the interrupt source).
+         */
 
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "query EC, IB not empty\n");
-		goto end;
-	}
-	/*
-	 * Query the EC to find out which _Qxx method we need to evaluate.
-	 * Note that successful completion of the query causes the ACPI_EC_SCI
-	 * bit to be cleared (and thus clearing the interrupt source).
-	 */
-	acpi_hw_low_level_write(8, ACPI_EC_COMMAND_QUERY,
-				&ec->common.command_addr);
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-	if (status) {
-		printk(KERN_DEBUG PREFIX "query EC, OB not full\n");
-		goto end;
-	}
-
-	acpi_hw_low_level_read(8, data, &ec->common.data_addr);
-	if (!*data)
-		status = -ENODATA;
+        result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_QUERY, NULL, 0, &d, 1);
+        if (result)
+                return result;
 
-      end:
-	up(&ec->intr.sem);
+        if (!d)
+                return -ENODATA;
 
-	if (ec->common.global_lock)
-		acpi_release_global_lock(glk);
-
-	return status;
+        *data = d;
+        return 0;
 }
 
 /* --------------------------------------------------------------------------
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 88b5dfd..2b0c955 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -494,6 +494,9 @@ #ifdef CONFIG_ACPI_EC
 
 extern int ec_read(u8 addr, u8 *val);
 extern int ec_write(u8 addr, u8 val);
+extern int ec_transaction(u8 command,
+                          const u8 *wdata, unsigned wdata_len,
+                          u8 *rdata, unsigned rdata_len);
 
 #endif /*CONFIG_ACPI_EC*/
 

--------------000409070501090302090001
Content-Type: text/plain;
 name="ec_x2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ec_x2.patch"

commit 7c6db5e51227761f42c6ac8260753f5c24dc1dde
Author: Denis M. Sadykov <denis.m.sadykov@intel.com>
Date:   Tue Sep 26 19:50:33 2006 +0400

    ACPI: EC: Remove unnecessary delay added by previous transation patch.
    
    Remove unnecessary delay (50 ms) while reading data from EC in interrupt mode.
    
    Signed-off-by: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a0dcbad..b6f935d 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -100,7 +100,7 @@ union acpi_ec {
 		struct acpi_generic_address command_addr;
 		struct acpi_generic_address data_addr;
 		unsigned long global_lock;
-		unsigned int expect_event;
+		u8 expect_event;
 		atomic_t leaving_burst;	/* 0 : No, 1 : Yes, 2: abort */
 		atomic_t pending_gpe;
 		struct semaphore sem;
@@ -121,7 +121,7 @@ union acpi_ec {
 };
 
 static int acpi_ec_poll_wait(union acpi_ec *ec, u8 event);
-static int acpi_ec_intr_wait(union acpi_ec *ec, unsigned int event);
+static int acpi_ec_intr_wait(union acpi_ec *ec, u8 event);
 static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,
                                     const u8 *wdata, unsigned wdata_len,
                                     u8 *rdata, unsigned rdata_len);
@@ -161,6 +161,22 @@ static u32 acpi_ec_read_status(union acp
 	return status;
 }
 
+static int acpi_ec_check_status(u32 status, u8 event) {
+
+	switch (event) {
+	case ACPI_EC_EVENT_OBF:
+		if (status & ACPI_EC_FLAG_OBF)
+			return 1;
+	case ACPI_EC_EVENT_IBE:
+		if (!(status & ACPI_EC_FLAG_IBF))
+			return 1;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int acpi_ec_wait(union acpi_ec *ec, u8 event)
 {
 	if (acpi_ec_poll_mode)
@@ -203,47 +219,28 @@ static int acpi_ec_poll_wait(union acpi_
 
 	return -ETIME;
 }
-static int acpi_ec_intr_wait(union acpi_ec *ec, unsigned int event)
-{
-	int result = 0;
 
+static int acpi_ec_intr_wait(union acpi_ec *ec, u8 event)
+{
+	long		time_left;
 
 	ec->intr.expect_event = event;
-	smp_mb();
 
-	switch (event) {
-	case ACPI_EC_EVENT_IBE:
-		if (~acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF) {
+	if (acpi_ec_check_status(acpi_ec_read_status(ec), event)) {
 			ec->intr.expect_event = 0;
 			return 0;
-		}
-		break;
-	default:
-		break;
 	}
 
-	result = wait_event_timeout(ec->intr.wait,
-				    !ec->intr.expect_event,
-				    msecs_to_jiffies(ACPI_EC_DELAY));
+	time_left = wait_event_timeout(ec->intr.wait, !ec->intr.expect_event,
+					msecs_to_jiffies(ACPI_EC_DELAY));
 
 	ec->intr.expect_event = 0;
-	smp_mb();
-
-	/*
-	 * Verify that the event in question has actually happened by
-	 * querying EC status. Do the check even if operation timed-out
-	 * to make sure that we did not miss interrupt.
-	 */
-	switch (event) {
-	case ACPI_EC_EVENT_OBF:
-		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_OBF)
-			return 0;
-		break;
-
-	case ACPI_EC_EVENT_IBE:
-		if (~acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF)
-			return 0;
-		break;
+	if (time_left <= 0) {
+		if (acpi_ec_check_status(acpi_ec_read_status(ec), event)) {
+				return 0;
+		}
+	} else {
+		return 0;
 	}
 
 	return -ETIME;
@@ -293,7 +290,7 @@ int acpi_ec_leave_burst_mode(union acpi_
 			goto end;
 		acpi_hw_low_level_write(8, ACPI_EC_BURST_DISABLE, &ec->common.command_addr);
 		acpi_ec_wait(ec, ACPI_EC_FLAG_IBF);
-	} 
+	}
 	atomic_set(&ec->intr.leaving_burst, 1);
 	return 0;
 end:
@@ -333,32 +330,32 @@ static int acpi_ec_transaction_unlocked(
 
 	acpi_hw_low_level_write(8, command, &ec->common.command_addr);
 
-        result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-	if (result)
-		return result;
-
-        for (; wdata_len > 0; wdata_len --) {
-
-                acpi_hw_low_level_write(8, *(wdata++), &ec->common.data_addr);
+	for (; wdata_len > 0; wdata_len --) {
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+		if (result)
+			return result;
 
-                result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
-                if (result)
-                        return result;
+		acpi_hw_low_level_write(8, *(wdata++), &ec->common.data_addr);
         }
 
+	if (command == ACPI_EC_COMMAND_WRITE) {
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+		if (result)
+			return result;
+	}
 
-        for (; rdata_len > 0; rdata_len --) {
-                u32 d;
+	for (; rdata_len > 0; rdata_len --) {
+		u32 d;
 
-                result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-                if (result)
-                        return result;
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
+		if (result)
+			return result;
 
-                acpi_hw_low_level_read(8, &d, &ec->common.data_addr);
-                *(rdata++) = (u8) d;
-        }
+		acpi_hw_low_level_read(8, &d, &ec->common.data_addr);
+		*(rdata++) = (u8) d;
+	}
 
-        return 0;
+	return 0;
 }
 
 static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,

--------------000409070501090302090001
Content-Type: text/plain;
 name="ec_x3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ec_x3.patch"

commit 703959d47e887a29dc58123c05aa0ffcbbfa131d
Author: Denis M. Sadykov <denis.m.sadykov@intel.com>
Date:   Tue Sep 26 19:50:33 2006 +0400

    ACPI: EC: Remove unused variables and duplicated code
    
    Signed-off-by: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b6f935d..c816b4e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -45,203 +45,162 @@ #define ACPI_EC_HID			"PNP0C09"
 #define ACPI_EC_DRIVER_NAME		"ACPI Embedded Controller Driver"
 #define ACPI_EC_DEVICE_NAME		"Embedded Controller"
 #define ACPI_EC_FILE_INFO		"info"
+
+/* EC status register */
 #define ACPI_EC_FLAG_OBF	0x01	/* Output buffer full */
 #define ACPI_EC_FLAG_IBF	0x02	/* Input buffer full */
 #define ACPI_EC_FLAG_BURST	0x10	/* burst mode */
 #define ACPI_EC_FLAG_SCI	0x20	/* EC-SCI occurred */
-#define ACPI_EC_EVENT_OBF	0x01	/* Output buffer full */
-#define ACPI_EC_EVENT_IBE	0x02	/* Input buffer empty */
-#define ACPI_EC_DELAY		50	/* Wait 50ms max. during EC ops */
-#define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
-#define ACPI_EC_UDELAY         100	/* Poll @ 100us increments */
-#define ACPI_EC_UDELAY_COUNT   1000	/* Wait 10ms max. during EC ops */
+
+/* EC commands */
 #define ACPI_EC_COMMAND_READ	0x80
 #define ACPI_EC_COMMAND_WRITE	0x81
 #define ACPI_EC_BURST_ENABLE	0x82
 #define ACPI_EC_BURST_DISABLE	0x83
 #define ACPI_EC_COMMAND_QUERY	0x84
-#define EC_POLL			0xFF
-#define EC_INTR			0x00
+
+/* EC events */
+enum {
+	ACPI_EC_EVENT_OBF_1 = 1,	/* Output buffer full */
+	ACPI_EC_EVENT_IBF_0,		/* Input buffer empty */
+};
+
+#define ACPI_EC_DELAY		50	/* Wait 50ms max. during EC ops */
+#define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
+#define ACPI_EC_UDELAY         100	/* Poll @ 100us increments */
+#define ACPI_EC_UDELAY_COUNT   1000	/* Wait 10ms max. during EC ops */
+
+enum {
+	EC_INTR = 1,	/* Output buffer full */
+	EC_POLL,		/* Input buffer empty */
+};
+
 static int acpi_ec_remove(struct acpi_device *device, int type);
 static int acpi_ec_start(struct acpi_device *device);
 static int acpi_ec_stop(struct acpi_device *device, int type);
-static int acpi_ec_intr_add(struct acpi_device *device);
-static int acpi_ec_poll_add(struct acpi_device *device);
+static int acpi_ec_add(struct acpi_device *device);
 
 static struct acpi_driver acpi_ec_driver = {
 	.name = ACPI_EC_DRIVER_NAME,
 	.class = ACPI_EC_CLASS,
 	.ids = ACPI_EC_HID,
 	.ops = {
-		.add = acpi_ec_intr_add,
+		.add = acpi_ec_add,
 		.remove = acpi_ec_remove,
 		.start = acpi_ec_start,
 		.stop = acpi_ec_stop,
 		},
 };
-union acpi_ec {
-	struct {
-		u32 mode;
-		acpi_handle handle;
-		unsigned long uid;
-		unsigned long gpe_bit;
-		struct acpi_generic_address status_addr;
-		struct acpi_generic_address command_addr;
-		struct acpi_generic_address data_addr;
-		unsigned long global_lock;
-	} common;
-
-	struct {
-		u32 mode;
-		acpi_handle handle;
-		unsigned long uid;
-		unsigned long gpe_bit;
-		struct acpi_generic_address status_addr;
-		struct acpi_generic_address command_addr;
-		struct acpi_generic_address data_addr;
-		unsigned long global_lock;
-		u8 expect_event;
-		atomic_t leaving_burst;	/* 0 : No, 1 : Yes, 2: abort */
-		atomic_t pending_gpe;
-		struct semaphore sem;
-		wait_queue_head_t wait;
-	} intr;
-
-	struct {
-		u32 mode;
-		acpi_handle handle;
-		unsigned long uid;
-		unsigned long gpe_bit;
-		struct acpi_generic_address status_addr;
-		struct acpi_generic_address command_addr;
-		struct acpi_generic_address data_addr;
-		unsigned long global_lock;
-		struct semaphore sem;
-	} poll;
+struct acpi_ec {
+	acpi_handle handle;
+	unsigned long uid;
+	unsigned long gpe_bit;
+	struct acpi_generic_address status_addr;
+	struct acpi_generic_address command_addr;
+	struct acpi_generic_address data_addr;
+	unsigned long global_lock;
+	struct semaphore sem;
+	unsigned int expect_event;
+	atomic_t leaving_burst;	/* 0 : No, 1 : Yes, 2: abort */
+	wait_queue_head_t wait;
 };
 
-static int acpi_ec_poll_wait(union acpi_ec *ec, u8 event);
-static int acpi_ec_intr_wait(union acpi_ec *ec, u8 event);
-static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,
+/* If we find an EC via the ECDT, we need to keep a ptr to its context */
+static struct acpi_ec *ec_ecdt;
+
+/* External interfaces use first EC only, so remember */
+static struct acpi_device *first_ec;
+static int acpi_ec_mode = EC_INTR;
+
+static int acpi_ec_poll_transaction(struct acpi_ec *ec, u8 command,
                                     const u8 *wdata, unsigned wdata_len,
                                     u8 *rdata, unsigned rdata_len);
-static int acpi_ec_intr_transaction(union acpi_ec *ec, u8 command,
+static int acpi_ec_intr_transaction(struct acpi_ec *ec, u8 command,
                                     const u8 *wdata, unsigned wdata_len,
                                     u8 *rdata, unsigned rdata_len);
 static void acpi_ec_gpe_poll_query(void *ec_cxt);
 static void acpi_ec_gpe_intr_query(void *ec_cxt);
 static u32 acpi_ec_gpe_poll_handler(void *data);
 static u32 acpi_ec_gpe_intr_handler(void *data);
-static acpi_status __init
-acpi_fake_ecdt_poll_callback(acpi_handle handle,
-				u32 Level, void *context, void **retval);
-
-static acpi_status __init
-acpi_fake_ecdt_intr_callback(acpi_handle handle,
-			      u32 Level, void *context, void **retval);
-
-static int __init acpi_ec_poll_get_real_ecdt(void);
-static int __init acpi_ec_intr_get_real_ecdt(void);
-/* If we find an EC via the ECDT, we need to keep a ptr to its context */
-static union acpi_ec *ec_ecdt;
-
-/* External interfaces use first EC only, so remember */
-static struct acpi_device *first_ec;
-static int acpi_ec_poll_mode = EC_INTR;
 
 /* --------------------------------------------------------------------------
                              Transaction Management
    -------------------------------------------------------------------------- */
 
-static u32 acpi_ec_read_status(union acpi_ec *ec)
+static u32 acpi_ec_read_status(struct acpi_ec *ec)
 {
 	u32 status = 0;
 
-	acpi_hw_low_level_read(8, &status, &ec->common.status_addr);
+	acpi_hw_low_level_read(8, &status, &ec->status_addr);
 	return status;
 }
 
-static int acpi_ec_check_status(u32 status, u8 event) {
-
-	switch (event) {
-	case ACPI_EC_EVENT_OBF:
-		if (status & ACPI_EC_FLAG_OBF)
-			return 1;
-	case ACPI_EC_EVENT_IBE:
-		if (!(status & ACPI_EC_FLAG_IBF))
-			return 1;
-	default:
-		break;
-	}
+static u32 acpi_ec_read_data(struct acpi_ec *ec)
+{
+	u32 data = 0;
 
-	return 0;
+	acpi_hw_low_level_read(8, &data, &ec->data_addr);
+	return data;
 }
 
-static int acpi_ec_wait(union acpi_ec *ec, u8 event)
+static void acpi_ec_write_cmd(struct acpi_ec *ec, u32 command)
 {
-	if (acpi_ec_poll_mode)
-		return acpi_ec_poll_wait(ec, event);
-	else
-		return acpi_ec_intr_wait(ec, event);
+	acpi_hw_low_level_write(8, command, &ec->command_addr);
 }
 
-static int acpi_ec_poll_wait(union acpi_ec *ec, u8 event)
+static void acpi_ec_write_data(struct acpi_ec *ec, u32 data)
 {
-	u32 acpi_ec_status = 0;
-	u32 i = ACPI_EC_UDELAY_COUNT;
+	acpi_hw_low_level_write(8, data, &ec->data_addr);
+}
 
-	if (!ec)
-		return -EINVAL;
+static int acpi_ec_check_status(u32 status, u8 event) {
 
-	/* Poll the EC status register waiting for the event to occur. */
 	switch (event) {
-	case ACPI_EC_EVENT_OBF:
-		do {
-			acpi_hw_low_level_read(8, &acpi_ec_status,
-					       &ec->common.status_addr);
-			if (acpi_ec_status & ACPI_EC_FLAG_OBF)
-				return 0;
-			udelay(ACPI_EC_UDELAY);
-		} while (--i > 0);
+	case ACPI_EC_EVENT_OBF_1:
+		if (status & ACPI_EC_FLAG_OBF)
+			return 1;
 		break;
-	case ACPI_EC_EVENT_IBE:
-		do {
-			acpi_hw_low_level_read(8, &acpi_ec_status,
-					       &ec->common.status_addr);
-			if (!(acpi_ec_status & ACPI_EC_FLAG_IBF))
-				return 0;
-			udelay(ACPI_EC_UDELAY);
-		} while (--i > 0);
+	case ACPI_EC_EVENT_IBF_0:
+		if (!(status & ACPI_EC_FLAG_IBF))
+			return 1;
 		break;
 	default:
-		return -EINVAL;
+		break;
 	}
 
-	return -ETIME;
+	return 0;
 }
 
-static int acpi_ec_intr_wait(union acpi_ec *ec, u8 event)
+static int acpi_ec_wait(struct acpi_ec *ec, u8 event)
 {
-	long		time_left;
-
-	ec->intr.expect_event = event;
+	int i = (acpi_ec_mode == EC_POLL) ? ACPI_EC_UDELAY_COUNT : 0;
+	long time_left;
 
+	ec->expect_event = event;
 	if (acpi_ec_check_status(acpi_ec_read_status(ec), event)) {
-			ec->intr.expect_event = 0;
-			return 0;
+		ec->expect_event = 0;
+		return 0;
 	}
 
-	time_left = wait_event_timeout(ec->intr.wait, !ec->intr.expect_event,
-					msecs_to_jiffies(ACPI_EC_DELAY));
-
-	ec->intr.expect_event = 0;
-	if (time_left <= 0) {
-		if (acpi_ec_check_status(acpi_ec_read_status(ec), event)) {
+	do {
+		if (acpi_ec_mode == EC_POLL) {
+			udelay(ACPI_EC_UDELAY);
+		} else {
+			time_left = wait_event_timeout(ec->wait,
+				    !ec->expect_event,
+				    msecs_to_jiffies(ACPI_EC_DELAY));
+			if (time_left > 0) {
+				ec->expect_event = 0;
 				return 0;
+			}
 		}
-	} else {
-		return 0;
-	}
+		if (acpi_ec_check_status(acpi_ec_read_status(ec), event)) {
+			ec->expect_event = 0;
+			return 0;
+		}
+	} while (--i > 0);
+
+	ec->expect_event = 0;
 
 	return -ETIME;
 }
@@ -251,64 +210,63 @@ #ifdef ACPI_FUTURE_USAGE
  * Note: samsung nv5000 doesn't work with ec burst mode.
  * http://bugzilla.kernel.org/show_bug.cgi?id=4980
  */
-int acpi_ec_enter_burst_mode(union acpi_ec *ec)
+int acpi_ec_enter_burst_mode(struct acpi_ec *ec)
 {
 	u32 tmp = 0;
-	int status = 0;
+	u32 status = 0;
 
 
 	status = acpi_ec_read_status(ec);
 	if (status != -EINVAL && !(status & ACPI_EC_FLAG_BURST)) {
-		status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+		status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
 		if (status)
 			goto end;
-		acpi_hw_low_level_write(8, ACPI_EC_BURST_ENABLE,
-					&ec->common.command_addr);
-		status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
-		acpi_hw_low_level_read(8, &tmp, &ec->common.data_addr);
+		acpi_ec_write_cmd(ec, ACPI_EC_BURST_ENABLE);
+		status = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1);
+		tmp = acpi_ec_read_data(ec);
 		if (tmp != 0x90) {	/* Burst ACK byte */
 			return -EINVAL;
 		}
 	}
 
-	atomic_set(&ec->intr.leaving_burst, 0);
+	atomic_set(&ec->leaving_burst, 0);
 	return 0;
-      end:
-	ACPI_EXCEPTION ((AE_INFO, status, "EC wait, burst mode");
+  end:
+	ACPI_EXCEPTION((AE_INFO, status, "EC wait, burst mode"));
 	return -1;
 }
 
-int acpi_ec_leave_burst_mode(union acpi_ec *ec)
+int acpi_ec_leave_burst_mode(struct acpi_ec *ec)
 {
-	int status = 0;
+	u32 status = 0;
 
 
 	status = acpi_ec_read_status(ec);
 	if (status != -EINVAL && (status & ACPI_EC_FLAG_BURST)){
-		status = acpi_ec_wait(ec, ACPI_EC_FLAG_IBF);
+		status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
 		if(status)
 			goto end;
-		acpi_hw_low_level_write(8, ACPI_EC_BURST_DISABLE, &ec->common.command_addr);
-		acpi_ec_wait(ec, ACPI_EC_FLAG_IBF);
+		acpi_ec_write_cmd(ec, ACPI_EC_BURST_DISABLE);
+		acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
 	}
-	atomic_set(&ec->intr.leaving_burst, 1);
+	atomic_set(&ec->leaving_burst, 1);
 	return 0;
-end:
-	ACPI_EXCEPTION((AE_INFO, status, "EC leave burst mode");
+  end:
+	ACPI_EXCEPTION((AE_INFO, status, "EC leave burst mode"));
 	return -1;
 }
 #endif /* ACPI_FUTURE_USAGE */
 
-static int acpi_ec_transaction(union acpi_ec *ec, u8 command,
+static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
                                const u8 *wdata, unsigned wdata_len,
                                u8 *rdata, unsigned rdata_len)
 {
-	if (acpi_ec_poll_mode)
+	if (acpi_ec_mode == EC_POLL)
 		return acpi_ec_poll_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
 	else
 		return acpi_ec_intr_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
 }
-static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
+static int acpi_ec_read(struct acpi_ec *ec, u8 address, u32 * data)
 {
         int result;
         u8 d;
@@ -316,30 +274,30 @@ static int acpi_ec_read(union acpi_ec *e
         *data = d;
         return result;
 }
-static int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
+static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
 {
         u8 wdata[2] = { address, data };
         return acpi_ec_transaction(ec, ACPI_EC_COMMAND_WRITE, wdata, 2, NULL, 0);
 }
 
-static int acpi_ec_transaction_unlocked(union acpi_ec *ec, u8 command,
-                                             const u8 *wdata, unsigned wdata_len,
-                                             u8 *rdata, unsigned rdata_len)
+static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
+                                        const u8 *wdata, unsigned wdata_len,
+                                        u8 *rdata, unsigned rdata_len)
 {
 	int result;
 
-	acpi_hw_low_level_write(8, command, &ec->common.command_addr);
+	acpi_ec_write_cmd(ec, command);
 
 	for (; wdata_len > 0; wdata_len --) {
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
 		if (result)
 			return result;
 
-		acpi_hw_low_level_write(8, *(wdata++), &ec->common.data_addr);
+		acpi_ec_write_data(ec, *(wdata++));
         }
 
 	if (command == ACPI_EC_COMMAND_WRITE) {
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
 		if (result)
 			return result;
 	}
@@ -347,18 +305,18 @@ static int acpi_ec_transaction_unlocked(
 	for (; rdata_len > 0; rdata_len --) {
 		u32 d;
 
-		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF);
+		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1);
 		if (result)
 			return result;
 
-		acpi_hw_low_level_read(8, &d, &ec->common.data_addr);
+		d = acpi_ec_read_data(ec);
 		*(rdata++) = (u8) d;
 	}
 
 	return 0;
 }
 
-static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,
+static int acpi_ec_poll_transaction(struct acpi_ec *ec, u8 command,
                                     const u8 *wdata, unsigned wdata_len,
                                     u8 *rdata, unsigned rdata_len)
 {
@@ -372,13 +330,13 @@ static int acpi_ec_poll_transaction(unio
         if (rdata)
                 memset(rdata, 0, rdata_len);
 
-	if (ec->common.global_lock) {
+	if (ec->global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status))
 			return -ENODEV;
         }
 
-	if (down_interruptible(&ec->poll.sem)) {
+	if (down_interruptible(&ec->sem)) {
 		result = -ERESTARTSYS;
 		goto end_nosem;
 	}
@@ -386,16 +344,16 @@ static int acpi_ec_poll_transaction(unio
         result = acpi_ec_transaction_unlocked(ec, command,
                                               wdata, wdata_len,
                                               rdata, rdata_len);
-	up(&ec->poll.sem);
+	up(&ec->sem);
 
 end_nosem:
-	if (ec->common.global_lock)
+	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 
 	return result;
 }
 
-static int acpi_ec_intr_transaction(union acpi_ec *ec, u8 command,
+static int acpi_ec_intr_transaction(struct acpi_ec *ec, u8 command,
                                     const u8 *wdata, unsigned wdata_len,
                                     u8 *rdata, unsigned rdata_len)
 {
@@ -408,18 +366,18 @@ static int acpi_ec_intr_transaction(unio
         if (rdata)
                 memset(rdata, 0, rdata_len);
 
-	if (ec->common.global_lock) {
+	if (ec->global_lock) {
 		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
 		if (ACPI_FAILURE(status))
 			return -ENODEV;
 	}
 
 	WARN_ON(in_interrupt());
-	down(&ec->intr.sem);
+	down(&ec->sem);
 
-	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBE);
+	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
 	if (status) {
-		printk(KERN_DEBUG PREFIX "read EC, IB not empty\n");
+		ACPI_EXCEPTION((AE_INFO, status, "read EC, IB not empty"));
 		goto end;
 	}
 
@@ -428,9 +386,9 @@ static int acpi_ec_intr_transaction(unio
                                               rdata, rdata_len);
 
 end:
-	up(&ec->intr.sem);
+	up(&ec->sem);
 
-	if (ec->common.global_lock)
+	if (ec->global_lock)
 		acpi_release_global_lock(glk);
 
 	return status;
@@ -441,7 +399,7 @@ end:
  */
 int ec_read(u8 addr, u8 * val)
 {
-	union acpi_ec *ec;
+	struct acpi_ec *ec;
 	int err;
 	u32 temp_data;
 
@@ -463,7 +421,7 @@ EXPORT_SYMBOL(ec_read);
 
 int ec_write(u8 addr, u8 val)
 {
-	union acpi_ec *ec;
+	struct acpi_ec *ec;
 	int err;
 
 	if (!first_ec)
@@ -482,7 +440,7 @@ extern int ec_transaction(u8 command,
                           const u8 *wdata, unsigned wdata_len,
                           u8 *rdata, unsigned rdata_len)
 {
-	union acpi_ec *ec;
+	struct acpi_ec *ec;
 
 	if (!first_ec)
 		return -ENODEV;
@@ -494,7 +452,7 @@ extern int ec_transaction(u8 command,
 
 EXPORT_SYMBOL(ec_transaction);
 
-static int acpi_ec_query(union acpi_ec *ec, u32 * data) {
+static int acpi_ec_query(struct acpi_ec *ec, u32 * data) {
         int result;
         u8 d;
 
@@ -529,7 +487,7 @@ union acpi_ec_query_data {
 
 static void acpi_ec_gpe_query(void *ec_cxt)
 {
-	if (acpi_ec_poll_mode)
+	if (acpi_ec_mode == EC_POLL)
 		acpi_ec_gpe_poll_query(ec_cxt);
 	else
 		acpi_ec_gpe_intr_query(ec_cxt);
@@ -537,7 +495,7 @@ static void acpi_ec_gpe_query(void *ec_c
 
 static void acpi_ec_gpe_poll_query(void *ec_cxt)
 {
-	union acpi_ec *ec = (union acpi_ec *)ec_cxt;
+	struct acpi_ec *ec = (struct acpi_ec *)ec_cxt;
 	u32 value = 0;
 	static char object_name[5] = { '_', 'Q', '0', '0', '\0' };
 	const char hex[] = { '0', '1', '2', '3', '4', '5', '6', '7',
@@ -548,11 +506,11 @@ static void acpi_ec_gpe_poll_query(void 
 	if (!ec_cxt)
 		goto end;
 
-	if (down_interruptible (&ec->poll.sem)) {
+	if (down_interruptible (&ec->sem)) {
 		return;
 	}
-	acpi_hw_low_level_read(8, &value, &ec->common.command_addr);
-	up(&ec->poll.sem);
+	value = acpi_ec_read_status(ec);
+	up(&ec->sem);
 
 	/* TBD: Implement asynch events!
 	 * NOTE: All we care about are EC-SCI's.  Other EC events are
@@ -571,14 +529,14 @@ static void acpi_ec_gpe_poll_query(void 
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluating %s\n", object_name));
 
-	acpi_evaluate_object(ec->common.handle, object_name, NULL, NULL);
+	acpi_evaluate_object(ec->handle, object_name, NULL, NULL);
 
       end:
-	acpi_enable_gpe(NULL, ec->common.gpe_bit, ACPI_NOT_ISR);
+	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
 }
 static void acpi_ec_gpe_intr_query(void *ec_cxt)
 {
-	union acpi_ec *ec = (union acpi_ec *)ec_cxt;
+	struct acpi_ec *ec = (struct acpi_ec *)ec_cxt;
 	u32 value;
 	int result = -ENODATA;
 	static char object_name[5] = { '_', 'Q', '0', '0', '\0' };
@@ -598,15 +556,14 @@ static void acpi_ec_gpe_intr_query(void 
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluating %s\n", object_name));
 
-	acpi_evaluate_object(ec->common.handle, object_name, NULL, NULL);
+	acpi_evaluate_object(ec->handle, object_name, NULL, NULL);
       end:
-	atomic_dec(&ec->intr.pending_gpe);
 	return;
 }
 
 static u32 acpi_ec_gpe_handler(void *data)
 {
-	if (acpi_ec_poll_mode)
+	if (acpi_ec_mode == EC_POLL)
 		return acpi_ec_gpe_poll_handler(data);
 	else
 		return acpi_ec_gpe_intr_handler(data);
@@ -614,12 +571,12 @@ static u32 acpi_ec_gpe_handler(void *dat
 static u32 acpi_ec_gpe_poll_handler(void *data)
 {
 	acpi_status status = AE_OK;
-	union acpi_ec *ec = (union acpi_ec *)data;
+	struct acpi_ec *ec = (struct acpi_ec *)data;
 
 	if (!ec)
 		return ACPI_INTERRUPT_NOT_HANDLED;
 
-	acpi_disable_gpe(NULL, ec->common.gpe_bit, ACPI_ISR);
+	acpi_disable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
 
 	status = acpi_os_execute(OSL_EC_POLL_HANDLER, acpi_ec_gpe_query, ec);
 
@@ -632,39 +589,38 @@ static u32 acpi_ec_gpe_intr_handler(void
 {
 	acpi_status status = AE_OK;
 	u32 value;
-	union acpi_ec *ec = (union acpi_ec *)data;
+	struct acpi_ec *ec = (struct acpi_ec *)data;
 
 	if (!ec)
 		return ACPI_INTERRUPT_NOT_HANDLED;
 
-	acpi_clear_gpe(NULL, ec->common.gpe_bit, ACPI_ISR);
+	acpi_clear_gpe(NULL, ec->gpe_bit, ACPI_ISR);
 	value = acpi_ec_read_status(ec);
 
-	switch (ec->intr.expect_event) {
-	case ACPI_EC_EVENT_OBF:
+	switch (ec->expect_event) {
+	case ACPI_EC_EVENT_OBF_1:
 		if (!(value & ACPI_EC_FLAG_OBF))
 			break;
-		ec->intr.expect_event = 0;
-		wake_up(&ec->intr.wait);
+		ec->expect_event = 0;
+		wake_up(&ec->wait);
 		break;
-	case ACPI_EC_EVENT_IBE:
+	case ACPI_EC_EVENT_IBF_0:
 		if ((value & ACPI_EC_FLAG_IBF))
 			break;
-		ec->intr.expect_event = 0;
-		wake_up(&ec->intr.wait);
+		ec->expect_event = 0;
+		wake_up(&ec->wait);
 		break;
 	default:
 		break;
 	}
 
 	if (value & ACPI_EC_FLAG_SCI) {
-		atomic_add(1, &ec->intr.pending_gpe);
 		status = acpi_os_execute(OSL_EC_BURST_HANDLER,
 						     acpi_ec_gpe_query, ec);
 		return status == AE_OK ?
 		    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 	}
-	acpi_enable_gpe(NULL, ec->common.gpe_bit, ACPI_ISR);
+	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
 	return status == AE_OK ?
 	    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 }
@@ -695,7 +651,7 @@ acpi_ec_space_handler(u32 function,
 		      void *handler_context, void *region_context)
 {
 	int result = 0;
-	union acpi_ec *ec = NULL;
+	struct acpi_ec *ec = NULL;
 	u64 temp = *value;
 	acpi_integer f_v = 0;
 	int i = 0;
@@ -705,12 +661,10 @@ acpi_ec_space_handler(u32 function,
 		return AE_BAD_PARAMETER;
 
 	if (bit_width != 8 && acpi_strict) {
-		printk(KERN_WARNING PREFIX
-		       "acpi_ec_space_handler: bit_width should be 8\n");
 		return AE_BAD_PARAMETER;
 	}
 
-	ec = (union acpi_ec *)handler_context;
+	ec = (struct acpi_ec *)handler_context;
 
       next_byte:
 	switch (function) {
@@ -767,20 +721,20 @@ static struct proc_dir_entry *acpi_ec_di
 
 static int acpi_ec_read_info(struct seq_file *seq, void *offset)
 {
-	union acpi_ec *ec = (union acpi_ec *)seq->private;
+	struct acpi_ec *ec = (struct acpi_ec *)seq->private;
 
 
 	if (!ec)
 		goto end;
 
 	seq_printf(seq, "gpe bit:                 0x%02x\n",
-		   (u32) ec->common.gpe_bit);
+		   (u32) ec->gpe_bit);
 	seq_printf(seq, "ports:                   0x%02x, 0x%02x\n",
-		   (u32) ec->common.status_addr.address,
-		   (u32) ec->common.data_addr.address);
+		   (u32) ec->status_addr.address,
+		   (u32) ec->data_addr.address);
 	seq_printf(seq, "use global lock:         %s\n",
-		   ec->common.global_lock ? "yes" : "no");
-	acpi_enable_gpe(NULL, ec->common.gpe_bit, ACPI_NOT_ISR);
+		   ec->global_lock ? "yes" : "no");
+	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
 
       end:
 	return 0;
@@ -791,7 +745,7 @@ static int acpi_ec_info_open_fs(struct i
 	return single_open(file, acpi_ec_read_info, PDE(inode)->data);
 }
 
-static const struct file_operations acpi_ec_info_ops = {
+static struct file_operations acpi_ec_info_ops = {
 	.open = acpi_ec_info_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -840,101 +794,35 @@ static int acpi_ec_remove_fs(struct acpi
                                Driver Interface
    -------------------------------------------------------------------------- */
 
-static int acpi_ec_poll_add(struct acpi_device *device)
+static int acpi_ec_add(struct acpi_device *device)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
-	union acpi_ec *ec = NULL;
+	struct acpi_ec *ec = NULL;
 
 
 	if (!device)
 		return -EINVAL;
 
-	ec = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
 	if (!ec)
 		return -ENOMEM;
-	memset(ec, 0, sizeof(union acpi_ec));
-
-	ec->common.handle = device->handle;
-	ec->common.uid = -1;
-	init_MUTEX(&ec->poll.sem);
-	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
-	acpi_driver_data(device) = ec;
-
-	/* Use the global lock for all EC transactions? */
-	acpi_evaluate_integer(ec->common.handle, "_GLK", NULL,
-			      &ec->common.global_lock);
-
-	/* XXX we don't test uids, because on some boxes ecdt uid = 0, see:
-	   http://bugzilla.kernel.org/show_bug.cgi?id=6111 */
-	if (ec_ecdt) {
-		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
-						  ACPI_ADR_SPACE_EC,
-						  &acpi_ec_space_handler);
-
-		acpi_remove_gpe_handler(NULL, ec_ecdt->common.gpe_bit,
-					&acpi_ec_gpe_handler);
-
-		kfree(ec_ecdt);
-	}
-
-	/* Get GPE bit assignment (EC events). */
-	/* TODO: Add support for _GPE returning a package */
-	status =
-	    acpi_evaluate_integer(ec->common.handle, "_GPE", NULL,
-				  &ec->common.gpe_bit);
-	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Obtaining GPE bit"));
-		result = -ENODEV;
-		goto end;
+	memset(ec, 0, sizeof(struct acpi_ec));
+
+	ec->handle = device->handle;
+	ec->uid = -1;
+	init_MUTEX(&ec->sem);
+	if (acpi_ec_mode == EC_INTR) {
+		atomic_set(&ec->leaving_burst, 1);
+		init_waitqueue_head(&ec->wait);
 	}
-
-	result = acpi_ec_add_fs(device);
-	if (result)
-		goto end;
-
-	printk(KERN_INFO PREFIX "%s [%s] (gpe %d) polling mode.\n",
-	       acpi_device_name(device), acpi_device_bid(device),
-	       (u32) ec->common.gpe_bit);
-
-	if (!first_ec)
-		first_ec = device;
-
-      end:
-	if (result)
-		kfree(ec);
-
-	return result;
-}
-static int acpi_ec_intr_add(struct acpi_device *device)
-{
-	int result = 0;
-	acpi_status status = AE_OK;
-	union acpi_ec *ec = NULL;
-
-
-	if (!device)
-		return -EINVAL;
-
-	ec = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
-	if (!ec)
-		return -ENOMEM;
-	memset(ec, 0, sizeof(union acpi_ec));
-
-	ec->common.handle = device->handle;
-	ec->common.uid = -1;
-	atomic_set(&ec->intr.pending_gpe, 0);
-	atomic_set(&ec->intr.leaving_burst, 1);
-	init_MUTEX(&ec->intr.sem);
-	init_waitqueue_head(&ec->intr.wait);
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
 
 	/* Use the global lock for all EC transactions? */
-	acpi_evaluate_integer(ec->common.handle, "_GLK", NULL,
-			      &ec->common.global_lock);
+	acpi_evaluate_integer(ec->handle, "_GLK", NULL,
+			      &ec->global_lock);
 
 	/* XXX we don't test uids, because on some boxes ecdt uid = 0, see:
 	   http://bugzilla.kernel.org/show_bug.cgi?id=6111 */
@@ -943,7 +831,7 @@ static int acpi_ec_intr_add(struct acpi_
 						  ACPI_ADR_SPACE_EC,
 						  &acpi_ec_space_handler);
 
-		acpi_remove_gpe_handler(NULL, ec_ecdt->common.gpe_bit,
+		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe_bit,
 					&acpi_ec_gpe_handler);
 
 		kfree(ec_ecdt);
@@ -952,10 +840,10 @@ static int acpi_ec_intr_add(struct acpi_
 	/* Get GPE bit assignment (EC events). */
 	/* TODO: Add support for _GPE returning a package */
 	status =
-	    acpi_evaluate_integer(ec->common.handle, "_GPE", NULL,
-				  &ec->common.gpe_bit);
+	    acpi_evaluate_integer(ec->handle, "_GPE", NULL,
+				  &ec->gpe_bit);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR PREFIX "Obtaining GPE bit assignment\n");
+		ACPI_EXCEPTION((AE_INFO, status, "Obtaining GPE bit assignment"));
 		result = -ENODEV;
 		goto end;
 	}
@@ -964,14 +852,14 @@ static int acpi_ec_intr_add(struct acpi_
 	if (result)
 		goto end;
 
-	printk(KERN_INFO PREFIX "%s [%s] (gpe %d) interrupt mode.\n",
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "%s [%s] (gpe %d) interrupt mode.",
 	       acpi_device_name(device), acpi_device_bid(device),
-	       (u32) ec->common.gpe_bit);
+	       (u32) ec->gpe_bit));
 
 	if (!first_ec)
 		first_ec = device;
 
-      end:
+  end:
 	if (result)
 		kfree(ec);
 
@@ -980,7 +868,7 @@ static int acpi_ec_intr_add(struct acpi_
 
 static int acpi_ec_remove(struct acpi_device *device, int type)
 {
-	union acpi_ec *ec = NULL;
+	struct acpi_ec *ec = NULL;
 
 
 	if (!device)
@@ -998,7 +886,7 @@ static int acpi_ec_remove(struct acpi_de
 static acpi_status
 acpi_ec_io_ports(struct acpi_resource *resource, void *context)
 {
-	union acpi_ec *ec = (union acpi_ec *)context;
+	struct acpi_ec *ec = (struct acpi_ec *)context;
 	struct acpi_generic_address *addr;
 
 	if (resource->type != ACPI_RESOURCE_TYPE_IO) {
@@ -1010,10 +898,10 @@ acpi_ec_io_ports(struct acpi_resource *r
 	 * the second address region returned is the status/command
 	 * port.
 	 */
-	if (ec->common.data_addr.register_bit_width == 0) {
-		addr = &ec->common.data_addr;
-	} else if (ec->common.command_addr.register_bit_width == 0) {
-		addr = &ec->common.command_addr;
+	if (ec->data_addr.register_bit_width == 0) {
+		addr = &ec->data_addr;
+	} else if (ec->command_addr.register_bit_width == 0) {
+		addr = &ec->command_addr;
 	} else {
 		return AE_CTRL_TERMINATE;
 	}
@@ -1029,7 +917,7 @@ acpi_ec_io_ports(struct acpi_resource *r
 static int acpi_ec_start(struct acpi_device *device)
 {
 	acpi_status status = AE_OK;
-	union acpi_ec *ec = NULL;
+	struct acpi_ec *ec = NULL;
 
 
 	if (!device)
@@ -1043,39 +931,40 @@ static int acpi_ec_start(struct acpi_dev
 	/*
 	 * Get I/O port addresses. Convert to GAS format.
 	 */
-	status = acpi_walk_resources(ec->common.handle, METHOD_NAME__CRS,
+	status = acpi_walk_resources(ec->handle, METHOD_NAME__CRS,
 				     acpi_ec_io_ports, ec);
 	if (ACPI_FAILURE(status)
-	    || ec->common.command_addr.register_bit_width == 0) {
-		printk(KERN_ERR PREFIX "Error getting I/O port addresses\n");
+	    || ec->command_addr.register_bit_width == 0) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Error getting I/O port addresses"));
 		return -ENODEV;
 	}
 
-	ec->common.status_addr = ec->common.command_addr;
+	ec->status_addr = ec->command_addr;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "gpe=0x%02x, ports=0x%2x,0x%2x\n",
-			  (u32) ec->common.gpe_bit,
-			  (u32) ec->common.command_addr.address,
-			  (u32) ec->common.data_addr.address));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "gpe=0x%02x, ports=0x%2x,0x%2x",
+			  (u32) ec->gpe_bit,
+			  (u32) ec->command_addr.address,
+			  (u32) ec->data_addr.address));
 
 	/*
 	 * Install GPE handler
 	 */
-	status = acpi_install_gpe_handler(NULL, ec->common.gpe_bit,
+	status = acpi_install_gpe_handler(NULL, ec->gpe_bit,
 					  ACPI_GPE_EDGE_TRIGGERED,
 					  &acpi_ec_gpe_handler, ec);
 	if (ACPI_FAILURE(status)) {
 		return -ENODEV;
 	}
-	acpi_set_gpe_type(NULL, ec->common.gpe_bit, ACPI_GPE_TYPE_RUNTIME);
-	acpi_enable_gpe(NULL, ec->common.gpe_bit, ACPI_NOT_ISR);
+	acpi_set_gpe_type(NULL, ec->gpe_bit, ACPI_GPE_TYPE_RUNTIME);
+	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
 
-	status = acpi_install_address_space_handler(ec->common.handle,
+	status = acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
 						    &acpi_ec_space_setup, ec);
 	if (ACPI_FAILURE(status)) {
-		acpi_remove_gpe_handler(NULL, ec->common.gpe_bit,
+		acpi_remove_gpe_handler(NULL, ec->gpe_bit,
 					&acpi_ec_gpe_handler);
 		return -ENODEV;
 	}
@@ -1086,7 +975,7 @@ static int acpi_ec_start(struct acpi_dev
 static int acpi_ec_stop(struct acpi_device *device, int type)
 {
 	acpi_status status = AE_OK;
-	union acpi_ec *ec = NULL;
+	struct acpi_ec *ec = NULL;
 
 
 	if (!device)
@@ -1094,14 +983,14 @@ static int acpi_ec_stop(struct acpi_devi
 
 	ec = acpi_driver_data(device);
 
-	status = acpi_remove_address_space_handler(ec->common.handle,
+	status = acpi_remove_address_space_handler(ec->handle,
 						   ACPI_ADR_SPACE_EC,
 						   &acpi_ec_space_handler);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
 	status =
-	    acpi_remove_gpe_handler(NULL, ec->common.gpe_bit,
+	    acpi_remove_gpe_handler(NULL, ec->gpe_bit,
 				    &acpi_ec_gpe_handler);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
@@ -1113,76 +1002,33 @@ static acpi_status __init
 acpi_fake_ecdt_callback(acpi_handle handle,
 			u32 Level, void *context, void **retval)
 {
-
-	if (acpi_ec_poll_mode)
-		return acpi_fake_ecdt_poll_callback(handle,
-						       Level, context, retval);
-	else
-		return acpi_fake_ecdt_intr_callback(handle,
-						     Level, context, retval);
-}
-
-static acpi_status __init
-acpi_fake_ecdt_poll_callback(acpi_handle handle,
-				u32 Level, void *context, void **retval)
-{
-	acpi_status status;
-
-	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
-				     acpi_ec_io_ports, ec_ecdt);
-	if (ACPI_FAILURE(status))
-		return status;
-	ec_ecdt->common.status_addr = ec_ecdt->common.command_addr;
-
-	ec_ecdt->common.uid = -1;
-	acpi_evaluate_integer(handle, "_UID", NULL, &ec_ecdt->common.uid);
-
-	status =
-	    acpi_evaluate_integer(handle, "_GPE", NULL,
-				  &ec_ecdt->common.gpe_bit);
-	if (ACPI_FAILURE(status))
-		return status;
-	init_MUTEX(&ec_ecdt->poll.sem);
-	ec_ecdt->common.global_lock = TRUE;
-	ec_ecdt->common.handle = handle;
-
-	printk(KERN_INFO PREFIX "GPE=0x%02x, ports=0x%2x, 0x%2x\n",
-	       (u32) ec_ecdt->common.gpe_bit,
-	       (u32) ec_ecdt->common.command_addr.address,
-	       (u32) ec_ecdt->common.data_addr.address);
-
-	return AE_CTRL_TERMINATE;
-}
-
-static acpi_status __init
-acpi_fake_ecdt_intr_callback(acpi_handle handle,
-			      u32 Level, void *context, void **retval)
-{
 	acpi_status status;
 
-	init_MUTEX(&ec_ecdt->intr.sem);
-	init_waitqueue_head(&ec_ecdt->intr.wait);
+	init_MUTEX(&ec_ecdt->sem);
+	if (acpi_ec_mode == EC_INTR) {
+		init_waitqueue_head(&ec_ecdt->wait);
+	}
 	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
 				     acpi_ec_io_ports, ec_ecdt);
 	if (ACPI_FAILURE(status))
 		return status;
-	ec_ecdt->common.status_addr = ec_ecdt->common.command_addr;
+	ec_ecdt->status_addr = ec_ecdt->command_addr;
 
-	ec_ecdt->common.uid = -1;
-	acpi_evaluate_integer(handle, "_UID", NULL, &ec_ecdt->common.uid);
+	ec_ecdt->uid = -1;
+	acpi_evaluate_integer(handle, "_UID", NULL, &ec_ecdt->uid);
 
 	status =
 	    acpi_evaluate_integer(handle, "_GPE", NULL,
-				  &ec_ecdt->common.gpe_bit);
+				  &ec_ecdt->gpe_bit);
 	if (ACPI_FAILURE(status))
 		return status;
-	ec_ecdt->common.global_lock = TRUE;
-	ec_ecdt->common.handle = handle;
+	ec_ecdt->global_lock = TRUE;
+	ec_ecdt->handle = handle;
 
-	printk(KERN_INFO PREFIX "GPE=0x%02x, ports=0x%2x, 0x%2x\n",
-	       (u32) ec_ecdt->common.gpe_bit,
-	       (u32) ec_ecdt->common.command_addr.address,
-	       (u32) ec_ecdt->common.data_addr.address);
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "GPE=0x%02x, ports=0x%2x, 0x%2x",
+	       (u32) ec_ecdt->gpe_bit,
+	       (u32) ec_ecdt->command_addr.address,
+	       (u32) ec_ecdt->data_addr.address));
 
 	return AE_CTRL_TERMINATE;
 }
@@ -1202,14 +1048,14 @@ static int __init acpi_ec_fake_ecdt(void
 	acpi_status status;
 	int ret = 0;
 
-	printk(KERN_INFO PREFIX "Try to make an fake ECDT\n");
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Try to make an fake ECDT"));
 
-	ec_ecdt = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec_ecdt = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
 	if (!ec_ecdt) {
 		ret = -ENOMEM;
 		goto error;
 	}
-	memset(ec_ecdt, 0, sizeof(union acpi_ec));
+	memset(ec_ecdt, 0, sizeof(struct acpi_ec));
 
 	status = acpi_get_devices(ACPI_EC_HID,
 				  acpi_fake_ecdt_callback, NULL, NULL);
@@ -1217,24 +1063,16 @@ static int __init acpi_ec_fake_ecdt(void
 		kfree(ec_ecdt);
 		ec_ecdt = NULL;
 		ret = -ENODEV;
+		ACPI_EXCEPTION((AE_INFO, status, "Can't make an fake ECDT"));
 		goto error;
 	}
 	return 0;
-      error:
-	printk(KERN_ERR PREFIX "Can't make an fake ECDT\n");
+  error:
 	return ret;
 }
 
 static int __init acpi_ec_get_real_ecdt(void)
 {
-	if (acpi_ec_poll_mode)
-		return acpi_ec_poll_get_real_ecdt();
-	else
-		return acpi_ec_intr_get_real_ecdt();
-}
-
-static int __init acpi_ec_poll_get_real_ecdt(void)
-{
 	acpi_status status;
 	struct acpi_table_ecdt *ecdt_ptr;
 
@@ -1244,80 +1082,37 @@ static int __init acpi_ec_poll_get_real_
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	printk(KERN_INFO PREFIX "Found ECDT\n");
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found ECDT"));
 
 	/*
 	 * Generate a temporary ec context to use until the namespace is scanned
 	 */
-	ec_ecdt = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
+	ec_ecdt = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
 	if (!ec_ecdt)
 		return -ENOMEM;
-	memset(ec_ecdt, 0, sizeof(union acpi_ec));
-
-	ec_ecdt->common.command_addr = ecdt_ptr->ec_control;
-	ec_ecdt->common.status_addr = ecdt_ptr->ec_control;
-	ec_ecdt->common.data_addr = ecdt_ptr->ec_data;
-	ec_ecdt->common.gpe_bit = ecdt_ptr->gpe_bit;
-	init_MUTEX(&ec_ecdt->poll.sem);
-	/* use the GL just to be safe */
-	ec_ecdt->common.global_lock = TRUE;
-	ec_ecdt->common.uid = ecdt_ptr->uid;
+	memset(ec_ecdt, 0, sizeof(struct acpi_ec));
 
-	status =
-	    acpi_get_handle(NULL, ecdt_ptr->ec_id, &ec_ecdt->common.handle);
-	if (ACPI_FAILURE(status)) {
-		goto error;
+	init_MUTEX(&ec_ecdt->sem);
+	if (acpi_ec_mode == EC_INTR) {
+		init_waitqueue_head(&ec_ecdt->wait);
 	}
-
-	return 0;
-      error:
-	printk(KERN_ERR PREFIX "Could not use ECDT\n");
-	kfree(ec_ecdt);
-	ec_ecdt = NULL;
-
-	return -ENODEV;
-}
-
-static int __init acpi_ec_intr_get_real_ecdt(void)
-{
-	acpi_status status;
-	struct acpi_table_ecdt *ecdt_ptr;
-
-	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING,
-					 (struct acpi_table_header **)
-					 &ecdt_ptr);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	printk(KERN_INFO PREFIX "Found ECDT\n");
-
-	/*
-	 * Generate a temporary ec context to use until the namespace is scanned
-	 */
-	ec_ecdt = kmalloc(sizeof(union acpi_ec), GFP_KERNEL);
-	if (!ec_ecdt)
-		return -ENOMEM;
-	memset(ec_ecdt, 0, sizeof(union acpi_ec));
-
-	init_MUTEX(&ec_ecdt->intr.sem);
-	init_waitqueue_head(&ec_ecdt->intr.wait);
-	ec_ecdt->common.command_addr = ecdt_ptr->ec_control;
-	ec_ecdt->common.status_addr = ecdt_ptr->ec_control;
-	ec_ecdt->common.data_addr = ecdt_ptr->ec_data;
-	ec_ecdt->common.gpe_bit = ecdt_ptr->gpe_bit;
+	ec_ecdt->command_addr = ecdt_ptr->ec_control;
+	ec_ecdt->status_addr = ecdt_ptr->ec_control;
+	ec_ecdt->data_addr = ecdt_ptr->ec_data;
+	ec_ecdt->gpe_bit = ecdt_ptr->gpe_bit;
 	/* use the GL just to be safe */
-	ec_ecdt->common.global_lock = TRUE;
-	ec_ecdt->common.uid = ecdt_ptr->uid;
+	ec_ecdt->global_lock = TRUE;
+	ec_ecdt->uid = ecdt_ptr->uid;
 
 	status =
-	    acpi_get_handle(NULL, ecdt_ptr->ec_id, &ec_ecdt->common.handle);
+	    acpi_get_handle(NULL, ecdt_ptr->ec_id, &ec_ecdt->handle);
 	if (ACPI_FAILURE(status)) {
 		goto error;
 	}
 
 	return 0;
-      error:
-	printk(KERN_ERR PREFIX "Could not use ECDT\n");
+  error:
+	ACPI_EXCEPTION((AE_INFO, status, "Could not use ECDT"));
 	kfree(ec_ecdt);
 	ec_ecdt = NULL;
 
@@ -1342,14 +1137,14 @@ int __init acpi_ec_ecdt_probe(void)
 	/*
 	 * Install GPE handler
 	 */
-	status = acpi_install_gpe_handler(NULL, ec_ecdt->common.gpe_bit,
+	status = acpi_install_gpe_handler(NULL, ec_ecdt->gpe_bit,
 					  ACPI_GPE_EDGE_TRIGGERED,
 					  &acpi_ec_gpe_handler, ec_ecdt);
 	if (ACPI_FAILURE(status)) {
 		goto error;
 	}
-	acpi_set_gpe_type(NULL, ec_ecdt->common.gpe_bit, ACPI_GPE_TYPE_RUNTIME);
-	acpi_enable_gpe(NULL, ec_ecdt->common.gpe_bit, ACPI_NOT_ISR);
+	acpi_set_gpe_type(NULL, ec_ecdt->gpe_bit, ACPI_GPE_TYPE_RUNTIME);
+	acpi_enable_gpe(NULL, ec_ecdt->gpe_bit, ACPI_NOT_ISR);
 
 	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
 						    ACPI_ADR_SPACE_EC,
@@ -1357,7 +1152,7 @@ int __init acpi_ec_ecdt_probe(void)
 						    &acpi_ec_space_setup,
 						    ec_ecdt);
 	if (ACPI_FAILURE(status)) {
-		acpi_remove_gpe_handler(NULL, ec_ecdt->common.gpe_bit,
+		acpi_remove_gpe_handler(NULL, ec_ecdt->gpe_bit,
 					&acpi_ec_gpe_handler);
 		goto error;
 	}
@@ -1365,7 +1160,7 @@ int __init acpi_ec_ecdt_probe(void)
 	return 0;
 
       error:
-	printk(KERN_ERR PREFIX "Could not use ECDT\n");
+	ACPI_EXCEPTION((AE_INFO, status, "Could not use ECDT"));
 	kfree(ec_ecdt);
 	ec_ecdt = NULL;
 
@@ -1424,13 +1219,13 @@ static int __init acpi_ec_set_intr_mode(
 		return 0;
 
 	if (intr) {
-		acpi_ec_poll_mode = EC_INTR;
-		acpi_ec_driver.ops.add = acpi_ec_intr_add;
+		acpi_ec_mode = EC_INTR;
 	} else {
-		acpi_ec_poll_mode = EC_POLL;
-		acpi_ec_driver.ops.add = acpi_ec_poll_add;
+		acpi_ec_mode = EC_POLL;
 	}
-	printk(KERN_INFO PREFIX "EC %s mode.\n", intr ? "interrupt" : "polling");
+	acpi_ec_driver.ops.add = acpi_ec_add;
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "EC %s mode.\n", intr ? "interrupt" : "polling"));
+
 	return 1;
 }
 

--------------000409070501090302090001
Content-Type: text/plain;
 name="ec_x4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ec_x4.patch"

commit 3576cf619b73d850f5b21375609645f221e6270f
Author: Denis M. Sadykov <denis.m.sadykov@intel.com>
Date:   Tue Sep 26 19:50:33 2006 +0400

    ACPI: EC: Unify poll and interrupt mode transaction functions
    
    Signed-off-by: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c816b4e..9c7fce6 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -112,12 +112,6 @@ static struct acpi_ec *ec_ecdt;
 static struct acpi_device *first_ec;
 static int acpi_ec_mode = EC_INTR;
 
-static int acpi_ec_poll_transaction(struct acpi_ec *ec, u8 command,
-                                    const u8 *wdata, unsigned wdata_len,
-                                    u8 *rdata, unsigned rdata_len);
-static int acpi_ec_intr_transaction(struct acpi_ec *ec, u8 command,
-                                    const u8 *wdata, unsigned wdata_len,
-                                    u8 *rdata, unsigned rdata_len);
 static void acpi_ec_gpe_poll_query(void *ec_cxt);
 static void acpi_ec_gpe_intr_query(void *ec_cxt);
 static u32 acpi_ec_gpe_poll_handler(void *data);
@@ -257,32 +251,9 @@ int acpi_ec_leave_burst_mode(struct acpi
 }
 #endif /* ACPI_FUTURE_USAGE */
 
-static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
-                               const u8 *wdata, unsigned wdata_len,
-                               u8 *rdata, unsigned rdata_len)
-{
-	if (acpi_ec_mode == EC_POLL)
-		return acpi_ec_poll_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
-	else
-		return acpi_ec_intr_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
-}
-static int acpi_ec_read(struct acpi_ec *ec, u8 address, u32 * data)
-{
-        int result;
-        u8 d;
-        result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_READ, &address, 1, &d, 1);
-        *data = d;
-        return result;
-}
-static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
-{
-        u8 wdata[2] = { address, data };
-        return acpi_ec_transaction(ec, ACPI_EC_COMMAND_WRITE, wdata, 2, NULL, 0);
-}
-
 static int acpi_ec_transaction_unlocked(struct acpi_ec *ec, u8 command,
-                                        const u8 *wdata, unsigned wdata_len,
-                                        u8 *rdata, unsigned rdata_len)
+					const u8 *wdata, unsigned wdata_len,
+					u8 *rdata, unsigned rdata_len)
 {
 	int result;
 
@@ -292,9 +263,8 @@ static int acpi_ec_transaction_unlocked(
 		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
 		if (result)
 			return result;
-
 		acpi_ec_write_data(ec, *(wdata++));
-        }
+	}
 
 	if (command == ACPI_EC_COMMAND_WRITE) {
 		result = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
@@ -316,46 +286,9 @@ static int acpi_ec_transaction_unlocked(
 	return 0;
 }
 
-static int acpi_ec_poll_transaction(struct acpi_ec *ec, u8 command,
-                                    const u8 *wdata, unsigned wdata_len,
-                                    u8 *rdata, unsigned rdata_len)
-{
-	acpi_status status = AE_OK;
-	int result;
-	u32 glk = 0;
-
-	if (!ec || (wdata_len && !wdata) || (rdata_len && !rdata))
-		return -EINVAL;
-
-        if (rdata)
-                memset(rdata, 0, rdata_len);
-
-	if (ec->global_lock) {
-		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
-        }
-
-	if (down_interruptible(&ec->sem)) {
-		result = -ERESTARTSYS;
-		goto end_nosem;
-	}
-
-        result = acpi_ec_transaction_unlocked(ec, command,
-                                              wdata, wdata_len,
-                                              rdata, rdata_len);
-	up(&ec->sem);
-
-end_nosem:
-	if (ec->global_lock)
-		acpi_release_global_lock(glk);
-
-	return result;
-}
-
-static int acpi_ec_intr_transaction(struct acpi_ec *ec, u8 command,
-                                    const u8 *wdata, unsigned wdata_len,
-                                    u8 *rdata, unsigned rdata_len)
+static int acpi_ec_transaction(struct acpi_ec *ec, u8 command,
+				const u8 *wdata, unsigned wdata_len,
+				u8 *rdata, unsigned rdata_len)
 {
 	int status;
 	u32 glk;
@@ -371,13 +304,11 @@ static int acpi_ec_intr_transaction(stru
 		if (ACPI_FAILURE(status))
 			return -ENODEV;
 	}
-
-	WARN_ON(in_interrupt());
 	down(&ec->sem);
 
 	status = acpi_ec_wait(ec, ACPI_EC_EVENT_IBF_0);
 	if (status) {
-		ACPI_EXCEPTION((AE_INFO, status, "read EC, IB not empty"));
+		printk(KERN_DEBUG PREFIX "read EC, IB not empty\n");
 		goto end;
 	}
 
@@ -394,6 +325,23 @@ end:
 	return status;
 }
 
+static int acpi_ec_read(struct acpi_ec *ec, u8 address, u32 * data)
+{
+	int result;
+	u8 d;
+
+	result = acpi_ec_transaction(ec, ACPI_EC_COMMAND_READ,
+				     &address, 1, &d, 1);
+	*data = d;
+	return result;
+}
+static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
+{
+        u8 wdata[2] = { address, data };
+        return acpi_ec_transaction(ec, ACPI_EC_COMMAND_WRITE,
+				   wdata, 2, NULL, 0);
+}
+
 /*
  * Externally callable EC access functions. For now, assume 1 EC only
  */
@@ -447,13 +395,13 @@ extern int ec_transaction(u8 command,
 
 	ec = acpi_driver_data(first_ec);
 
-	return acpi_ec_transaction(ec, command, wdata, wdata_len, rdata, rdata_len);
+	return acpi_ec_transaction(ec, command, wdata,
+				   wdata_len, rdata, rdata_len);
 }
 
-EXPORT_SYMBOL(ec_transaction);
-
-static int acpi_ec_query(struct acpi_ec *ec, u32 * data) {
-        int result;
+static int acpi_ec_query(struct acpi_ec *ec, u32 * data)
+{
+	int result;
         u8 d;
 
         if (!ec || !data)

--------------000409070501090302090001
Content-Type: text/plain;
 name="ec_x5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ec_x5.patch"

commit 8e0341ba791cc72c643340b0d8119141ae5a80c5
Author: Denis M. Sadykov <denis.m.sadykov@intel.com>
Date:   Tue Sep 26 19:50:33 2006 +0400

    ACPI: EC: Unify poll and interrupt gpe handlers
    
    Signed-off-by: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9c7fce6..0f232e7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -112,11 +112,6 @@ static struct acpi_ec *ec_ecdt;
 static struct acpi_device *first_ec;
 static int acpi_ec_mode = EC_INTR;
 
-static void acpi_ec_gpe_poll_query(void *ec_cxt);
-static void acpi_ec_gpe_intr_query(void *ec_cxt);
-static u32 acpi_ec_gpe_poll_handler(void *data);
-static u32 acpi_ec_gpe_intr_handler(void *data);
-
 /* --------------------------------------------------------------------------
                              Transaction Management
    -------------------------------------------------------------------------- */
@@ -428,21 +423,13 @@ static int acpi_ec_query(struct acpi_ec 
                                 Event Management
    -------------------------------------------------------------------------- */
 
-union acpi_ec_query_data {
+struct acpi_ec_query_data {
 	acpi_handle handle;
 	u8 data;
 };
 
 static void acpi_ec_gpe_query(void *ec_cxt)
 {
-	if (acpi_ec_mode == EC_POLL)
-		acpi_ec_gpe_poll_query(ec_cxt);
-	else
-		acpi_ec_gpe_intr_query(ec_cxt);
-}
-
-static void acpi_ec_gpe_poll_query(void *ec_cxt)
-{
 	struct acpi_ec *ec = (struct acpi_ec *)ec_cxt;
 	u32 value = 0;
 	static char object_name[5] = { '_', 'Q', '0', '0', '\0' };
@@ -454,18 +441,8 @@ static void acpi_ec_gpe_poll_query(void 
 	if (!ec_cxt)
 		goto end;
 
-	if (down_interruptible (&ec->sem)) {
-		return;
-	}
 	value = acpi_ec_read_status(ec);
-	up(&ec->sem);
 
-	/* TBD: Implement asynch events!
-	 * NOTE: All we care about are EC-SCI's.  Other EC events are
-	 * handled via polling (yuck!).  This is because some systems
-	 * treat EC-SCIs as level (versus EDGE!) triggered, preventing
-	 *  a purely interrupt-driven approach (grumble, grumble).
-	 */
 	if (!(value & ACPI_EC_FLAG_SCI))
 		goto end;
 
@@ -475,96 +452,36 @@ static void acpi_ec_gpe_poll_query(void 
 	object_name[2] = hex[((value >> 4) & 0x0F)];
 	object_name[3] = hex[(value & 0x0F)];
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluating %s\n", object_name));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluating %s", object_name));
 
 	acpi_evaluate_object(ec->handle, object_name, NULL, NULL);
 
       end:
 	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
 }
-static void acpi_ec_gpe_intr_query(void *ec_cxt)
-{
-	struct acpi_ec *ec = (struct acpi_ec *)ec_cxt;
-	u32 value;
-	int result = -ENODATA;
-	static char object_name[5] = { '_', 'Q', '0', '0', '\0' };
-	const char hex[] = { '0', '1', '2', '3', '4', '5', '6', '7',
-		'8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
-	};
-
-
-	if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_SCI)
-		result = acpi_ec_query(ec, &value);
-
-	if (result)
-		goto end;
-
-	object_name[2] = hex[((value >> 4) & 0x0F)];
-	object_name[3] = hex[(value & 0x0F)];
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluating %s\n", object_name));
-
-	acpi_evaluate_object(ec->handle, object_name, NULL, NULL);
-      end:
-	return;
-}
 
 static u32 acpi_ec_gpe_handler(void *data)
 {
-	if (acpi_ec_mode == EC_POLL)
-		return acpi_ec_gpe_poll_handler(data);
-	else
-		return acpi_ec_gpe_intr_handler(data);
-}
-static u32 acpi_ec_gpe_poll_handler(void *data)
-{
-	acpi_status status = AE_OK;
-	struct acpi_ec *ec = (struct acpi_ec *)data;
-
-	if (!ec)
-		return ACPI_INTERRUPT_NOT_HANDLED;
-
-	acpi_disable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
-
-	status = acpi_os_execute(OSL_EC_POLL_HANDLER, acpi_ec_gpe_query, ec);
-
-	if (status == AE_OK)
-		return ACPI_INTERRUPT_HANDLED;
-	else
-		return ACPI_INTERRUPT_NOT_HANDLED;
-}
-static u32 acpi_ec_gpe_intr_handler(void *data)
-{
 	acpi_status status = AE_OK;
 	u32 value;
+	u8 exec_mode;
 	struct acpi_ec *ec = (struct acpi_ec *)data;
 
-	if (!ec)
-		return ACPI_INTERRUPT_NOT_HANDLED;
-
 	acpi_clear_gpe(NULL, ec->gpe_bit, ACPI_ISR);
 	value = acpi_ec_read_status(ec);
 
-	switch (ec->expect_event) {
-	case ACPI_EC_EVENT_OBF_1:
-		if (!(value & ACPI_EC_FLAG_OBF))
-			break;
-		ec->expect_event = 0;
-		wake_up(&ec->wait);
-		break;
-	case ACPI_EC_EVENT_IBF_0:
-		if ((value & ACPI_EC_FLAG_IBF))
-			break;
-		ec->expect_event = 0;
-		wake_up(&ec->wait);
-		break;
-	default:
-		break;
+	if (acpi_ec_mode == EC_INTR) {
+		if (acpi_ec_check_status(value, ec->expect_event)) {
+			ec->expect_event = 0;
+			wake_up(&ec->wait);
+		}
+		exec_mode = OSL_EC_BURST_HANDLER;
+	} else {
+		exec_mode = OSL_EC_POLL_HANDLER;
 	}
 
 	if (value & ACPI_EC_FLAG_SCI) {
-		status = acpi_os_execute(OSL_EC_BURST_HANDLER,
-						     acpi_ec_gpe_query, ec);
+		status = acpi_os_execute(exec_mode, acpi_ec_gpe_query, ec);
 		return status == AE_OK ?
 		    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 	}

--------------000409070501090302090001
Content-Type: text/plain;
 name="ec_x6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ec_x6.patch"

commit 6ffb221a82de962f31034b45d945e203a0f0500f
Author: Denis M. Sadykov <denis.m.sadykov@intel.com>
Date:   Tue Sep 26 19:50:33 2006 +0400

    ACPI: EC: Simplify acpi_hw_low_level*() with inb()/outb().
    
    Simplify acpi_hw_low_level_xxx() functions to inb() and outb().
    
    Signed-off-by: Alexey Y. Starikovskiy <alexey.y.starikovskiy@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 0f232e7..ae05e8c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -72,7 +72,7 @@ #define ACPI_EC_UDELAY_COUNT   1000	/* W
 
 enum {
 	EC_INTR = 1,	/* Output buffer full */
-	EC_POLL,		/* Input buffer empty */
+	EC_POLL,	/* Input buffer empty */
 };
 
 static int acpi_ec_remove(struct acpi_device *device, int type);
@@ -91,22 +91,20 @@ static struct acpi_driver acpi_ec_driver
 		.stop = acpi_ec_stop,
 		},
 };
+
+/* If we find an EC via the ECDT, we need to keep a ptr to its context */
 struct acpi_ec {
 	acpi_handle handle;
 	unsigned long uid;
 	unsigned long gpe_bit;
-	struct acpi_generic_address status_addr;
-	struct acpi_generic_address command_addr;
-	struct acpi_generic_address data_addr;
+	unsigned long command_addr;
+	unsigned long data_addr;
 	unsigned long global_lock;
 	struct semaphore sem;
 	unsigned int expect_event;
 	atomic_t leaving_burst;	/* 0 : No, 1 : Yes, 2: abort */
 	wait_queue_head_t wait;
-};
-
-/* If we find an EC via the ECDT, we need to keep a ptr to its context */
-static struct acpi_ec *ec_ecdt;
+} *ec_ecdt;
 
 /* External interfaces use first EC only, so remember */
 static struct acpi_device *first_ec;
@@ -116,34 +114,28 @@ static int acpi_ec_mode = EC_INTR;
                              Transaction Management
    -------------------------------------------------------------------------- */
 
-static u32 acpi_ec_read_status(struct acpi_ec *ec)
+static inline u8 acpi_ec_read_status(struct acpi_ec *ec)
 {
-	u32 status = 0;
-
-	acpi_hw_low_level_read(8, &status, &ec->status_addr);
-	return status;
+	return inb(ec->command_addr);
 }
 
-static u32 acpi_ec_read_data(struct acpi_ec *ec)
+static inline u8 acpi_ec_read_data(struct acpi_ec *ec)
 {
-	u32 data = 0;
-
-	acpi_hw_low_level_read(8, &data, &ec->data_addr);
-	return data;
+	return inb(ec->data_addr);
 }
 
-static void acpi_ec_write_cmd(struct acpi_ec *ec, u32 command)
+static inline void acpi_ec_write_cmd(struct acpi_ec *ec, u8 command)
 {
-	acpi_hw_low_level_write(8, command, &ec->command_addr);
+	outb(command, ec->command_addr);
 }
 
-static void acpi_ec_write_data(struct acpi_ec *ec, u32 data)
+static inline void acpi_ec_write_data(struct acpi_ec *ec, u8 data)
 {
-	acpi_hw_low_level_write(8, data, &ec->data_addr);
+	outb(data, ec->data_addr);
 }
 
-static int acpi_ec_check_status(u32 status, u8 event) {
-
+static int acpi_ec_check_status(u8 status, u8 event)
+{
 	switch (event) {
 	case ACPI_EC_EVENT_OBF_1:
 		if (status & ACPI_EC_FLAG_OBF)
@@ -201,8 +193,8 @@ #ifdef ACPI_FUTURE_USAGE
  */
 int acpi_ec_enter_burst_mode(struct acpi_ec *ec)
 {
-	u32 tmp = 0;
-	u32 status = 0;
+	u8 tmp = 0;
+	u8 status = 0;
 
 
 	status = acpi_ec_read_status(ec);
@@ -227,7 +219,7 @@ int acpi_ec_enter_burst_mode(struct acpi
 
 int acpi_ec_leave_burst_mode(struct acpi_ec *ec)
 {
-	u32 status = 0;
+	u8 status = 0;
 
 
 	status = acpi_ec_read_status(ec);
@@ -268,14 +260,11 @@ static int acpi_ec_transaction_unlocked(
 	}
 
 	for (; rdata_len > 0; rdata_len --) {
-		u32 d;
-
 		result = acpi_ec_wait(ec, ACPI_EC_EVENT_OBF_1);
 		if (result)
 			return result;
 
-		d = acpi_ec_read_data(ec);
-		*(rdata++) = (u8) d;
+		*(rdata++) = acpi_ec_read_data(ec);
 	}
 
 	return 0;
@@ -320,7 +309,7 @@ end:
 	return status;
 }
 
-static int acpi_ec_read(struct acpi_ec *ec, u8 address, u32 * data)
+static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 *data)
 {
 	int result;
 	u8 d;
@@ -330,6 +319,7 @@ static int acpi_ec_read(struct acpi_ec *
 	*data = d;
 	return result;
 }
+
 static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
 {
         u8 wdata[2] = { address, data };
@@ -340,11 +330,11 @@ static int acpi_ec_write(struct acpi_ec 
 /*
  * Externally callable EC access functions. For now, assume 1 EC only
  */
-int ec_read(u8 addr, u8 * val)
+int ec_read(u8 addr, u8 *val)
 {
 	struct acpi_ec *ec;
 	int err;
-	u32 temp_data;
+	u8 temp_data;
 
 	if (!first_ec)
 		return -ENODEV;
@@ -394,7 +384,7 @@ extern int ec_transaction(u8 command,
 				   wdata_len, rdata, rdata_len);
 }
 
-static int acpi_ec_query(struct acpi_ec *ec, u32 * data)
+static int acpi_ec_query(struct acpi_ec *ec, u8 *data)
 {
 	int result;
         u8 d;
@@ -431,14 +421,10 @@ struct acpi_ec_query_data {
 static void acpi_ec_gpe_query(void *ec_cxt)
 {
 	struct acpi_ec *ec = (struct acpi_ec *)ec_cxt;
-	u32 value = 0;
-	static char object_name[5] = { '_', 'Q', '0', '0', '\0' };
-	const char hex[] = { '0', '1', '2', '3', '4', '5', '6', '7',
-		'8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
-	};
-
+	u8 value = 0;
+	static char object_name[8];
 
-	if (!ec_cxt)
+	if (!ec)
 		goto end;
 
 	value = acpi_ec_read_status(ec);
@@ -449,8 +435,7 @@ static void acpi_ec_gpe_query(void *ec_c
 	if (acpi_ec_query(ec, &value))
 		goto end;
 
-	object_name[2] = hex[((value >> 4) & 0x0F)];
-	object_name[3] = hex[(value & 0x0F)];
+	snprintf(object_name, 8, "_Q%2.2X", value);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Evaluating %s", object_name));
 
@@ -463,8 +448,7 @@ static void acpi_ec_gpe_query(void *ec_c
 static u32 acpi_ec_gpe_handler(void *data)
 {
 	acpi_status status = AE_OK;
-	u32 value;
-	u8 exec_mode;
+	u8 value;
 	struct acpi_ec *ec = (struct acpi_ec *)data;
 
 	acpi_clear_gpe(NULL, ec->gpe_bit, ACPI_ISR);
@@ -475,13 +459,10 @@ static u32 acpi_ec_gpe_handler(void *dat
 			ec->expect_event = 0;
 			wake_up(&ec->wait);
 		}
-		exec_mode = OSL_EC_BURST_HANDLER;
-	} else {
-		exec_mode = OSL_EC_POLL_HANDLER;
 	}
 
 	if (value & ACPI_EC_FLAG_SCI) {
-		status = acpi_os_execute(exec_mode, acpi_ec_gpe_query, ec);
+		status = acpi_os_execute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
 		return status == AE_OK ?
 		    ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
 	}
@@ -535,7 +516,7 @@ acpi_ec_space_handler(u32 function,
 	switch (function) {
 	case ACPI_READ:
 		temp = 0;
-		result = acpi_ec_read(ec, (u8) address, (u32 *) & temp);
+		result = acpi_ec_read(ec, (u8) address, (u8 *) &temp);
 		break;
 	case ACPI_WRITE:
 		result = acpi_ec_write(ec, (u8) address, (u8) temp);
@@ -595,8 +576,8 @@ static int acpi_ec_read_info(struct seq_
 	seq_printf(seq, "gpe bit:                 0x%02x\n",
 		   (u32) ec->gpe_bit);
 	seq_printf(seq, "ports:                   0x%02x, 0x%02x\n",
-		   (u32) ec->status_addr.address,
-		   (u32) ec->data_addr.address);
+		   (u32) ec->command_addr,
+		   (u32) ec->data_addr);
 	seq_printf(seq, "use global lock:         %s\n",
 		   ec->global_lock ? "yes" : "no");
 	acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_NOT_ISR);
@@ -752,7 +733,6 @@ static acpi_status
 acpi_ec_io_ports(struct acpi_resource *resource, void *context)
 {
 	struct acpi_ec *ec = (struct acpi_ec *)context;
-	struct acpi_generic_address *addr;
 
 	if (resource->type != ACPI_RESOURCE_TYPE_IO) {
 		return AE_OK;
@@ -763,19 +743,14 @@ acpi_ec_io_ports(struct acpi_resource *r
 	 * the second address region returned is the status/command
 	 * port.
 	 */
-	if (ec->data_addr.register_bit_width == 0) {
-		addr = &ec->data_addr;
-	} else if (ec->command_addr.register_bit_width == 0) {
-		addr = &ec->command_addr;
+	if (ec->data_addr == 0) {
+		ec->data_addr = resource->data.io.minimum;
+	} else if (ec->command_addr == 0) {
+		ec->command_addr = resource->data.io.minimum;
 	} else {
 		return AE_CTRL_TERMINATE;
 	}
 
-	addr->address_space_id = ACPI_ADR_SPACE_SYSTEM_IO;
-	addr->register_bit_width = 8;
-	addr->register_bit_offset = 0;
-	addr->address = resource->data.io.minimum;
-
 	return AE_OK;
 }
 
@@ -798,19 +773,14 @@ static int acpi_ec_start(struct acpi_dev
 	 */
 	status = acpi_walk_resources(ec->handle, METHOD_NAME__CRS,
 				     acpi_ec_io_ports, ec);
-	if (ACPI_FAILURE(status)
-	    || ec->command_addr.register_bit_width == 0) {
+	if (ACPI_FAILURE(status) || ec->command_addr == 0) {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"Error getting I/O port addresses"));
 		return -ENODEV;
 	}
 
-	ec->status_addr = ec->command_addr;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "gpe=0x%02x, ports=0x%2x,0x%2x",
-			  (u32) ec->gpe_bit,
-			  (u32) ec->command_addr.address,
-			  (u32) ec->data_addr.address));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "gpe=0x%02lx, ports=0x%2lx,0x%2lx",
+			  ec->gpe_bit, ec->command_addr, ec->data_addr));
 
 	/*
 	 * Install GPE handler
@@ -877,7 +847,6 @@ acpi_fake_ecdt_callback(acpi_handle hand
 				     acpi_ec_io_ports, ec_ecdt);
 	if (ACPI_FAILURE(status))
 		return status;
-	ec_ecdt->status_addr = ec_ecdt->command_addr;
 
 	ec_ecdt->uid = -1;
 	acpi_evaluate_integer(handle, "_UID", NULL, &ec_ecdt->uid);
@@ -890,10 +859,8 @@ acpi_fake_ecdt_callback(acpi_handle hand
 	ec_ecdt->global_lock = TRUE;
 	ec_ecdt->handle = handle;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "GPE=0x%02x, ports=0x%2x, 0x%2x",
-	       (u32) ec_ecdt->gpe_bit,
-	       (u32) ec_ecdt->command_addr.address,
-	       (u32) ec_ecdt->data_addr.address));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "GPE=0x%02lx, ports=0x%2lx, 0x%2lx",
+	       ec_ecdt->gpe_bit, ec_ecdt->command_addr, ec_ecdt->data_addr));
 
 	return AE_CTRL_TERMINATE;
 }
@@ -961,9 +928,8 @@ static int __init acpi_ec_get_real_ecdt(
 	if (acpi_ec_mode == EC_INTR) {
 		init_waitqueue_head(&ec_ecdt->wait);
 	}
-	ec_ecdt->command_addr = ecdt_ptr->ec_control;
-	ec_ecdt->status_addr = ecdt_ptr->ec_control;
-	ec_ecdt->data_addr = ecdt_ptr->ec_data;
+	ec_ecdt->command_addr = ecdt_ptr->ec_control.address;
+	ec_ecdt->data_addr = ecdt_ptr->ec_data.address;
 	ec_ecdt->gpe_bit = ecdt_ptr->gpe_bit;
 	/* use the GL just to be safe */
 	ec_ecdt->global_lock = TRUE;

--------------000409070501090302090001--
