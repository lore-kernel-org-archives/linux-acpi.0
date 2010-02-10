From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: hp-wmi and hp dv9000
Date: Wed, 10 Feb 2010 12:33:08 +0000
Message-ID: <4B72A784.2020004@tuffmail.co.uk>
References: <87wrylwizo.wl%peterc@chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:41642 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572Ab0BJMdR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2010 07:33:17 -0500
Received: by ewy28 with SMTP id 28so5004963ewy.28
        for <linux-acpi@vger.kernel.org>; Wed, 10 Feb 2010 04:33:15 -0800 (PST)
In-Reply-To: <87wrylwizo.wl%peterc@chubb.wattle.id.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Chubb <peter.chubb@nicta.com.au>
Cc: Matthew Garrett <mjg@redhat.com>, linux acpi <linux-acpi@vger.kernel.org>

Peter Chubb wrote:
> Hi Alan.
> 	I noticed you were last working on hp-wmi.  I'm finding that
> if I load hp-wmi then the wireless network does not work --- dmesg
> output always says `iwlagn 0000:02:00: Radio disabled by HW RF Kill switch' 
> regardless of the position of the switch.
>
>
> This machine has no bluetooth, just the IWL-AGN mini-pci card.
> I've been testing with versions from 2.6.32 to 2.6.33-rc7, none work
> with hp-wmi loaded.
>
> I'm happy to provide traces, logs, etc., if that'll help --- just ask
> for what you want.
>   

Thanks Peter.  I do have some worries about my patch that went into 
2.6.33-rc1.  What I can't see how this happens on 2.6.32, unless your 
laptop completely inverts the hp ACPI interface.

I'd like to look at the output of "acpidump", but that may not help.  
(Other acpidumps I've seen just pass the calls through to the BIOS via SMI).


Also try running rfkill 
(http://wireless.kernel.org/en/users/Documentation/rfkill) on 2.6.33-rc1 
or later.  What do you see with -

"rfkill list" when your wireless is working, before you load hp-wmi.

"rfkill event" - this will stay running and log rfkill changes.  What 
does it show when you load hp-wmi?

"rfkill unblock wlan" after loading hp-wmi.  Does it get the wireless 
working?  What does "rfkill list" show afterwords?


If acpidump doesn't tell me anything, the rfkill details might help with 
crafting a work-around.


Regards
Alan
