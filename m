From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 14:01:21 +0100
Message-ID: <20161011130120.GF24347@remoulade>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <CAJZ5v0ixapEyg6dhhH=9xQbQ+yxr30pCxaJdK9LQg1jEyNUvkw@mail.gmail.com>
 <20161006213704.4idjpln4kdodwqj4@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752013AbcJKNLf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 09:11:35 -0400
Content-Disposition: inline
In-Reply-To: <20161006213704.4idjpln4kdodwqj4@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Thu, Oct 06, 2016 at 11:37:04PM +0200, Mark Brown wrote:
> On Thu, Oct 06, 2016 at 02:26:50PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Oct 6, 2016 at 10:57 AM, Lorenzo Pieralisi

> > And it is not an option for those boards to use DT in the firmware.
> 
> There's nothing stopping these systems defining a DSD that contains a
> DTB which overrides some or all of the ACPI if the system supports it
> (or otherwise providing both system descriptions). 

Please, no. We very deliberately avoided this mix-and-match scheme for arm64
(it was proposed in discussions several times), because it suffers form worse
issues than PRP (since you can't corss-reference between DT and ACPI).

The arm64 kernel needs a DTB to pass some OS-specific stuff like bootargs, but
when using ACPI almost everything else is ignored -- we don't unflatten the
tree and we don't instanciate devices from it.

> The two can coexist happily enough as arm64 has shown and it seems like it
> ought to save a whole lot of work especially around the bits that need inter
> device links and are hence need some new ACPI bindings defining.

A single kernel binary can happily support both, yes. But not a mixture at
runtime.

Thanks,
Mark.
