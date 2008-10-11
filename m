From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: acpi-test tree on eeepc: EC error message on second resume
Date: Sat, 11 Oct 2008 23:31:06 +0400
Message-ID: <48F0FEFA.7050308@gmail.com>
References: <48F0DB0C.7060201@tuffmail.co.uk> <48F0ED3A.9010001@tuffmail.co.uk> <48F0F2C6.6030000@suse.de> <200810112130.57757.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:46236 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbYJKTbI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 15:31:08 -0400
Received: by ug-out-1314.google.com with SMTP id k3so195700ugf.37
        for <linux-acpi@vger.kernel.org>; Sat, 11 Oct 2008 12:31:05 -0700 (PDT)
In-Reply-To: <200810112130.57757.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Rafael J. Wysocki wrote:
> On Saturday, 11 of October 2008, Alexey Starikovskiy wrote:
>   
>> Alan Jenkins wrote:
>>     
>>> I think I found the problem.  The "input buffer empty" wait depends on
>>> "interrupt mode" to work properly, and we don't immediately enable the
>>> interrupt on resume.  The wait should have a polling fallback anyway, to
>>> be consistent with the other transaction waits.
>>>
>>> Alan
>>>       
>> Yep, I think something like attached patch may help:
>>     
>
> [Can you please append patches instead of or apart from attaching them?
> That would make it easier to comment them.]
>
>   
Ok.
> if (!wait_event_timeout(ec->wait, ec_check_ibf0(ec),
> -                               msecs_to_jiffies(ACPI_EC_DELAY))) {
> +                               msecs_to_jiffies(ACPI_EC_DELAY)) &&
> +           !ec_check_ibf0(ec)) {
>
> Shouldn't this go under the spinlock?  Surely it can race with the GPE handler.
>
>   
No, we discussed this before -- we are outside of the transaction, thus 
no GPE
activity could interfere with ec_check_ibf0.

Regards,
Alex.
