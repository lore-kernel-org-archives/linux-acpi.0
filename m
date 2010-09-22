From: Anil Ravindranath <anil_ravindranath@pmc-sierra.com>
Subject: SMP affinity MSI-X interrupts
Date: Wed, 22 Sep 2010 09:18:00 -0700 (PDT)
Message-ID: <alpine.LNX.1.10.1009220902530.28792@rslab235.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: anil_ravindranath@pmc-sierra.com
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a Dual Core(and also Quad core) system and a controller which has 
MSI-X interrupts.

What I noticied is that all interrupts coming only on CPU0. The 
system/config is SMP aware.

As we undestand, I try to modify /proc/irq/num/smp_affinity settings to 
get the interrupts for more than one core, what I noticied is if I change 
it to lets say "2", I start getting interrupts only on CPU1. Now I change it 
to "3", but I don't getting interrupts on CPU0 and CPU1. Its not taking 
more than one CPU mask value.

I checked the irq_set_affinity() function and found that it need couple 
of config settings like CONFIG_SMP and CONFIG_GENERIC_PENDING_IRQ and both 
are set in my config.

Looks like, the function irq_affinity_write_proc( ) is also taking "3" 
(more than one CPU mask) correctly.

The irqbalancer is ON . Is there anyother CONFIG setting I am 
missing?

I am using a Distro kernel very latest (2.6.32 based). I can try on a 
latest kernel as well.

with regards,
  Anil
