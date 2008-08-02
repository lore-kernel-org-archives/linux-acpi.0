From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI OSI disaster on latest HP laptops - critical temperature shutdown
Date: Sat, 2 Aug 2008 20:49:54 +0100
Message-ID: <20080802194954.GB1168@srcf.ucam.org>
References: <200807241727.41715.trenn@suse.de> <alpine.LFD.1.10.0807241952270.6098@localhost.localdomain> <200807251319.12786.trenn@suse.de> <alpine.LFD.1.10.0807250948320.3884@localhost.localdomain> <alpine.LFD.1.10.0808011706350.3011@localhost.localdomain> <20080801223657.GD23558@khazad-dum.debian.net> <20080802054204.GB12646@srcf.ucam.org> <20080802143833.GC14069@khazad-dum.debian.net> <20080802154114.GA28879@srcf.ucam.org> <20080802174958.GA20430@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46155 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128AbYHBTuB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Aug 2008 15:50:01 -0400
Content-Disposition: inline
In-Reply-To: <20080802174958.GA20430@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, Arjan van de Ven <arjan@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Christian Kornacker <ckornacker@suse.de>

On Sat, Aug 02, 2008 at 02:49:58PM -0300, Henrique de Moraes Holschuh wrote:

> Correction: special case ALL non-windows.  There's a reason why I said
> ACPICA should provide OSI(NonWindows).

The only two operating systems of any significance that can run on 
generic hardware are Windows and Linux. Given that BIOS authors hate the 
human race, OSI(NonWindows) is equivalent to OSI(Linux).

-- 
Matthew Garrett | mjg59@srcf.ucam.org
