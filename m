From: Andi Kleen <ak@suse.de>
Subject: Re: [RFC] [PATCH] ACPI :Modify timer override connection in Some NVIDIA systems
Date: Tue, 16 Oct 2007 23:51:32 +0200
Message-ID: <200710162351.32953.ak@suse.de>
References: <1192172655.27194.29.camel@yakui_zhao.sh.intel.com> <200710151832.59472.ak@suse.de> <47152811.7010103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:56201 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965482AbXJPVwD (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 16 Oct 2007 17:52:03 -0400
In-Reply-To: <47152811.7010103@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Linux-acpi@vger.kernel.org, lenb@kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Tuesday 16 October 2007 23:07:29 Chuck Ebbert wrote:

> Do I need something more than early-quirks-unification and nvidia-timer-quirk?
> Because those two don't fix anything; I have to manually force
> acpi_use_timer_override to get things to work right. The RFC patch seems to
> be doing the right thing automatically.
> 
> Hardware: nVidia MCP51/C51 (with HPET)
> Host Bridge PCI ID: 10de:02f0

Do you see the "Nvidia board detected. Ignoring ACPI timer override." message?

-Andi

