From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [RFC] [PATCH] ACPI :Modify timer override connection in Some
 NVIDIA systems
Date: Tue, 16 Oct 2007 17:07:29 -0400
Message-ID: <47152811.7010103@redhat.com>
References: <1192172655.27194.29.camel@yakui_zhao.sh.intel.com> <47139595.2040505@redhat.com> <200710151832.59472.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:49470 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935856AbXJPVIR (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 16 Oct 2007 17:08:17 -0400
In-Reply-To: <200710151832.59472.ak@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Linux-acpi@vger.kernel.org, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>

On 10/15/2007 12:32 PM, Andi Kleen wrote:
> On Monday 15 October 2007 18:30:13 Chuck Ebbert wrote:
>> On 10/12/2007 03:04 AM, Zhao Yakui wrote:
>>> Hi, All
>>>     The BIOS of some systems using NVIDIA chipset gives the uncorrect
>>> timer override connection, which will cause that I/O APIC and timer
>>> can't be connected and kernel panic.
>>>     There are two ways to fix this bug. One is to use the following patch and 
>>> the other is to add a new boot option of acpi_force_timer_override. 
> 
> This is already fixed in the firstfloor tree. 
> 

Do I need something more than early-quirks-unification and nvidia-timer-quirk?
Because those two don't fix anything; I have to manually force
acpi_use_timer_override to get things to work right. The RFC patch seems to
be doing the right thing automatically.

Hardware: nVidia MCP51/C51 (with HPET)
Host Bridge PCI ID: 10de:02f0
