From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [patch] pci-acpi: handle multiple _OSC
Date: Mon, 12 May 2008 22:55:45 +0900
Message-ID: <48284C61.4040604@jp.fujitsu.com>
References: <1210238510.23649.2.camel@sli10-desk.sh.intel.com>	 <1210297604.8716.5.camel@sli10-desk.sh.intel.com>	 <482400B3.4020808@jp.fujitsu.com>	 <200805091040.37139.jbarnes@virtuousgeek.org> <1210560490.2172.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:35872 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbYELN5e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 May 2008 09:57:34 -0400
In-Reply-To: <1210560490.2172.2.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Shaohua Li wrote:
> On Fri, 2008-05-09 at 10:40 -0700, Jesse Barnes wrote:
>> On Friday, May 09, 2008 12:43 am Kenji Kaneshige wrote:
>>> -static u32 ctrlset_buf[3] = {0, 0, 0};
>>> -static u32 global_ctrlsets = 0;
>>> +#define MAX_ACPI_OSC 30 /* Should be enough */
>>> +static struct acpi_osc_data {
>>> +	acpi_handle handle;
>>> +	u32 ctrlset_buf[3];
>>> +	u32 global_ctrlsets;
>>> +} acpi_osc_data_array[MAX_ACPI_OSC];
>> Could this just be a linked list of OSC objects instead?
> fixed. patch is against Kenji's ?"PCI ACPI: fix uninitialized variable
> in __pci_osc_support_set" patch.
> 

I found a problem.

> @@ -201,19 +232,25 @@ acpi_status pci_osc_control_set(acpi_han
>  {
>  	acpi_status	status;
>  	u32		ctrlset;
> +	struct acpi_osc_data *osc_data = acpi_get_osc_data(handle);
> +
> +	if (!osc_data) {
> +		printk(KERN_ERR "acpi osc data array is full\n");
> +		return AE_ERROR;
> +	}

The pci_osc_control_set() function can be called for the ACPI object
that doesn't have _OSC method. In this case, acpi_get_osc_data() would
allocate a useless memory region. To avoid this, we need to check the
existence of _OSC before calling acpi_get_osc_data(). Here is a patch
to fix this problem. It is against your patch.

---
 drivers/pci/pci-acpi.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux-2.6.26-rc2/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.26-rc2.orig/drivers/pci/pci-acpi.c
+++ linux-2.6.26-rc2/drivers/pci/pci-acpi.c
@@ -232,8 +232,14 @@ acpi_status pci_osc_control_set(acpi_han
 {
 	acpi_status	status;
 	u32		ctrlset;
-	struct acpi_osc_data *osc_data = acpi_get_osc_data(handle);
+	acpi_handle tmp;
+	struct acpi_osc_data *osc_data;
+
+	status = acpi_get_handle(handle, "_OSC", &tmp);
+	if (ACPI_FAILURE(status))
+		return status;
 
+	osc_data = acpi_get_osc_data(handle);
 	if (!osc_data) {
 		printk(KERN_ERR "acpi osc data array is full\n");
 		return AE_ERROR;

