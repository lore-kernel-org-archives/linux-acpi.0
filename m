From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V2 2/2] ACPI: Add support for exposing BGRT data
Date: Tue, 31 Jan 2012 19:40:35 +0000
Message-ID: <20120131194034.GA11889@srcf.ucam.org>
References: <1328033960-407-1-git-send-email-mjg@redhat.com>
 <1328033960-407-2-git-send-email-mjg@redhat.com>
 <20120131192858.GA25942@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58486 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab2AaTkj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2012 14:40:39 -0500
Content-Disposition: inline
In-Reply-To: <20120131192858.GA25942@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

On Tue, Jan 31, 2012 at 02:28:59PM -0500, Konrad Rzeszutek Wilk wrote:
> > +config ACPI_BGRT
> > +        tristate "Boottime Graphics Resource Table support"
> > +        default n
> 
> Should it depend on the SYSFS?

Turning off sysfs is a thing you can do? Wow. But anyway, no - it'll 
build and link fine even with sysfs turned off.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
