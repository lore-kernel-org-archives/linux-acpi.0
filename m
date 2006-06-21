From: keith mannthey <kmannth@us.ibm.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/1] for acpi_memhotplug.c
Date: Tue, 20 Jun 2006 19:10:40 -0700
Message-ID: <1150855840.5873.57.camel@keithlap>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	 <437F1766.8090705@jp.fujitsu.com>  <1150853300.5873.49.camel@keithlap>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-RHVoqaTvGQxKQUEedaCH"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:8641 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932458AbWFUCKn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 22:10:43 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5L2AgGD028351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Tue, 20 Jun 2006 22:10:42 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5L2AKON257664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 20 Jun 2006 20:10:20 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5L2AfDG013429
	for <linux-acpi@vger.kernel.org>; Tue, 20 Jun 2006 20:10:42 -0600
In-Reply-To: <1150853300.5873.49.camel@keithlap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava--redhat <prarit@redhat.com>, konrad <darnok@us.ibm.com>, external hotplug mem list <lhms-devel@lists.sourceforge.net>


--=-RHVoqaTvGQxKQUEedaCH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-06-20 at 18:28 -0700, keith mannthey wrote:
> Hello again,
>   I am still without a working acpi memory driver for my hardware (with
> extra patches).  I posted patches a long while ago but have been off
> doing other things for a while.  
>   
> 1. The current driver is unable to created the mem_device from the hot-
> add event and the hot-add fails with out adding any memory to the
> system. I have address_resources attached to the acpi handle but in
> acpi_memory_get_device calling the path of 
> 
> acpi_bus_get_device
> acpi_get_parent
> acpi_bus_get_device /*for parent*/
> acpi_bus_add /*to created the memory device */
> 
> just doesn't create the memory_device and I don't know why.  Perhaps
> something about the event is off but I have had a fair amount of
> communication with the bios writers about this issue and everything
> looks ok to us.  The odd things is acpi_bus_add doesn't complain it
> happily returns success but no memory_device was attached to the
> device. 
> 
>   If you know how to debug this event better please advise. 
> 
>   If I look at the resources associated with the handle there is
> appropriate data to do the hot-add event (memory range data). I simply
> insert a function that creates the memory device directly from the
> handle and it's data(See attached patch) and the event carries on as
> expected.  
> 
> The patch applies and work just fine against 2.6.17 and it doesn't break
> the current call implementation.  
> 
> Any ideas?
> 
> Signed-off-by:  Keith Mannthey <kmannth@us.ibm.com>

Sorry for the repost to some I had the old acpi list on the cc.

--=-RHVoqaTvGQxKQUEedaCH
Content-Disposition: attachment; filename=acpi_mem_fixv3.patch
Content-Type: text/x-patch; name=acpi_mem_fixv3.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.15-rc1-orig/drivers/acpi/acpi_memhotplug.c	2005-11-14 10:56:13.000000000 -0800
+++ linux-2.6.15-rc1/drivers/acpi/acpi_memhotplug.c	2005-11-16 20:06:47.000000000 -0800
@@ -110,6 +110,32 @@
 	return_VALUE(0);
 }
 
+static int 
+acpi_memory_get_current_resource(acpi_handle handle, struct acpi_memory_device **return_device) {
+	
+	int result;
+	struct acpi_memory_device *mem_device;
+
+	ACPI_FUNCTION_TRACE("acpi_memory_get_current_resource");
+	
+	mem_device = kmalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
+	if (!mem_device)
+		return_VALUE(-ENOMEM);
+	memset(mem_device,0, sizeof(struct acpi_memory_device));
+
+	mem_device->handle = handle;
+	result = acpi_memory_get_device_resources(mem_device);
+	if (result) {
+		kfree(mem_device);
+		return_VALUE(result);
+	}
+	mem_device->state = MEMORY_POWER_ON_STATE;
+	*return_device = mem_device;
+	
+	return_VALUE(result);
+}
+
+
 static int
 acpi_memory_get_device(acpi_handle handle,
 		       struct acpi_memory_device **mem_device)
@@ -118,6 +144,7 @@
 	acpi_handle phandle;
 	struct acpi_device *device = NULL;
 	struct acpi_device *pdevice = NULL;
+	int result;
 
 	ACPI_FUNCTION_TRACE("acpi_memory_get_device");
 
@@ -147,14 +174,17 @@
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error in acpi_bus_add\n"));
 		return_VALUE(-EINVAL);
 	}
-
       end:
 	*mem_device = acpi_driver_data(device);
+
 	if (!(*mem_device)) {
-		printk(KERN_ERR "\n driver data not found");
-		return_VALUE(-ENODEV);
+		/* Try and get the memory_device from the current handle */
+		result = acpi_memory_get_current_resource(handle,mem_device);
+		if (result) {
+			printk(KERN_ERR "\nThere is no data for this memory device\n");
+			return_VALUE(-EINVAL);
+		}
 	}
-
 	return_VALUE(0);
 }
 

--=-RHVoqaTvGQxKQUEedaCH
Content-Disposition: attachment; filename=SSDT.dsl.gz
Content-Type: application/x-gzip; name=SSDT.dsl.gz
Content-Transfer-Encoding: base64

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


--=-RHVoqaTvGQxKQUEedaCH--

