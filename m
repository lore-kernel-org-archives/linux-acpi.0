From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.11 acpi battery state readout as source of keyboard/touchpad troubles
Date: Wed, 13 Apr 2005 13:24:52 +0200
Message-ID: <20050413112452.GA21023@elf.ucw.cz>
References: <424AF9C3.4000905@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261317AbVDMLZc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <424AF9C3.4000905@domdv.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, vojtech@suse.cz, dtor_core@ameritech.net, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi!

> In traceing the source of my sporadic synaptics touchpad troubles
> 
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
> psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
> 
> and keyboard troubles (sporadically lost key up/down events) on an Acer
> Aspire 1520 (x86_64, latest bios v1.09) I did enable the
> report_lost_ticks option which did spit out stuff like the following at
> regular intervals:
> 
> time.c: Lost 17 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 19 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 18 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
> 
> This looked suspiciously like it happended when the the kde laptop
> applet polled the battery status. So I did terminate the applet.
> 
> The result was no more lost ticks, no lost keyboard events and no more
> lost touchpad sync.
> 
> To verify ACPI battery data as the source of trouble i did a simple
> 
> cat /proc/acpi/battery/BAT0/state
...

CONFIG_ACPI_DEBUG enabled by chance?
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
