From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 4/12] PCI PM: Make it possible to force using INTx for
	PCIe PME signaling
Date: Wed, 6 Jan 2010 22:02:14 +0000
Message-ID: <20100106220214.GA25366@srcf.ucam.org>
References: <200912272057.10443.rjw@sisk.pl> <200912272102.22775.rjw@sisk.pl> <20100106135625.14b37f10@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57435 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884Ab0AFWCx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2010 17:02:53 -0500
Content-Disposition: inline
In-Reply-To: <20100106135625.14b37f10@jbarnes-piketon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Oliver Neukum <oliver@neukum.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Shaohua Li <shaohua.li@intel.com>, Francois Romieu <romieu@fr.zoreil.com>

On Wed, Jan 06, 2010 at 01:56:25PM -0800, Jesse Barnes wrote:

> This scares me a little... seems like we're not restoring some state on
> resume that's needed for MSIs to work?  Looks fine though.

Yeah, that was my concern. We debugged this a little on IRC and didn't 
get anywhere, though, so probably need to find someone who knows more 
about MSIs...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
