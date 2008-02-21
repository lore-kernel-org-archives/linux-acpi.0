From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: Machine shutdown after resume from S3
Date: Thu, 21 Feb 2008 21:43:30 +0300
Message-ID: <20080221184326.0386A3271D@smtp02.mtu.ru>
References: <200802201837.22443.herton@mandriva.com.br> <20080221174643.32B0A3608D@smtp02.mtu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp02.mtu.ru ([62.5.255.49]:49257 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbYBUSnh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Feb 2008 13:43:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>, linux-acpi@vger.kernel.org

Andrey Borzenkov wrote:

> Herton Ronaldo Krzesinski wrote:
> 
>> I have here an Intel Classmate hardware sample, and I have a weird
>> problem with suspend to ram, 

wait a bit; suspend to RAM is S1 not S3. The mentined patch explicitly
checks for S3 state and prevents power button event from reaching user
space; but you are resuming from *S1*.

Looks like this requires some sort of quirks to recognize this specific
platform and apply the same workaround to S1.

>> the machine does a power off when resuming. 
>> 
> 
> Do you have acpid running? You may also be interested in this:
> http://qa.mandriva.com/show_bug.cgi?id=18998
> http://qa.mandriva.com/show_bug.cgi?id=23296
> http://article.gmane.org/gmane.linux.acpi.devel/17581/match=sup
> 
> 
>> I isolated the problem to the button acpi module, without loading it (or
>> just removing it before doing a s2ram) I don't get the problem. In the
>> specific machine I have here I can only resume it pressing the power
>> button, so I think this is related.
>> 
> 
> IIRC the issue was that button press that triggered resume was reported to
> user space. This apparently was fixed in the quoted patch; but may be this
> specific model goes via different code path?
> 
>> I started looking into the kernel code and did some tests. The first
>> thing I tried just as a test was to disable the code in
>> acpi_button_notify function. As expected it stopped to send the power
>> button key events to /proc/acpi/event, but I still got the same s2ram
>> issues. But if I disable acpi_install_fixed_event_handler calls in
>> acpi_button_install_notify_handlers the power off issue in s2ram was
>> gone, of course also with power button not notifying anything anymore :),
>> but this was just a test.
>> 
>> After this tests then I went further to try to track down the problem and
>> I saw acpi_ev_fixed_event_dispatch, that is the function that will call
>> acpi_button_notify_fixed. First thing I noted: the comment about
>> acpi_ev_fixed_event_dispatch says it will return INTERRUPT_HANDLED or
>> INTERRUPT_NOT_HANDLED, but acpi_button_notify_fixed return AE_OK, is this
>> right (comment is outdated) or am I missing something? Anyway I changed
>> AE_OK to ACPI_INTERRUPT_HANDLED but this didn't change nothing. In the
>> end I stopped there, doesn't seem to be anything wrong with the code at
>> all, I also took a look at acpi_ev_fixed_event_detect and other code
>> related to the table of fixed events (acpi_gbl_fixed_event_handlers), but
>> didn't got more clues. Could be this a bios issue, or there is some hints
>> to what I can try to look and prove that it's bios or code related?
>> 
>> PS.: with netconsole I don't get any message before power off after
>> resume, I tried it to get more hints.
>> 
>> --
>> []'s
>> Herton
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


