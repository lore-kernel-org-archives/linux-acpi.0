From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH]: ACPI: Skip the power state check in power transition
Date: Wed, 13 May 2009 14:08:05 +0100
Message-ID: <20090513130803.GA27522@srcf.ucam.org>
References: <1242106060.3773.216.camel@localhost.localdomain> <200905120857.40058.bjorn.helgaas@hp.com> <1242184384.3773.241.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39591 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906AbZEMNIL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 May 2009 09:08:11 -0400
Content-Disposition: inline
In-Reply-To: <1242184384.3773.241.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, May 13, 2009 at 11:13:04AM +0800, yakui_zhao wrote:

> In fact this object is defined in ACPI spec. And we had better follow
> that. IMO Linux ACPI does the right thing.
> The boot option of "acpi.power_nocheck" is only to make Linux be
> compatible with windows.

The default behaviour should be to be compatible with Windows, 
regardless of what the spec says. There's an argument for providing a 
strict interpretation of the spec for testing purposes, but I don't see 
any reason for it to be split up into dozens of individual kernel 
parameters.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
