From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Wed, 19 Aug 2009 12:52:10 +0100
Message-ID: <20090819115210.GC12216@srcf.ucam.org>
References: <1250666651.23178.116.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34199 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbZHSLwU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Aug 2009 07:52:20 -0400
Content-Disposition: inline
In-Reply-To: <1250666651.23178.116.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>

On Wed, Aug 19, 2009 at 03:24:11PM +0800, Shaohua Li wrote:

> Usually driver should does nothing in the op as bus can handle it. But in some
> cases, like pci bus, UHCI controller doesn't use standard PME registers for
> wakeup, instead of using special approach. In this case, UHCI controller driver
> should implement this op.

I'm not averse to the general concept, but I'm not entirely sold on it 
being necessary. All the hardware I'm aware of will send non-PME events 
as a notification on a specific device. Under what circumstances will we 
get a wakeup GPE for a non-PME device without knowing which device 
should be woken?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
