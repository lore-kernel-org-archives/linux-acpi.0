From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Mon, 22 Sep 2008 16:35:44 +0400
Message-ID: <48D79120.2050309@gmail.com>
References: <48D695B3.5000303@tuffmail.co.uk> <48D69DC9.5060100@suse.de> <48D760A2.3030007@tuffmail.co.uk> <48D77B3C.8070103@tuffmail.co.uk> <48D7833A.9030207@suse.de> <48D78658.2090209@gmail.com> <48D78FF1.9060502@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:37149 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbYIVMfx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Sep 2008 08:35:53 -0400
Received: by ey-out-2122.google.com with SMTP id 6so406837eyi.37
        for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2008 05:35:47 -0700 (PDT)
In-Reply-To: <48D78FF1.9060502@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux acpi <linux-acpi@vger.kernel.org>

Alan Jenkins wrote:
> Alexey Starikovskiy wrote:
>   
>> Hi Alan,
>>
>> Here are the patches. First is updated version of patch you've tried,
>> second is
>> even more aggressive disabling of GPEs (applies on top).
>>
>> Please check them.
>>
>>     
> I tested them together and they worked, yay!
>
> That doesn't say anything about the second patch.  My EC didn't generate
> enough spurious interrupts to trigger the STORM code.
>
> Would you welcome some nitpicks on the first patch at this time?  I
> didn't see errors but I have some code-style queries.
>   
Sure. Will be glad.

> Thanks
> Alan
>   

