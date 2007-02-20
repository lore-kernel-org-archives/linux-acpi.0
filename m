From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: ec locking issue
Date: Wed, 21 Feb 2007 01:07:25 +0300
Message-ID: <45DB711D.6090303@linux.intel.com>
References: <20070215192616.GA31595@isilmar.linta.de> <45D4BF92.5050401@linux.intel.com> <200702161254.55430.lenb@kernel.org> <20070219134431.GG9283@isilmar.linta.de> <20070219214502.GA19762@isilmar.linta.de> <45DB3CE4.8090001@linux.intel.com> <20070220195901.GA21920@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060303010207080202040901"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:10630 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030490AbXBTWHb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Feb 2007 17:07:31 -0500
In-Reply-To: <20070220195901.GA21920@isilmar.linta.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060303010207080202040901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dominik Brodowski wrote:
> Hi,
>
> On Tue, Feb 20, 2007 at 09:24:36PM +0300, Alexey Starikovskiy wrote:
>   
>>> On Mon, Feb 19, 2007 at 08:44:31AM -0500, Dominik Brodowski wrote:
>>>  
>>>       
>>>> On Fri, Feb 16, 2007 at 12:54:55PM -0500, Len Brown wrote:
>>>>    
>>>>         
>>>>>>> acpi_ec_transaction
>>>>>>> acpi_ec_read
>>>>>>> acpi_ec_space_handler
>>>>>>> acpi_ev_address_space_dispatch
>>>>>>> acpi_ex_access_region
>>>>>>> acpi_ex_field_datum_
>>>>>>> acpi_ex_extract_from_field
>>>>>>> ...
>>>>>>> acpi_ex_ns_evaluate
>>>>>>> acpi_ev_execute_reg_method
>>>>>>> acpi_ev_reg_run
>>>>>>> acpi_ns_walk_namespace
>>>>>>> acpi_ev_execute_reg_methods
>>>>>>> acpi_install_address_space_handler
>>>>>>> acpi_ec_start
>>>>>>> acpi_start_single_object
>>>>>>> acpi_device_probe
>>>>>>> really_probe
>>>>>>> ...
>>>>>>> bus_add_driver
>>>>>>> ...
>>>>>>> acpi_ec_init
>>>>>>>          
>>>>>>>               
>>>>> Alexey,
>>>>> Thanks for the fix -- it is applied.
>>>>>
>>>>> Dominik,
>>>>> Did this fix help, or is the problem elsehwere?
>>>>>      
>>>>>           
>>>> Unfortunately, this doesn't solve the issue for me -- now I get a panic 
>>>> with
>>>> EIP at __list_add+0x2d/0x60, with the call trace being
>>>>
>>>> 	...
>>>> 	die
>>>> 	do_page_fault
>>>> 	error_code
>>>> 	__mutex_lock_slowpath
>>>> 	mutex_lock
>>>> 	acpi_ec_transaction
>>>>
>>>> and then the same as above... Will try it out with lockdep disabled.
>>>>    
>>>>         
>>> No, doesn't seem to be lockdep-related; same issue continues. "acpi=off"
>>> fixes the issue, though, of course...
>>>
>>> Thanks,
>>> 	Dominik
>>>  
>>>       
>> Dominik,
>> Could you send your acpidump and full dmesg please?
>>     
>
> http://userweb.kernel.org/~brodo/acpidump.binary
> http://userweb.kernel.org/~brodo/acpidump.txt
> http://userweb.kernel.org/~brodo/acpi-dmsg.txt
>
> Hope this helps,
> 	Dominik
>   
Thanks.
I start to think, that ec is either not fully initialized or freed by 
the time acpi_ec_start is called... Please try if the following patch 
changes something.

Alex.

--------------060303010207080202040901
Content-Type: text/x-patch;
 name="1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1.diff"

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 16c4ede..b0161fa 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -92,13 +92,13 @@ static struct acpi_driver acpi_ec_driver
 
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
 static struct acpi_ec {
+	struct mutex lock;
 	acpi_handle handle;
 	unsigned long uid;
 	unsigned long gpe;
 	unsigned long command_addr;
 	unsigned long data_addr;
 	unsigned long global_lock;
-	struct mutex lock;
 	atomic_t query_pending;
 	wait_queue_head_t wait;
 } *ec_ecdt;
@@ -618,14 +618,12 @@ static int acpi_ec_add(struct acpi_devic
 
 	ec->handle = device->handle;
 	ec->uid = -1;
-	mutex_init(&ec->lock);
 	atomic_set(&ec->query_pending, 0);
 	if (acpi_ec_mode == EC_INTR) {
 		init_waitqueue_head(&ec->wait);
 	}
 	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
-	acpi_driver_data(device) = ec;
 
 	/* Use the global lock for all EC transactions? */
 	acpi_evaluate_integer(ec->handle, "_GLK", NULL, &ec->global_lock);
@@ -661,6 +659,9 @@ static int acpi_ec_add(struct acpi_devic
 			  acpi_device_name(device), acpi_device_bid(device),
 			  (u32) ec->gpe));
 
+	mutex_init(&ec->lock);
+	acpi_driver_data(device) = ec;
+
 	if (!first_ec)
 		first_ec = device;
 

--------------060303010207080202040901--
