From: "Huang\, Ying" <ying.huang@intel.com>
Subject: Re: GHES platform devices
Date: Thu, 17 Nov 2016 09:27:02 +0800
Message-ID: <87twb6uc9l.fsf@yhuang-dev.intel.com>
References: <20161116213625.GA10368@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:60458 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933805AbcKQB1F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Nov 2016 20:27:05 -0500
In-Reply-To: <20161116213625.GA10368@bhelgaas-glaptop.roam.corp.google.com>
        (Bjorn Helgaas's message of "Wed, 16 Nov 2016 15:36:25 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:

> Hi Huang,
>
> 7ad6e9435596 ("ACPI, APEI, Manage GHES as platform devices") added
> platform devices so the GHES driver could be built as a module and
> automatically loaded when needed.
>
> Later, 86cd47334b00 ("ACPI, APEI, GHES, Prevent GHES to be built as
> module") removed the ability to build GHES as a module.
>
> Should we revert 7ad6e9435596?  It's inconsistent to handle GHES, but
> not other error sources, as a platform device.  And having it as a
> platform device probably puts gunk in sysfs that we don't need.

Although other error sources are not platform devices, I think it is
generally good to make GHES platform devices.  To take advantage of
automatic module loading, we can make ghes a module again, but prevent
it from unloading.  What do you think about that?

Best Regards,
Huang, Ying
