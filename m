From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.23-rc6: S4 and S5 no longer listed as supported on Toshiba
 Satellite A40
Date: Thu, 20 Sep 2007 22:33:49 +0400
Message-ID: <46F2BD0D.2010206@gmail.com>
References: <200709192014.08443.elendil@planet.nl> <46F2A0E9.9000603@gmail.com> <46F2AE16.9080803@gmail.com> <200709202017.50934.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:23021 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbXITSd6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Sep 2007 14:33:58 -0400
Received: by ug-out-1314.google.com with SMTP id z38so430252ugc
        for <linux-acpi@vger.kernel.org>; Thu, 20 Sep 2007 11:33:57 -0700 (PDT)
In-Reply-To: <200709202017.50934.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Maciek Rutecki <maciej.rutecki@gmail.com>

Frans Pop wrote:
> On Thursday 20 September 2007, you wrote:
>> Please try this patch.
> 
> Works. All states are now listed again.
> I've not tested suspend to disk, but suspend to ram and power off work fine.
> 
>> +printk(KERN_INFO PREFIX "(supports");
>>  #ifdef CONFIG_SUSPEND
>> -       printk(KERN_INFO PREFIX "(supports");
>>         for (i = ACPI_STATE_S0; i < ACPI_STATE_S4; i++) {
> 
> Isn't there a risk now that we now end up printing
>    ACPI: (supports)
> if CONFIG_SUSPEND is not enabled and >S4 is not supported?
> 
> Or, more probably, it would print
>    ACPI: (supports S5)
Don't know what does it mean to support S0 exactly... :)
> as it is unlikely that "off" is not supported :-)
> 
> Maybe S0 should be taken outside the #ifdef and the loop as that state is 
> also basically always there?
Don't think it is worth the trouble. We already have this loop almost completely unrolled,
let's not make it complete mess...

Regards,
Alex.
> 
> Thanks,
> FJP
> 

