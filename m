From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: add driver for SMBus Control Method Interface
Date: Thu, 16 Jul 2009 02:05:02 +0100
Message-ID: <20090716010502.GA955@srcf.ucam.org>
References: <20090715060219.GA30514@crane-desktop> <1247651002.4113.9.camel@localhost.localdomain> <20090715140057.GB19054@srcf.ucam.org> <1247705174.4113.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34544 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756822AbZGPBFI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2009 21:05:08 -0400
Content-Disposition: inline
In-Reply-To: <1247705174.4113.15.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Crane Cai <crane.cai@amd.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jul 16, 2009 at 08:46:14AM +0800, ykzhao wrote:
> On Wed, 2009-07-15 at 22:00 +0800, Matthew Garrett wrote:
> > It's being accessed via ACPI methods, so the vendors have the 
> > opportunity to implement proper locking.
> If the vendors can implement the proper locking, there will be no
> conflict. 

I assume that the spec requires it.

> Another issue is that this driver had better be put in the directory of
> driver/platform/x86/.

I don't see anything x86-specific about it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
