From: Pavel Troller <patrol@sinus.cz>
Subject: Re: Problem suspending Clevo D650SU notebook in 2.6.18
Date: Sat, 23 Sep 2006 07:05:05 +0200
Message-ID: <20060923050505.GA15466@tangens.sinus.cz>
References: <20060923045947.GA15012@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:49552 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1750995AbWIWFFI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 23 Sep 2006 01:05:08 -0400
Content-Disposition: inline
In-Reply-To: <20060923045947.GA15012@tangens.sinus.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>, linux-acpi@vger.kernel.org

> Hi!
>   After a while I've updated my notebook. Formerly it was loaded with 2.6.15
> and now it runs 2.6.18.
>   All seems to be working well, except suspending, either to RAM or to disk.
>   Both is blocked by very similar event. For example, the following is dumped
> when attempting to use STR:
> pnp: Device 00:09 disabled.
> Stopping tasks: ========================================================================|
> [ACPI Debug]  String: [0x1B] "===== SST Sleeping S3 ====="
> Class driver suspend failed for cpu0
> some devices failed to power down
> Could not power down device <4 random binary characters>: error -22
> ACPI: PCI Interrupt 0000:00:02.7[C] -> Link [LNKF] -> GSI 10 (level, low) -> IRQ 10
> PM: Writing back config space on device 0000:00:0c.0 at offset 1 (was 2100003, writing 2100007)
> ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
> pnp: Device 00:06 does not support activation.
> pnp: Failed to activate device 00:07.
> Restarting tasks... done
> [ACPI Debug]  String: [0x1A] "===== SST Working S2 ====="
> [ACPI Debug]  String: [0x17] "===== SST Working ====="
>   Please look at thos 3 lines starting with "Class driver suspend failed for cpu0".
>   On the 3rd, there are 4 non-ASCII characters as the name, which were unable
> to be transferred by mouse c&p (between text consoles).
> There are also another messages regarding device activation, which were not
> present in 2.6.15. 
>   Any help, how to get the system suspend working again, is highly appreciated.
>      With regards, Pavel Troller
I forgot to say that this kernel is newly patched with hrtimers+nohz patch.
Is it possible that it can cause the problem ?
       Pavel
