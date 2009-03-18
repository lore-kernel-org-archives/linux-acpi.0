From: garkein@mailueberfall.de
Subject: Re: Processor state C6 only used in battery mode, workaround
	possible?
Date: Wed, 18 Mar 2009 19:43:14 +0100
Message-ID: <1237401794.5333.1.camel@thinkpad>
References: <1214734353.5024.19.camel@thinkpad>
	 <alpine.LFD.2.00.0903181343220.5268@localhost.localdomain>
Reply-To: garkein@mailueberfall.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37417 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751673AbZCRSnT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Mar 2009 14:43:19 -0400
In-Reply-To: <alpine.LFD.2.00.0903181343220.5268@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Am Mittwoch, den 18.03.2009, 14:08 -0400 schrieb Len Brown:
> On Sun, 29 Jun 2008, garkein@mailueberfall.de wrote:
> 
> > Hello,
> > with recent powertop, I could confirm that my T61 uses the C6 processor
> > state only in battery mode:
> > 
> > (Kernel 2.6.25)
> > 
> > AC:
> > Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6 
> > Your BIOS reports the following C-states : C1 C2 C3
> > 
> > Battery:
> > Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6 
> > Your BIOS reports the following C-states : C1 C2 C6
> > 
> > Since the notebook runs quite a bit cooler, and thus less noisy (fan) in
> > battery mode, I would like to have it use that C6 state also in AC mode.
> > Is it possible, maybe with some slight tweaks, to convice the kernel (or
> > BIOS?) to also use that C6 state when in AC mode?
> 
> Lenovo decided when they designed the platform to do extra work to
> switch what ACPI C3 means on AC vs DC.  They chose to have lower latency
> on AC, and save energy on DC.  (you will notice lower latency reported
> for C3 when on DC if you look in /proc/acpi/processor/*/power or
> in /sys/devices/system/cpu/cpu*/cpuidle/*/latency
> eg. it may switch between 57usec and 17usec
> 
> if you boot with "processor.nocst=1"
> then you'll use the legach FADT method of specifying C-states,
> and will lose the AC/DC switching capability, and also lose
> the MWAIT capability -- though you'll unlikely notice.
> So you'll get stuck with a single C3 state -- dunno if it
> is the one you prefer or the one you don't prefer...
> 
> If this doesn't help and you want to hack your driver,
> then just go to acpi_processor_notify() in processor_core.c
> and disable the call to acpi_processor_cst_has_changed()
> and boot on DC...
> 
> The long term answer to your question is that we are hoping
> to get permission to ship a native intel_idle driver which
> will give Linux the option to ignore the ACPI BIOS in this 
> area.
> 
> cheers,
> -Len

Thank you Len for your explanation. The long term way would be my
preference as I don't want to be "stuck" with a single state. (I want
them all! ;-)).

Regards,
Daniel

