From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Battery 'present rate' display weirdness
Date: Sat, 28 Jul 2007 12:50:03 +0400
Message-ID: <46AB033B.80608@gmail.com>
References: <7e0bae390707270823v3e80b72cmc0f4c665c3ce907f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:29576 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733AbXG1IuI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jul 2007 04:50:08 -0400
Received: by ug-out-1314.google.com with SMTP id j3so811570ugf
        for <linux-acpi@vger.kernel.org>; Sat, 28 Jul 2007 01:50:07 -0700 (PDT)
In-Reply-To: <7e0bae390707270823v3e80b72cmc0f4c665c3ce907f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andika Triwidada <andika@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hello Andika,

Acer was long user of smart battery system (SBS), which allows for 
negative values of the current (it is signed 16 bit value in SBS).
If your Acer exports battery directly with SBS, there is a bug in drivers/acpi/sbs.c
If it exports battery with ACPI control methods (CM), then there is a need of 
workaround in drivers/acpi/battery.c (CM uses 64 bit value to store current, 
so this is not a matter of getting absolute value of it).  

Could you please open bug against ACPI/Battery and attach acpidump output
to it?

Thanks,
Alex. 

Andika Triwidada wrote:
> My Acer Aspire 5580 shows normal info on discharging
> 
> andika@hokage:~$ cat /proc/acpi/battery/*/*
> alarm:                   unsupported
> present:                 yes
> design capacity:         4000 mAh
> last full capacity:      4131 mAh
> battery technology:      rechargeable
> design voltage:          11100 mV
> design capacity warning: 300 mAh
> design capacity low:     165 mAh
> capacity granularity 1:  32 mAh
> capacity granularity 2:  32 mAh
> model number:            PRESPAL
> serial number:           217
> battery type:            LION
> OEM info:                PANASONIC
> present:                 yes
> capacity state:          ok
> charging state:          discharging
> present rate:            2437 mA
> remaining capacity:      448 mAh
> present voltage:         10336 mV
> 
> But abnormal (?) one when charging:
> 
> andika@hokage:~$ cat /proc/acpi/battery/*/*
> alarm:                   unsupported
> present:                 yes
> design capacity:         4000 mAh
> last full capacity:      4131 mAh
> battery technology:      rechargeable
> design voltage:          11100 mV
> design capacity warning: 300 mAh
> design capacity low:     165 mAh
> capacity granularity 1:  32 mAh
> capacity granularity 2:  32 mAh
> model number:            PRESPAL
> serial number:           217
> battery type:            LION
> OEM info:                PANASONIC
> present:                 yes
> capacity state:          ok
> charging state:          charging
> present rate:            63418 mA
>                          ^^^^^^^^
> remaining capacity:      256 mAh
> present voltage:         10640 mV
> 
> Does it need to be handled differently in battery.c or up to any
> userspace tools to check 'charging state' and calculate proper (65535
> - x) 'present rate'?
> 
> This is on kernel 2.6.22
> 
> TIA.
> 
> --
> andika
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

