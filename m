From: Andi Kleen <ak@suse.de>
Subject: Re: [RFC] [PATCH] ACPI :Modify timer override connection in Some NVIDIA systems
Date: Wed, 17 Oct 2007 00:17:17 +0200
Message-ID: <200710170017.17854.ak@suse.de>
References: <1192172655.27194.29.camel@yakui_zhao.sh.intel.com> <200710162351.32953.ak@suse.de> <471533C5.6050303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:59010 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966170AbXJPWRW (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 16 Oct 2007 18:17:22 -0400
In-Reply-To: <471533C5.6050303@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Linux-acpi@vger.kernel.org, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Tuesday 16 October 2007 23:57:25 Chuck Ebbert wrote:
> On 10/16/2007 05:51 PM, Andi Kleen wrote:
> > On Tuesday 16 October 2007 23:07:29 Chuck Ebbert wrote:
> > 
> >> Do I need something more than early-quirks-unification and nvidia-timer-quirk?
> >> Because those two don't fix anything; I have to manually force
> >> acpi_use_timer_override to get things to work right. The RFC patch seems to
> >> be doing the right thing automatically.
> >>
> >> Hardware: nVidia MCP51/C51 (with HPET)
> >> Host Bridge PCI ID: 10de:02f0
> > 
> > Do you see the "Nvidia board detected. Ignoring ACPI timer override." message?
> > 
> 
> If I don't use the "force" option, yes. And the timer ends up as an XT-PIC-XT
> interrupt then. But the override is apparently not broken on this system.

I don't know then. Probably didn't work before either.

The early-quirks change was only supposed to fix NF5 without HPET enabled anyways; 
if NF3 or 4 don't work it's some other problem.

-And
