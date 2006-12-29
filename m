From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: Help with ACPI events
Date: Fri, 29 Dec 2006 13:46:12 +0300
Message-ID: <4594F1F4.9080102@linux.intel.com>
References: <45947B98.5050309@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:13683 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751347AbWL2KqP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Dec 2006 05:46:15 -0500
In-Reply-To: <45947B98.5050309@lwfinger.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-acpi@vger.kernel.org

Next, you should look into your DSDT and find what exactly _Q10 does (it 
might set/reset some variable with descriptive name). Then, in your code 
you can read the state of this variable with 
acpi_evaluate_integer/acpi_evaluate_object. Please look at drivers in 
drivers/acpi for examples.

Regards,
    Alex.
Larry Finger wrote:
> I'm writing for some help with ACPI events, which may be getting in the way of the setting of LEDs
> for the bcm43xx module. I have an HP notebook with a "Broadcom Corporation Dell Wireless 1390 WLAN
> Mini-PCI Card". This machine has a wireless on/off switch on the front. By experimenting while using
> 2.6.9.1, I found the necessary code needed to toggle the LED associated with the switch. The same
> code does not work with 2.6.20-rc2 and the LED is always off. The state of the switch is correctly
> read out by my code, but no deal with changing the LED state.
>
> The reason I'm writing you is that whenever the switch is changed on 2.6.20, a "ACPI: EC: evaluating
> _Q10" message is logged just before my code detects the switch change. I looked at the acpi driver a
> little, but quickly got lost.
>
> Is there a change in the acpi subsystem in 2.6.20 that might be interfering? Where should I look next?
>
> Thanks,
>
> Larry
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
