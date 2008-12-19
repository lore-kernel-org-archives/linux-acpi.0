From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC PATCH 2/3] PCI: parallel resume for pci devices on bus 0
Date: Thu, 18 Dec 2008 23:49:04 -0700
Message-ID: <20081219064903.GP19967@parisc-linux.org>
References: <1229668453.562.92.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:36600 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbYLSGtU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 01:49:20 -0500
Content-Disposition: inline
In-Reply-To: <1229668453.562.92.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>

On Fri, Dec 19, 2008 at 02:34:13PM +0800, Zhang Rui wrote:
> +	/* parallel resume for pci devices on bus 0 */
> +	if (dev->bus->number == 0)
> +		device_parallel_resume_register(&dev->dev, 1);

"bus 0" is presumably supposed to mean "devices on a root bus".  I think
you should be checking for dev->bus->parent == NULL instead.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
