From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] PCI/ACPI: move _OSC code to pci_root.c
Date: Wed, 04 Feb 2009 15:20:49 +0900
Message-ID: <498933C1.40301@jp.fujitsu.com>
References: <4987DCAC.3010009@jp.fujitsu.com> <1233703252.14203.161.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1233703252.14203.161.camel@localhost>
Sender: linux-pci-owner@vger.kernel.org
To: Andrew Patterson <andrew.patterson@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-acpi@vger.kernel.org

Hi,

Thank you for comments.

Andrew Patterson wrote:
> On Tue, 2009-02-03 at 14:57 +0900, Kenji Kaneshige wrote:
(snip.)
>> +		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
>> +			if (capbuf[OSC_QUERY_TYPE] & OSC_QUERY_ENABLE)
>> +				goto out_success;
>> +			printk(KERN_DEBUG "_OSC FW not grant req. control\n");
> 
> Can this be worded better? Perhaps "Firmware would not grant requested
> _OSC control"? I know this is not your code, but maybe we can fix this
> now.
> 

Ok, I'll fix it.

>> +
>> +/**
>> + * pci_osc_control_set - commit requested control to Firmware
> 
> Should this function be renamed to acpi_pci_osc_control_set?
> 

I didn't do it because pci_osc_control_set() is exported
(EXPORT_SYMBOL(pci_osc_control_set)). And for the same reason,
I didn't move _OSC related code from include/linux/pci-acpi.h
to include/linux/acpi.h (or somewhere).
But I guess there is no user outside kernel source. So I will
rename the function as you pointed out.

>> +	if ((root->osc_control_qry & control_req) != control_req) {
>> +		printk(KERN
> 
>> _DEBUG "_OSC FW not grant req. control\n");
> 
> See above.
> 

I'll fix it.

Thanks,
Kenji Kaneshige
