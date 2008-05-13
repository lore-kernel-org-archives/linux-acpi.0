From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [patch] pci-acpi: handle multiple _OSC
Date: Tue, 13 May 2008 16:48:50 +0900
Message-ID: <482947E2.5070101@jp.fujitsu.com>
References: <1210238510.23649.2.camel@sli10-desk.sh.intel.com> <1210560490.2172.2.camel@sli10-desk.sh.intel.com> <48284C61.4040604@jp.fujitsu.com> <200805120907.35106.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:37943 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703AbYEMHuG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 May 2008 03:50:06 -0400
In-Reply-To: <200805120907.35106.jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Jesse Barnes wrote:
> On Monday, May 12, 2008 6:55 am Kenji Kaneshige wrote:
>> Shaohua Li wrote:
>>> On Fri, 2008-05-09 at 10:40 -0700, Jesse Barnes wrote:
>>>> On Friday, May 09, 2008 12:43 am Kenji Kaneshige wrote:
>>>>> -static u32 ctrlset_buf[3] = {0, 0, 0};
>>>>> -static u32 global_ctrlsets = 0;
>>>>> +#define MAX_ACPI_OSC 30 /* Should be enough */
>>>>> +static struct acpi_osc_data {
>>>>> +	acpi_handle handle;
>>>>> +	u32 ctrlset_buf[3];
>>>>> +	u32 global_ctrlsets;
>>>>> +} acpi_osc_data_array[MAX_ACPI_OSC];
>>>> Could this just be a linked list of OSC objects instead?
>>> fixed. patch is against Kenji's ?"PCI ACPI: fix uninitialized variable
>>> in __pci_osc_support_set" patch.
>> I found a problem.
>>
>>> @@ -201,19 +232,25 @@ acpi_status pci_osc_control_set(acpi_han
>>>  {
>>>  	acpi_status	status;
>>>  	u32		ctrlset;
>>> +	struct acpi_osc_data *osc_data = acpi_get_osc_data(handle);
>>> +
>>> +	if (!osc_data) {
>>> +		printk(KERN_ERR "acpi osc data array is full\n");
>>> +		return AE_ERROR;
>>> +	}
>> The pci_osc_control_set() function can be called for the ACPI object
>> that doesn't have _OSC method. In this case, acpi_get_osc_data() would
>> allocate a useless memory region. To avoid this, we need to check the
>> existence of _OSC before calling acpi_get_osc_data(). Here is a patch
>> to fix this problem. It is against your patch.
>>
>> ---
>>  drivers/pci/pci-acpi.c |    8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Thanks Shaohua & Kenji, I applied both fixes to the 'for-linus' tree.  Please 
> test it out soon, I'd like to send Linus a pull request shortly.
> 

I noticed the similar fix is also needed for acpi_query_osc().

Thanks,
Kenji Kaneshige


The acpi_query_osc() function can be called for the ACPI object that
doesn't have _OSC method. In this case, acpi_get_osc_data() would
allocate a useless memory region. To avoid this, we need to check the
existence of _OSC before calling acpi_get_osc_data().

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pci-acpi.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6.26-rc2/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.26-rc2.orig/drivers/pci/pci-acpi.c
+++ linux-2.6.26-rc2/drivers/pci/pci-acpi.c
@@ -60,9 +60,15 @@ acpi_query_osc (
 	union acpi_object 	*out_obj;
 	u32			osc_dw0;
 	acpi_status *ret_status = (acpi_status *)retval;
-	struct acpi_osc_data *osc_data = acpi_get_osc_data(handle);
+	struct acpi_osc_data *osc_data;
 	u32 flags = (unsigned long)context, temp;
+	acpi_handle tmp;
 
+	status = acpi_get_handle(handle, "_OSC", &tmp);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	osc_data = acpi_get_osc_data(handle);
 	if (!osc_data) {
 		printk(KERN_ERR "acpi osc data array is full\n");
 		return AE_ERROR;


