From: Len Brown <lenb@kernel.org>
Subject: Re: Processor state C6 only used in battery mode, workaround possible?
Date: Wed, 18 Mar 2009 14:08:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903181343220.5268@localhost.localdomain>
References: <1214734353.5024.19.camel@thinkpad>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:63020 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbZCRSJA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2009 14:09:00 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGP0002ZRQ305D6@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 18 Mar 2009 13:08:35 -0500 (CDT)
In-reply-to: <1214734353.5024.19.camel@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: garkein@mailueberfall.de
Cc: linux-acpi@vger.kernel.org

On Sun, 29 Jun 2008, garkein@mailueberfall.de wrote:

> Hello,
> with recent powertop, I could confirm that my T61 uses the C6 processor
> state only in battery mode:
> 
> (Kernel 2.6.25)
> 
> AC:
> Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6 
> Your BIOS reports the following C-states : C1 C2 C3
> 
> Battery:
> Your CPU supports the following C-states : C1 C2 C3 C4 C5 C6 
> Your BIOS reports the following C-states : C1 C2 C6
> 
> Since the notebook runs quite a bit cooler, and thus less noisy (fan) in
> battery mode, I would like to have it use that C6 state also in AC mode.
> Is it possible, maybe with some slight tweaks, to convice the kernel (or
> BIOS?) to also use that C6 state when in AC mode?

Lenovo decided when they designed the platform to do extra work to
switch what ACPI C3 means on AC vs DC.  They chose to have lower latency
on AC, and save energy on DC.  (you will notice lower latency reported
for C3 when on DC if you look in /proc/acpi/processor/*/power or
in /sys/devices/system/cpu/cpu*/cpuidle/*/latency
eg. it may switch between 57usec and 17usec

if you boot with "processor.nocst=1"
then you'll use the legach FADT method of specifying C-states,
and will lose the AC/DC switching capability, and also lose
the MWAIT capability -- though you'll unlikely notice.
So you'll get stuck with a single C3 state -- dunno if it
is the one you prefer or the one you don't prefer...

If this doesn't help and you want to hack your driver,
then just go to acpi_processor_notify() in processor_core.c
and disable the call to acpi_processor_cst_has_changed()
and boot on DC...

The long term answer to your question is that we are hoping
to get permission to ship a native intel_idle driver which
will give Linux the option to ignore the ACPI BIOS in this 
area.

cheers,
-Len




