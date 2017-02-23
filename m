From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/20] Move firmware specific code to firmware specific locations
Date: Thu, 23 Feb 2017 23:37:12 +0100
Message-ID: <2915459.fDeP2CYj8T@aspire.rjw.lan>
References: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51110 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751207AbdBWWme (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Feb 2017 17:42:34 -0500
In-Reply-To: <1487869276-25244-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Thursday, February 23, 2017 07:00:56 PM Sakari Ailus wrote:
> Hi,
> 
> This set moves firmware specific implementations of the device / fwnode
> property API to locations that are specific to firmware implementation,
> still leaving property set (which isn't really firmware) implementation in
> drivers/base/property.c.
> 
> The set begins with a few bugfixes (patches 1--3), followed by adding
> fwnode_operations struct and then gradually moving firmware dependent code
> to drivers/acpi/property.c and drivers/of/base.c.
> 
> The set depends on the ACPI graph support here:
> 
> <URL:http://marc.info/?l=linux-acpi&m=148786716920942&w=2>
> 
> Comments are welcome.

Patches [1-3/20] from this series seem to be fixes that don't depend on the
rest of it and don't depend on the other series you posted.

If that is the case, it would be good to get them in during this cycle instead
of sitting on them for several weeks.

So is that the case?

Thanks,
Rafael

