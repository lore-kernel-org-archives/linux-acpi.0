From: Rodney Cacy <cacy-rodney-cacy@tlen.pl>
Subject: Re: understanding acpi
Date: Mon, 04 Dec 2006 13:24:04 +0100
Message-ID: <45741364.5040308@tlen.pl>
References: <456EB894.20306@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from d1.imc.pcz.czest.pl ([212.87.226.194]:4615 "HELO
	d1.imc.pcz.czest.pl") by vger.kernel.org with SMTP id S936207AbWLDMVY
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 07:21:24 -0500
In-Reply-To: <456EB894.20306@imag.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm not an expert but you can pass a boot kernel option:

processor.max_cstate

More inforamtion in http://www.columbia.edu/~ariel/acpi/acpi_howto.txt, 
section 7.
Write me about the results. Now I'm working under suspending sound,lan 
etc. to save battery but soon I will work with the noise reduction.

Cacy


Oliver Henriot wrote:
> Hi all list subscribers,
> 
> I'm looking for info on how acpi functions in order to get it to work 
> the best possible on my computer. It's a Sony laptop (vaio vgn-sz3xp/c, 
> core2duo) running Debian Etch. In particular, I'm looking for ways to 
> reduce thermal dissipation from the CPU as much as possible, in order to 
> queep the machine as quiet as possible. From the various docs I've read, 
> so far I seem to understand that C-states is the way to go, throttling 
> being probably not very efficient.
> 
> When I'm running on batteries, C3 state is active (as shown by cat 
> /prc/acpi/processor/CPU0/power) and is the main state, whereas when I'm 
> running on mains, C3 disappears and only C1 and C2 remain.
> 
> My question are : wouldn't it be better if I could use C3 even when on 
> mains. Wouldn't it be even better with C4? As suggested by "Why My Cx 
> Power State Is Not Used" I tried unloading various modules (e.g. those 
> concerning usb but I got stuck with usbcore which refused to unload 
> despite nothing usb being connected) without any success. Being 
> relatively new to GNU/Linux, I'm a bit stuck here and don't know where 
> to look or what to make of this.
> 
> Any help would be gladly welcome.
> 
> Cheers,
> 
> Oliver
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


