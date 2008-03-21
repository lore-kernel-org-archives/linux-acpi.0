From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 10/16] PCI slot: Replace dbg with pr_debug (Not for mainline!)
Date: Fri, 21 Mar 2008 13:30:46 -0600
Message-ID: <20080321193045.GJ424@parisc-linux.org>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com> <47E336BF.1010200@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:47921 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbYCUTaq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 15:30:46 -0400
Content-Disposition: inline
In-Reply-To: <47E336BF.1010200@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Alex Chiang <achiang@hp.com>, Greg KH <gregkh@suse.de>, Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

On Fri, Mar 21, 2008 at 01:17:03PM +0900, Kenji Kaneshige wrote:
> The dbg() macro doesn't work because the 'pci_slot_debug' flag never
> be set unless we manually modify drivers/pci/slots.c. So we should use
> pr_debug() instead. This patch replaces dbg() with pr_debug().

ACK.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
