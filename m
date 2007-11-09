From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: GPE handling
Date: Fri, 09 Nov 2007 12:45:10 +0300
Message-ID: <47342C26.2040505@gmail.com>
References: <FC1D1B23302A22499C60C967336B2AE001FF2CA9@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:31276 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbXKIJpQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Nov 2007 04:45:16 -0500
Received: by ug-out-1314.google.com with SMTP id z38so500604ugc
        for <linux-acpi@vger.kernel.org>; Fri, 09 Nov 2007 01:45:14 -0800 (PST)
In-Reply-To: <FC1D1B23302A22499C60C967336B2AE001FF2CA9@pdsmsx411.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Shaohua,
There is cond_resched() before the exit from deferred execution routine,
specifically to let notify thread a chance to execute.
Thus by the time deferred execution is exited, notify should be already 
done,
and we could safely enable _Lxx again.
Do you think it is not sufficient?

Regards,
Alex.

Li, Shaohua wrote:
> Bob & Ming,
> I'm working on adding wakeup GPE support at system runtime, this
> capability can help us
> Identify which device invokes a wakeup event at runtime, this is
> required for runtime device
> Power management.
>
> Below is the ASL code. For example, _L0c, USB3 will send a wakeup GPE
> and invoke
> a notify. In the notify handler, OS will clear USB3's PCI PME status to
> avoid wakeup
> event flood. But in current code, acpi_ev_asynch_execute_gpe_method will
> start an asynchronous
> execution of notify and return soon. Just before the return,
> acpi_ev_asynch_execute_gpe_method
> will reenable GPE 0C. That means GPE is enabled before OS execute
> notification handler and USB3's
> PCI PME status is cleared, and cause GPE flood. Ideally, I think we
> should delay GPE enable
> of _L0c till notification handler is finished or simply the method _L0c
> is really finished.
> What do you think?
>
> Thanks,
> Shaohua
>
>
>         Method (_L0C, 0, NotSerialized)
>         {
>             Notify (\_SB.PCI0.USB3, 0x02)
>         }
>
>         Method (_L0D, 0, NotSerialized)
>         {
>             Notify (\_SB.PCI0.USB7, 0x02)
>         }
>
>         Method (_L0E, 0, NotSerialized)
>         {
>             Notify (\_SB.PCI0.USB4, 0x02)
>         }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   

