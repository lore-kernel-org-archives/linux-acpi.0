From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 10:57:39 +0100
Message-ID: <20161006095739.GA22984@red-moon>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <20161006091133.GF30800@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942174AbcJFJ5H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Oct 2016 05:57:07 -0400
Content-Disposition: inline
In-Reply-To: <20161006091133.GF30800@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Oct 06, 2016 at 12:11:33PM +0300, Mika Westerberg wrote:
> On Thu, Oct 06, 2016 at 09:57:03AM +0100, Lorenzo Pieralisi wrote:
> > I am trying to understand why x86 wants to do this, please understand
> > our point of view too, we do not want to block progress we want to
> > prevent a mess.
> 
> One reason is that we have boards like Joule where developers are
> allowed to connect different peripherals using buses such as I2C and SPI
> where there is no native enumeration mechanism. This includes camera
> sensors and related so there needs to be a way for a developer to
> describe this in ACPI. Just as can be done when using ARM and DT.

I am sorry I think we are at loggerheads on this. If you need a DT boot
with a DT, I could have converted all the ACPI tables to DT nodes on
ARM64 if I followed your reasoning (because we could not boot with ACPI
till relatively recently), we did not do it because ACPI and DT are
different specifications, incompatible with one another and governed by
different entities in a *very* different way.

You are saying that just re-using leaf nodes properties (well, it
is not just leaf-nodes properties any longer, is it ?) is just
fine; I(We) am not convinced, time will tell. In the interim
please notify the respective subsystems maintainers and DT people
of this patch intentions, again I hope I am not asking too much.

Thanks,
Lorenzo
