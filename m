From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patrol@sinus.cz: Problem suspending Clevo D650SU notebook in 2.6.18]
Date: Fri, 29 Sep 2006 14:11:52 +0200
Message-ID: <200609291411.52636.rjw@sisk.pl>
References: <20060929053037.GA11335@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:19859 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932313AbWI2MJu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 Sep 2006 08:09:50 -0400
In-Reply-To: <20060929053037.GA11335@tangens.sinus.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>
Cc: linux-acpi@vger.kernel.org

Hi,

On Friday, 29 September 2006 07:30, Pavel Troller wrote:
> Hi!
>   I know that it's not a good manner to repost the message which was not
> answered, but I feel it like a real problem - I cannot regularly use my
> notebook now.

I must have missed your first post.

> Please anybody, I'm ready to participate with debugging, but 
> I need some help where to start, what to try to get the supend working
> again.
>        With excuse and regads, Pavel Troller
> 
> ----- Forwarded message from Pavel Troller <patrol@sinus.cz> -----
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

Please try to unload the acpi_cpufreq module before the suspend.  If that
helps, please add your system information to the bugzilla entry at
http://bugzilla.kernel.org/show_bug.cgi?id=7188

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
