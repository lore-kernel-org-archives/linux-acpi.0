From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH V2 2/2] ACPI: Add support for exposing BGRT data
Date: Tue, 31 Jan 2012 14:53:43 -0500
Message-ID: <20120131195343.GA26484@phenom.dumpdata.com>
References: <1328033960-407-1-git-send-email-mjg@redhat.com>
 <1328033960-407-2-git-send-email-mjg@redhat.com>
 <20120131192858.GA25942@phenom.dumpdata.com>
 <20120131194034.GA11889@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:58633 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab2AaT4V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2012 14:56:21 -0500
Content-Disposition: inline
In-Reply-To: <20120131194034.GA11889@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Tue, Jan 31, 2012 at 07:40:35PM +0000, Matthew Garrett wrote:
> On Tue, Jan 31, 2012 at 02:28:59PM -0500, Konrad Rzeszutek Wilk wrote:
> > > +config ACPI_BGRT
> > > +        tristate "Boottime Graphics Resource Table support"
> > > +        default n
> > 
> > Should it depend on the SYSFS?
> 
> Turning off sysfs is a thing you can do? Wow. But anyway, no - it'll 
> build and link fine even with sysfs turned off.

Cool.
