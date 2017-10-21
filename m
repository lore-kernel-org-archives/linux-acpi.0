From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/12] PM / sleep: Driver flags for system suspend/resume
Date: Sat, 21 Oct 2017 03:04:39 +0200
Message-ID: <9866321.2BgCJKj5ti@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <20171020204607.GQ6332@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61525 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753242AbdJUBOW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Oct 2017 21:14:22 -0400
In-Reply-To: <20171020204607.GQ6332@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

On Friday, October 20, 2017 10:46:07 PM CEST Bjorn Helgaas wrote:
> On Mon, Oct 16, 2017 at 03:12:35AM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > Well, this took more time than expected, as I tried to cover everything I had
> > in mind regarding PM flags for drivers.
> 
> For the parts that touch PCI,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thank you!

> I doubt there'll be conflicts with changes in my tree, but let me know if
> you trip over any so I can watch for them when merging.

Well, if there are any conflicts, we'll see them in linux-next I guess. :-)

Thanks,
Rafael

