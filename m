From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/3] acpi: Provide default GPE handler if the firmware
	doesn't
Date: Wed, 11 Nov 2009 21:54:04 +0000
Message-ID: <20091111215404.GA24907@srcf.ucam.org>
References: <1257806687-6608-1-git-send-email-mjg@redhat.com> <200911112231.58027.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53483 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759284AbZKKVyI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2009 16:54:08 -0500
Content-Disposition: inline
In-Reply-To: <200911112231.58027.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, robert.moore@intel.com

On Wed, Nov 11, 2009 at 10:31:57PM +0100, Rafael J. Wysocki wrote:

> Do I think correctly it's based on top of the run-time PM patches?

It's logically distinct, but doesn't really do anything useful without 
them.

> > +static acpi_status acpi_pci_pme_notify(void *context)
> > +{
> > +	struct work_struct *work = kzalloc(sizeof(struct work_struct),
> > +					   GFP_ATOMIC);
> 
> kzalloc(sizeof(*work), ...) would save you a few characters. :-)

Heh. True.

> > +
> > +	if (work) {
> > +		INIT_WORK(work, context);
> > +		schedule_work(work);
> 
> Hmm.  Not sure if putting that into pm_wq wouldn't be better.

Would probably work.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
