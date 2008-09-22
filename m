From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Mon, 22 Sep 2008 14:44:29 +0100
Message-ID: <48D7A13D.7060909@tuffmail.co.uk>
References: <48D695B3.5000303@tuffmail.co.uk> <48D69DC9.5060100@suse.de> <48D760A2.3030007@tuffmail.co.uk> <48D77B3C.8070103@tuffmail.co.uk> <48D7833A.9030207@suse.de> <48D78658.2090209@gmail.com> <48D78FF1.9060502@tuffmail.co.uk> <48D79120.2050309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:41197 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbYIVNoi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2008 09:44:38 -0400
Received: by ti-out-0910.google.com with SMTP id b6so755857tic.23
        for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2008 06:44:36 -0700 (PDT)
In-Reply-To: <48D79120.2050309@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux acpi <linux-acpi@vger.kernel.org>

Alexey Starikovskiy wrote:
> Alan Jenkins wrote:
>> Alexey Starikovskiy wrote:
>>  
>>> Hi Alan,
>>>
>>> Here are the patches. First is updated version of patch you've tried,
>>> second is
>>> even more aggressive disabling of GPEs (applies on top).
>>>
>>> Please check them.
>>>
>>>     
>> I tested them together and they worked, yay!
>>
>> That doesn't say anything about the second patch.  My EC didn't generate
>> enough spurious interrupts to trigger the STORM code.
>>
>> Would you welcome some nitpicks on the first patch at this time?  I
>> didn't see errors but I have some code-style queries.
>>   
> Sure. Will be glad.

My main query was about acpi_ec::t being a pointer.  I thought that
meant there would be lots of kmalloc / kfrees.  But I see now it is
allocated on-stack, i.e. it points to a local variable.  Never mind.  It
is a bit clever though.  I thought the original version was clearer -
where acpi_ec::t wasn't a pointer. 

The other niggle was the spinlock.  It would be nice to indicate by
comment the resources it protects (acpi_ec::t and irq_count).

Actually, if we're being clever, why not move irq_count into
transaction_data?  After all, it's only used within the transaction.  It
fits with both the lifecycle and the locking.

Regards
Alan
