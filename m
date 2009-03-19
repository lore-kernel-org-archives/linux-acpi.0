From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch]: ACPI: Add the Pansonic CF51 box to the dmi check table
Date: Thu, 19 Mar 2009 01:21:41 +0000
Message-ID: <20090319012141.GA7658@srcf.ucam.org>
References: <1237365385.3640.43.camel@localhost.localdomain> <20090318134153.GA28461@srcf.ucam.org> <1237425368.3640.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53582 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZCSBVu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2009 21:21:50 -0400
Content-Disposition: inline
In-Reply-To: <1237425368.3640.61.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Mar 19, 2009 at 09:16:07AM +0800, yakui_zhao wrote:
> On Wed, 2009-03-18 at 21:41 +0800, Matthew Garrett wrote:
> > Do we have any idea what's going on here, yet?
> >  Several of the machines 
> > on this blacklist are modern, so it's not a workaround for ancient 
> > hardware.
> Now we have no idea how the behaviour is changed with the boot option.
> In fact the boot option is useful for all the boxes that can't be
> resumed unless it is added. 
> 
> Although the machine is modern, the ACPI 1.0 is followed on this box.
> Without the boot option of "acpi_sleep=old_ordering", it can't be
> resumed from S3 correctly. But after adding the boot option, the box can
> be resumed. 

Yes. So how do we tell which ordering a machine needs without having a 
blacklist? Windows doesn't.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
