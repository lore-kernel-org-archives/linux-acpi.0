From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] acpiphp: Identify more removable slots
Date: Thu, 13 Nov 2008 20:51:52 +0000
Message-ID: <20081113205152.GA11577@srcf.ucam.org>
References: <20081113202739.GA11107@srcf.ucam.org> <20081113204859.GC1617@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36668 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbYKMUvy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Nov 2008 15:51:54 -0500
Content-Disposition: inline
In-Reply-To: <20081113204859.GC1617@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 13, 2008 at 01:48:59PM -0700, Matthew Wilcox wrote:

> Why not:
> 
>  	status = acpi_get_handle(handle, "_EJ0", &tmp);
> 	if (ACPI_SUCCESS(status))
> 		return 1;
> 
> 	status = acpi_get_handle(handle, "_RMV", &tmp);
> 	if (ACPI_SUCCESS(status))
> 		return 1;
> 
> 	return 0;

Oh, yes, that'd work.

> > +	if (ACPI_SUCCESS(status) || is_dock_device(handle))
> > +		valid = 1;
> > +
> > +	if (!valid)
> >  		return AE_OK;
> 
> This looks like almost the same code as above.  New helper function?

It's not quite the same, but yes, I'll see if it can be reduced.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
