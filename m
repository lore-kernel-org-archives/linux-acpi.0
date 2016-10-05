From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 5 Oct 2016 17:18:00 +0100
Message-ID: <20161005161800.GA22433@red-moon>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753900AbcJEQR2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Oct 2016 12:17:28 -0400
Content-Disposition: inline
In-Reply-To: <20161005153229.GO1765@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Wed, Oct 05, 2016 at 06:32:29PM +0300, Mika Westerberg wrote:

[...]

> > FWIW I had a quick look at dts bindings with "compatible = nokia,smia"
> > and related kernel driver.
> > 
> > Those nodes require properties like clocks and power supplies, it
> > seems to me that there are already ACPI PM methods to control those
> > properties and therefore they should not be handled with PRP0001,
> > I am happy to be corrected if I am wrong.
> 
> Clocks and power supplies should be handled as native ACPI
> PowerResources. We are not trying to represent those here.
> 
> > When you start matching whole subsystem through PRP0001 and related
> > compatible strings you can end up in a situation where DT and ACPI
> > FW handling clash and that's why we were opposed to mixing them from
> > the beginning, in ARM world if we need a DT we boot with a devicetree.
> > 
> > If PRP0001 is used for leaf-nodes drivers properties it may work,
> > everything else, frankly, is a bit of a gamble you are taking.
> 
> The hardware we are describing is exactly the same, only thing that
> changes is the firmware interface. So if there is a hardware property
> that cannot be discovered automatically it needs to be provided by the
> firmware, like ACPI.

We certainly agree that HW is the same and that the firmware interfaces
differ, that's why mixing them is not exactly ideal.

> If it happens that the property already has an existing DT binding, why
> do you think it is gambling to use it instead of inventing the same with
> annother name for ACPI?

Do not spin the argument. I am telling you that what I am worried
about is mixing the interfaces because that might trigger kernel
control paths clashing while controlling HW (DT native vs ACPI control
methods). I am pretty sure this won't happen, still, if you do not mind
please post this series (and drivers actually making use of it) to a
wider audience (which includes devicetree and ARM mailing list) and we
will restart the discussion from there.

Thanks,
Lorenzo
