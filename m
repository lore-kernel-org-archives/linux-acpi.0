From: Thomas Renninger <trenn@suse.de>
Subject: Re: ACPI on Compaq 6715b - BIOS from the wrong end of the planet
Date: Tue, 29 Apr 2008 15:45:17 +0200
Message-ID: <1209476717.1784.853.camel@queen.suse.de>
References: <48144209.7080203@gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:48829 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbYD2NpS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 09:45:18 -0400
In-Reply-To: <48144209.7080203@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard <tuxbox.guru@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sun, 2008-04-27 at 10:06 +0100, Richard wrote:
> Hi all,
> 
> Pardon for the intrusion, I am trying to fault find a horrible wrong 
> ACPI interface and fix it.
> 
> the problem is as follows... 
> 
> Kernel 2.6.23 works fine, except there is no stable clocksource.. 
> acpi_pm, tsc doesnt work and jiffies .. well thats just jiffies. The 
> kernel boots but time sources are erratic and this results in an 
> unstable clock (Mp3's play at erratic speeds)
> 
> Kernel 2.6.25 hangs the system if I enable ACPI Timer and rebuild/boot 
> the new linux kernel. The only clock sources are tsc and jiffies and TSC 
> is disables due to being erratic. If I totally disable ACPI, the kernel 
> boots and works with stable clocks..  but obviously Power management is 
> gone.
> 
> The system is an ATI bridged AMD Sempron notebook. I have tried Millions 
> of options in the kernel bootup and none seem to do clear the problem. 
> This system seems to suffer from the Clocks fast bug. (the dmesg reports 
> that the 8254 clock is disables, IO-APIC int0 fails and IO-APIC Vritual 
> wire is OK.. if that means anything :D)
> 
> Any pointers.. and if anyone wants the AML/ACPI stuff, please feel free 
> to shout.
Does:
disable_timer_pin_1
or
noapictimer
work?

   Thomas

