From: <Stuart_Hayes@Dell.com>
Subject: RE: [PATCH] ACPICA: Do not hang at mutex forever if BIOS tries to
 release global lock
Date: Mon, 18 Oct 2010 10:37:15 -0500
Message-ID: <07E32F241046DA418A0381C1225BFC011A42BCE7BF@AUSX7MCPS301.AMER.DELL.COM>
References: <201010081240.15203.trenn@suse.de>
 <alpine.LFD.2.00.1010152222150.2971@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223]:31399 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943Ab0JRPhW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Oct 2010 11:37:22 -0400
In-Reply-To: <alpine.LFD.2.00.1010152222150.2971@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, trenn@suse.de
Cc: robert.moore@intel.com, linux-acpi@vger.kernel.org, devel@acpica.org

> 
> > There seem to be chipsets which can get this wrong (especially after
> a kexec
> > boot on Linux).
> 
> <recording>
> 
> As kexec is fundamentally unreliable by design,
> why should reliable software be modified for its beneift?
> 
> </recording>
> 

The problem isn't just with kexec.  The lock is acquired by acpi_ev_global_lock_handler() when a global lock release SCI occurs, even when the OS doesn't want it, which sets the "owned" bit on the first SCI and then the "pending" bit on the second SCI.  This prevents the global lock from working correctly, even though we're only seeing the OS hang waiting for the semaphore because of this when a kexec boot is attempted.

