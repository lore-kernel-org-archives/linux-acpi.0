From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 32/59] x86_64: get boot_cpu_id as early for k8_scan_nodes
Date: Mon, 13 Aug 2007 10:47:27 +0200
Message-ID: <200708131047.27595.ak@suse.de>
References: <200708102200.l7AM019i011880@imap1.linux-foundation.org> <200708121216.36110.ak@suse.de> <86802c440708122240l4bd7ea69yc477aec2273755c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33140 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S942069AbXHMItj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Aug 2007 04:49:39 -0400
In-Reply-To: <86802c440708122240l4bd7ea69yc477aec2273755c4@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Len Brown <lenb@kernel.org>, akpm@linux-foundation.org, linux-acpi@vger.kernel.org, clameter@sgi.com

On Monday 13 August 2007 07:40, Yinghai Lu wrote:

> maybe for intel x86_64, it is hard to make kernel with numa enabled
> with acpi=off.

You would need to write an k8topology.c equivalent for that
hardware. But fortunately it's not needed because they
don't have any ACPI less bios.

> but for amd k8 based system (even for later ...), it is rather simple
> and clear

Sorry I disagree. Most of your APIC patches are neither simple nor clear
and they're all quite risky and likely to break other systems.

The big problem with k8topology.c is that it cannot do its work
on its own,  but needs it to do partly doing CPU setup too. That 
means it cannot just set up state once, but keeps state continually
changing. That makes it quite messy. 

> also we can use that as good debug feature... it is good to verify
> system/hw/bios could work with kernel (acpi=off). So other os without
> acpi support or with broken acpi support still can work...

Debug features are ok if they're simple and don't impact the code
much, but that's not the case here.
Also more and more systems don't work without ACPI for other
reasons so it's not very useful. Also typically modern hardware
doesn't have a mptable so you couldn't use more than one CPU.

-Andi (who sometimes feels LinuxBIOS is more a AntiLinuxBIOS if it
requires such hacks) 
