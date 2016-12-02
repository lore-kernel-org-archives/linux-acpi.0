From: Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH] acpi/rt: convert acpi_gbl_gpe_lock to raw spinlock
Date: Fri, 2 Dec 2016 11:15:22 -0600 (CST)
Message-ID: <325749590.352028.1480698922420.JavaMail.zimbra@xes-inc.com>
References: <390489414.497553.1480534166735.JavaMail.zimbra@xes-inc.com> <alpine.DEB.2.20.1612011458590.3453@nanos> <1883606374.779009.1480634160092.JavaMail.zimbra@xes-inc.com> <2036785.eB1G0pEAXS@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2036785.eB1G0pEAXS@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

----- Original Message -----
> From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Sent: Thursday, December 1, 2016 5:27:03 PM

> On Thursday, December 01, 2016 05:16:00 PM Aaron Sierra wrote:
>> ----- Original Message -----
>> > From: "Thomas Gleixner" <tglx@linutronix.de>
>> > Sent: Thursday, December 1, 2016 8:52:48 AM
>> 
>> > On Wed, 30 Nov 2016, Aaron Sierra wrote:
>> >> When testing GPE interrupts with CONFIG_PREEMPT_RT_FULL enabled, a
>> >> verbose WARN_ONCE message would print to the kernel log. It turned out
>> >> that the GPE interrupt handler was being called with local interrupts
>> >> enabled because acpi_gbl_gpe_lock was implemented as a spinlock_t. Full
>> >> preemption strips local interrupt disabling from spinlock_t operations,
>> >> but not for raw_spinlock_t operations.
>> >> 
>> >> This is the warning that was triggered:
>> >> 
>> >> ------------[ cut here ]------------
>> >> WARNING: CPU: 8 PID: 483 at kernel/irq/handle.c:149
>> >> __handle_irq_event_percpu+0x6f/0xcf
>> >> irq 33 handler irq_default_primary_handler+0x0/0xb enabled interrupts
>> >> Modules linked in: gpio_irq_demo(O)
>> >> CPU: 8 PID: 483 Comm: irq/9-acpi Tainted: G           O
>> >> 4.8.6-rt5-00012-geaa3b7c #6
>> >> Hardware name: Extreme Engineering Solutions, Inc. XCalibur4643/XCalibur4643,
>> >> BIOS 1-1.1.12.3_Alpha 04/29/2016
>> >>  0000000000000000 ffff880858f3bc10 ffffffff81219a93 ffff880858f3bc60
>> >>  0000000000000000 ffff880858f3bc50 ffffffff8104b84a 0000009500000000
>> >>  ffff880855b76880 0000000000000021 0000000000000002 ffff880856356800
>> >> Call Trace:
>> >>  [<ffffffff81219a93>] dump_stack+0x4d/0x63
>> >>  [<ffffffff8104b84a>] __warn+0xc0/0xdb
>> >>  [<ffffffff8104b8af>] warn_slowpath_fmt+0x4a/0x4c
>> >>  [<ffffffff810f7192>] ? path_openat+0xbf8/0xc62
>> >>  [<ffffffff8107d7c3>] ? handle_irq_event+0x75/0x75
>> >>  [<ffffffff8107d68d>] __handle_irq_event_percpu+0x6f/0xcf
>> >>  [<ffffffff8107d727>] handle_irq_event_percpu+0x3a/0x61
>> >>  [<ffffffff8107d7a3>] handle_irq_event+0x55/0x75
>> >>  [<ffffffff8107ff76>] handle_simple_irq+0x5c/0x92
>> >>  [<ffffffff81243a53>] gpe_irq_handler+0x2a/0x31
>> > 
>> > gpe_irq_handler is not in tree, so I really cannot tell what this is
>> > about. It looks like it does interrupt demultiplexing, which triggers the
>> > warning.
>> 
>> Thomas,
>> Your guess is correct, this involves a currently out-of-tree extension to
>> the gpio-ich driver which allows GPIO pins to be mapped to IRQs by demuxing
>> their corresponding GPE events.
>> 
>> The gpio_irq_demo module requests a GPIO pin, converts it to an IRQ using
>> gpio_to_irq() and registers a trivial handler against the IRQ.
> 
> And what does it have to do with GPEs, if I may ask?

Rafael,
The gpio-ich driver controls Intel ICH/PCH GPIOs. The first 16 of those GPIOs
on many platforms can be configured to generate GPEs. Demuxing those GPEs to
IRQs allows this driver to fit within the gpiolib framework to make GPIO-to-
IRQ translation possible.

> In the future, please CC all ACPI-related changes to linux-acpi@vger.kernel.org.

Sorry, I only looked up where RT patches should go.

-Aaron S.
