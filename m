From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/2] PCI/ACPI: move _OSC code to pci_root.c
Date: Fri, 06 Feb 2009 13:30:05 +0900
Message-ID: <498BBCCD.7050809__21471.248046919$1233894706$gmane$org@jp.fujitsu.com>
References: <498AF51F.7070200@jp.fujitsu.com> <498AF557.4040601@jp.fujitsu.com> <20090205154936.GC24033@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55007 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbZBFEaL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Feb 2009 23:30:11 -0500
In-Reply-To: <20090205154936.GC24033@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>linu

Alex Chiang wrote:
> Hi Kenji-san,
> 
> Sorry, I didn't read your patch in detail last time, and only saw
> the one wording change that Andrew suggested.
> 
> Reading through now, I have a few more suggestions.
>

Thank you for suggestions.

>> +	status = acpi_evaluate_object(handle, "_OSC", &input, &output);
>> +	if (ACPI_FAILURE(status))
>> +		return status;
>> +
>> +	if (!output.length)
>> +		return AE_NULL_OBJECT;
>> +
>> +	out_obj = output.pointer;
>> +	if (out_obj->type != ACPI_TYPE_BUFFER) {
>> +		printk(KERN_DEBUG "Evaluate _OSC returns wrong type\n");
> 
> "_OSC evaluation returned wrong type\n"
> 

I'll fix it. But this debug message would be removed if we use
acpi_evaluate_object_typed() instead of acpi_evaluate_object() as
Robert suggested.

>> +	if (errors) {
>> +		if (errors & OSC_REQUEST_ERROR)
>> +			printk(KERN_DEBUG "_OSC request fails\n");
> 
> "_OSC request failed\n"
> 

I'll fix it.

>> +		if (errors & OSC_INVALID_UUID_ERROR)
>> +			printk(KERN_DEBUG "_OSC invalid UUID\n");
>> +		if (errors & OSC_INVALID_REVISION_ERROR)
>> +			printk(KERN_DEBUG "_OSC invalid revision\n");
>> +		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
>> +			if (capbuf[OSC_QUERY_TYPE] & OSC_QUERY_ENABLE)
>> +				goto out_success;
>> +			printk(KERN_DEBUG"Firmware did not grant requested "
>> +			       "_OSC control\n");
> 
> I prefer to see this message on one line (and break the 80 column
> rule) to make grepping easier. But this is a judgement call, and
> I'll let you decide.
> 

Ok, I think one line is better. So I'll bread the 80 column rule:)

Thanks,
Kenji Kaneshige

