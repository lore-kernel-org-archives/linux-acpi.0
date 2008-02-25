From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [patch 2.6.25-rc2-git] crosslink ACPI and "real" device nodes
Date: Tue, 26 Feb 2008 06:10:22 +0800
Message-ID: <1203977422.10256.91.camel@acpi-hp-zz.sh.intel.com>
References: <200802222154.25204.david-b@pacbell.net>
	 <1203976028.10256.87.camel@acpi-hp-zz.sh.intel.com>
	 <200802252245.43282.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47608 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbYBZG61 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Feb 2008 01:58:27 -0500
In-Reply-To: <200802252245.43282.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org


On Tue, 2008-02-26 at 14:45 +0800, David Brownell wrote:
> On Monday 25 February 2008, Zhang, Rui wrote:
> > > +       if (!ACPI_FAILURE(status)) {
> > > +               int ret;
> > > +
> > > +               ret = sysfs_create_link(&dev->kobj,
> &acpi_dev->dev.kobj,
> > > +                               "firmware_node");
> > > +               ret = sysfs_create_link(&acpi_dev->dev.kobj,
> &dev->kobj,
> > > +                               "physical_node");
> > > +       }
> >
> > ret is not needed here...
> 
> But what compiler warnings do you see when you omit it?  :)
I tried but NO warnings at all

thanks,
rui

