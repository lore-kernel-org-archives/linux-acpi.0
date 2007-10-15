From: Andi Kleen <ak@suse.de>
Subject: Re: [RFC] [PATCH] ACPI :Modify timer override connection in Some NVIDIA systems
Date: Mon, 15 Oct 2007 18:32:59 +0200
Message-ID: <200710151832.59472.ak@suse.de>
References: <1192172655.27194.29.camel@yakui_zhao.sh.intel.com> <47139595.2040505@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51722 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759866AbXJOQdD (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 15 Oct 2007 12:33:03 -0400
In-Reply-To: <47139595.2040505@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Linux-acpi@vger.kernel.org, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Monday 15 October 2007 18:30:13 Chuck Ebbert wrote:
> On 10/12/2007 03:04 AM, Zhao Yakui wrote:
> > Hi, All
> >     The BIOS of some systems using NVIDIA chipset gives the uncorrect
> > timer override connection, which will cause that I/O APIC and timer
> > can't be connected and kernel panic.
> >     There are two ways to fix this bug. One is to use the following patch and 
> > the other is to add a new boot option of acpi_force_timer_override. 

This is already fixed in the firstfloor tree. 

-Andi
