From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/3] Add a generic API for _OSC
Date: Wed, 28 Oct 2009 12:02:18 +0900
Message-ID: <4AE7B43A.50204@jp.fujitsu.com>
References: <20091027063637.GA22237@sli10-desk.sh.intel.com> <200910270907.19103.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34848 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465AbZJ1DCg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2009 23:02:36 -0400
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id n9S32bR8027443
	for <linux-acpi@vger.kernel.org> (envelope-from kaneshige.kenji@jp.fujitsu.com);
	Wed, 28 Oct 2009 12:02:37 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 3EF0045DE4F
	for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2009 12:02:37 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 176D045DE52
	for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2009 12:02:37 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id F40F9E1800C
	for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2009 12:02:36 +0900 (JST)
Received: from m108.s.css.fujitsu.com (m108.s.css.fujitsu.com [10.249.87.108])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id B0AC4E1800B
	for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2009 12:02:36 +0900 (JST)
In-Reply-To: <200910270907.19103.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

Bjorn Helgaas wrote:
> On Tuesday 27 October 2009 12:36:37 am Shaohua Li wrote:
>> Add an API to execute _OSC. A lot of devices can have this method, so add a
>> generic API.
> 
>> +	out_obj = context->ret.pointer;
>> +	if (out_obj->type != ACPI_TYPE_BUFFER) {
>> +		printk(KERN_DEBUG "_OSC evaluation returned wrong type\n");
>> +		status = AE_TYPE;
>> +		goto out_kfree;
>> +	}
>> +	/* Need to ignore the bit0 in result code */
>> +	errors = *((u32 *)out_obj->buffer.pointer) & ~(1 << 0);
>> +	if (errors) {
>> +		if (errors & OSC_REQUEST_ERROR)
>> +			printk(KERN_DEBUG "_OSC request failed\n");
>> +		if (errors & OSC_INVALID_UUID_ERROR)
>> +			printk(KERN_DEBUG "_OSC invalid UUID\n");
>> +		if (errors & OSC_INVALID_REVISION_ERROR)
>> +			printk(KERN_DEBUG "_OSC invalid revision\n");
>> +		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
>> +			if (((u32 *)context->cap.pointer)[OSC_QUERY_TYPE]
>> +			    & OSC_QUERY_ENABLE)
>> +				goto out_success;
>> +			printk(KERN_DEBUG
>> +			       "Firmware did not grant requested _OSC control\n");
> 
> On all these printks, it would be very useful to have some indication
> of what the OS requested and which specific _OSC method we executed,
> e.g., an ACPI device name or a namespace path.
> 

I think the following printk is confusing and should be removed.

>> +			printk(KERN_DEBUG
>> +			       "Firmware did not grant requested _OSC control\n");

People might think something wrong is happening on OS or firmware.
Actually I had been asked about this message several times.

Thanks,
Kenji Kaneshige

