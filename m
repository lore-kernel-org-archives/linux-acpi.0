From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] ACPICA: Export mutex functions
Date: Mon, 17 Apr 2017 08:56:46 -0700
Message-ID: <20170417155646.GA8730@roeck-us.net>
References: <1492009990-3539-1-git-send-email-linux@roeck-us.net>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E5924DB@ORSMSX110.amr.corp.intel.com>
 <20170412212241.GA12384@roeck-us.net>
 <1AE640813FDE7649BE1B193DEA596E886CE92A85@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33359 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdDQP4t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Apr 2017 11:56:49 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE92A85@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On Mon, Apr 17, 2017 at 09:39:35AM +0000, Zheng, Lv wrote:
> Hi,
> 
> > From: Guenter Roeck [mailto:linux@roeck-us.net]
> > Subject: Re: [PATCH] ACPICA: Export mutex functions
> > 
> > On Wed, Apr 12, 2017 at 03:29:55PM +0000, Moore, Robert wrote:
> > > The ACPICA mutex functions are based on the host OS functions, so they don't really buy you anything.
> > You should just use the native Linux functions.
> > >
> > 
> > You mean they don't really acquire the requested ACPI mutex,
> > and the underlying DSDT which declares and uses the mutex
> > just ignores if the mutex was acquired by acpi_acquire_mutex() ?
> > 
> > To clarify: You are saying that code such as
> > 
> > 	acpi_status status;
> > 
> > 	status = acpi_acquire_mutex(NULL, "\\_SB.PCI0.SBRG.SIO1.MUT0", 0x10);
> > 	if (ACPI_FAILURE(status)) {
> > 		pr_err("Failed to acquire ACPI mutex\n");
> > 		return -EBUSY;
> > 	}
> 
> Why do you need to access \_SB.PCI0.SBRG.SIO1.MUT0?
> OSPM should only invoke entry methods predefined by ACPI spec or whatever specs.
> There shouldn't be any needs that a driver acquires an arbitrary AML mutex.
> You do not seem to have justified the usage model, IMO.
> 

I am sorry, I have no idea how to do that. I can see that the resource in
question (IO address 0x2e/0x2f) is accessed from the DSDT, that the resource
is mutex protected, and that accesses to the same IO address from the Linux
kernel are unreliable unless I acquire the mutex in question. At the same time,
I can see that request_muxed_region() succeeds, so presumably ACPI does not
reserve the region for its exclusive use.

It may well be that the "official" response to this problem is "you must
not instantiate a watchdog, environmental monitor, or gpio driver (or anything
else provided by the Super-IO chip that requires access to those ports) on this
platform in Linux". Is that what you are suggesting ?

Thanks,
Guenter
