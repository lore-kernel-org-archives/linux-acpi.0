From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RFC] [PATCH] ACPI :Modify timer override connection in Some
	NVIDIA systems
Date: Wed, 17 Oct 2007 17:00:39 +0800
Message-ID: <1192611639.15762.7.camel@yakui_zhao.sh.intel.com>
References: <1192172655.27194.29.camel@yakui_zhao.sh.intel.com>
	 <200710151832.59472.ak@suse.de> <47152811.7010103@redhat.com>
	 <200710162351.32953.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11540 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757803AbXJQIw4 (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Wed, 17 Oct 2007 04:52:56 -0400
In-Reply-To: <200710162351.32953.ak@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Chuck Ebbert <cebbert@redhat.com>, Linux-acpi@vger.kernel.org, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Tue, 2007-10-16 at 23:51 +0200, Andi Kleen wrote:
> On Tuesday 16 October 2007 23:07:29 Chuck Ebbert wrote:
> 
> > Do I need something more than early-quirks-unification and nvidia-timer-quirk?
> > Because those two don't fix anything; I have to manually force
> > acpi_use_timer_override to get things to work right. The RFC patch seems to
> > be doing the right thing automatically.
> > 
> > Hardware: nVidia MCP51/C51 (with HPET)
> > Host Bridge PCI ID: 10de:02f0
> 
> Do you see the "Nvidia board detected. Ignoring ACPI timer override." message?
When booted with acpi=off, the system will print the message ---Nvidia
board detected .Ignoring ACPI timer override. 
But when booted with acpi on, the system won't print the above message. 

The chipset of NVIDIA is used and HPET exists. So the timer_override is
required. But unfortunately the timer override info provided by BIOS is
uncorrect. 
> -Andi
