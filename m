From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Please review power management abstract for LF End User Summit
Date: Sat, 14 Nov 2009 10:27:05 -0600
Message-ID: <4AFEDA59.1060804@gmail.com>
References: <E87738D94A6AD54789B5B8D1BAEB06CC6EED79B299@azsmsx503.amr.corp.intel.com> <alpine.LFD.2.00.0911070025401.4070@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:48250 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbZKNQ1D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Nov 2009 11:27:03 -0500
Received: by ywh40 with SMTP id 40so2089745ywh.33
        for <linux-acpi@vger.kernel.org>; Sat, 14 Nov 2009 08:27:08 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911070025401.4070@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Mallick, Asit K" <asit.k.mallick@intel.com>, "Kleen, Andi" <andi.kleen@intel.com>, "'linux-power-mgmt@linux.intel.com'" <linux-power-mgmt@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 11/06/2009 11:30 PM, Len Brown wrote:
> Thanks for the suggestions.
>
> final abstract is here:
> http://events.linuxfoundation.org/eus09hpc4
>
> presentation being constructed here (currently draft 0.5):
> http://userweb.kernel.org/~lenb/doc/2009-EUS-Server-PM-web/index.html
>
> cheers,
> -Len Brown, Intel Open Source Technology Center

I noticed you mention that "power off is a valid power management 
strategy".. indeed you can use WOL to power up again, and Linux can boot 
quickly, unfortunately the boot speed on most server platforms in the 
BIOS before even starting to boot the OS is abysmal, and seems to be 
getting worse there as it improves in desktop systems. Some IBM servers 
take MINUTES just to initialize the RAID controller.. this sort of thing 
isn't exactly conducive to rapid power-up of servers when required.

Also, the power-off power usage of some servers isn't great either - 
some of them even have to keep the power supply fans running when 
powered off, otherwise presumably the PS would heat up too much..

Presumably in both of these cases it's because of a lack of demand for 
better behavior (fast power-up on desktops is demanded by Microsoft 
"designed for Windows" specs, and low power-off power usage is required 
by Energy Star, EU standards, etc.)
