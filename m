From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [patch 1/5] ACPI: Atlas ACPI driver
Date: Fri, 7 Jul 2006 11:46:27 -0400
Message-ID: <756b48450607070846v597bb552tea5437a7fd5122c8@mail.gmail.com>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1120705@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:12772 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932104AbWGGPq2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jul 2006 11:46:28 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3137268ugf
        for <linux-acpi@vger.kernel.org>; Fri, 07 Jul 2006 08:46:27 -0700 (PDT)
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD1120705@pdsmsx411.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, dtor_core@ameritech.net, "Brown, Len" <len.brown@intel.com>

On 7/7/06, Yu, Luming <luming.yu@intel.com> wrote:
> +       if (function == ACPI_WRITE) {
> +               status = acpi_bus_generate_event(dev, 0x80, address);
> +               atlas_input_report((u8) address);
> +       } else {
>
> Please don't use two mechanism to report one event.
>
> For other part of code, I ACK.

Hi Luming,

Thanks for the feedback. Actually, Len had asked the same question on
this list to which I replied:

---
The event is reported to ACPI because there are legacy apps that read
/proc/acpi/event for this ASIM event. Newer apps can use the F1...
events that they can get via evdev. btw, if CONFIG_INPUT is disabled,
atlas_input_report gets dummied out and it's reported only to ACPI.
---

So to rephrase, I didn't want to break compatibility with preexisting
apps and also so that there is an event generated in the case where
CONFIG_INPUT is not used.

I guess it looks like the consensus is that acpi_bus_generate_event
must go, so I'll remove it and do some other cleanup as well and post
that.

Thanks,
jaya
