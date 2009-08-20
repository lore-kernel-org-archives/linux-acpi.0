From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Thu, 20 Aug 2009 15:14:36 +0100
Message-ID: <20090820141436.GA3722@srcf.ucam.org>
References: <20090820030423.GA26357@sli10-desk.sh.intel.com> <Pine.LNX.4.44L0.0908201004100.3048-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57148 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbZHTOOt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Aug 2009 10:14:49 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0908201004100.3048-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thu, Aug 20, 2009 at 10:11:19AM -0400, Alan Stern wrote:

> How is the wakeup event received?  Maybe for this one type of device a 
> PCI quirk will solve the problem.

Pretty much the same as PME events on PCI - a GPE is generated, an SCI 
raised, the ACPI interpreter executes the code that's in the ACPI 
tables, that generates a notification event on the appropriate UHCI 
device, we live happily ever after.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
