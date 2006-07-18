From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: dock problem - Dell Latitude+2.6.18-rc2
Date: Tue, 18 Jul 2006 11:09:17 -0700
Message-ID: <20060718110917.1f35ca8c.kristen.c.accardi@intel.com>
References: <200607181957.21224.jaroslav@aster.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:60583 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932337AbWGRSJV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Jul 2006 14:09:21 -0400
In-Reply-To: <200607181957.21224.jaroslav@aster.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jaroslaw Gorny <jaroslav@aster.pl>
Cc: linux-acpi@vger.kernel.org

On Tue, 18 Jul 2006 19:57:12 +0200
Jaroslaw Gorny <jaroslav@aster.pl> wrote:

> Hi,
> I've got one Dell Latitude D505 with a dock-station, like this:
> http://laptoptravel.com/product.aspx?pc=DELLDPORT&V=DT
>

Hi!  Can you please run an experiment in which you boot your laptop
undocked, and then dock and then try undocking again and let me know
if you still encounter the problem.  Also, can you send me your
acpi dsdt table, as well as the output of lspci -vv with your laptop
booted in the dock station, and also with it booted outside of the
dock station.  I'd also like a copy of your dmesg output from your 
laptop when you boot docked, as well as when you boot undocked.

I am travelling this week and will probably not be available to 
work on this problem till next week, but if in the meantime you can
collect this information that would be helpful. 

Thank you,
Kristen
 
> Today I've built 2.6.18-rc2 kernel with dock module.
> When I pushed "undock-request" button the following has happend:
> 
> 1. Total system freeze for sth. like 20 seconds (no response, no sound, no 
> keyboard, no nothing). During that time "undock" LED was blinking.
> 
> 2. After that system started to "work" again. But cpu usage jumped to 100% 
> and /var/log/messages was flooded with this:
> 
> <quote>
> Jul 18 09:49:15 localhost kernel: [  360.989000] ACPI Exception 
> (acpi_bus-0071): AE_NOT_FOUND, No context for object [c14789a0] [20060707]
> Jul 18 09:49:15 localhost kernel: [  360.991000] ACPI Exception 
> (acpi_bus-0071): AE_NOT_FOUND, No context for object [c14789a0] [20060707]
> Jul 18 09:49:15 localhost kernel: [  360.992000] ACPI Exception 
> (acpi_bus-0071): AE_NOT_FOUND, No context for object [c14789a0] [20060707]
> Jul 18 09:49:15 localhost kernel: [  360.994000] ACPI Exception 
> (acpi_bus-0071): AE_NOT_FOUND, No context for object [c14789a0] [20060707]
> Jul 18 09:49:15 localhost kernel: [  360.996000] ACPI Exception
> </quote>
> 
> 3. To reboot I had to push power button for 3 seconds (simple powerdown didn't 
> work).
> 
> 
> If I can provide any additional informations, or to test something - please 
> let me know.
> 
> By the way: this kernel for me is the first one with dock module.
> Some time ago I just pushed the "undock-request" button to see what happens. 
> And of course nothing has happened. "undock" LED has blinked several times 
> and everything returned to normal state. Without any issues, without any 
> messages in /var/log/* files.
> 
> Regards,
> 
> -- 
> Jaroslaw Gorny
> jaroslav@aster.pl
> 
> 
> -----BEGIN GEEK CODE BLOCK-----
> Version: 3.12
> GMU/E/CS d+/-- s+: a- c++ UL++/US P+>++ L+++>++++
> E>++ W N++ o? K w--- !O M V- PS+++ PE++ Y PGP>++ t 5
> X- R- tv--/!tv b++ DI-- D G- e++>+++ h-- r+++ z+++
> -----END GEEK CODE BLOCK-----
> 
