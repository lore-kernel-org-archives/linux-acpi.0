From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 14:32:46 +0100
Message-ID: <20161011133246.GB25049@remoulade>
References: <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <CAJZ5v0ixapEyg6dhhH=9xQbQ+yxr30pCxaJdK9LQg1jEyNUvkw@mail.gmail.com>
 <20161006213704.4idjpln4kdodwqj4@sirena.org.uk>
 <CAJZ5v0iQtviVprbiY+rvVr1q9STbM9OmwYRG91BS=2wLxA0hAQ@mail.gmail.com>
 <20161011124429.ptizsviqiwzbmbxc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752614AbcJKNeh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 09:34:37 -0400
Content-Disposition: inline
In-Reply-To: <20161011124429.ptizsviqiwzbmbxc@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>

On Tue, Oct 11, 2016 at 02:44:29PM +0200, Mark Brown wrote:
> On Tue, Oct 11, 2016 at 01:44:46AM +0200, Rafael J. Wysocki wrote:
> > On Thu, Oct 6, 2016 at 11:37 PM, Mark Brown <broonie@kernel.org> wrote:
> My primary concern is the addition of what appear to be phandles
> introduced as part of this patch set.  The previous discussion had been
> that we'd enable simple DT bindings which don't need inter-device
> references and that those needed more careful study.  This appears to
> be changing that.

Agreed.

To be quite clear, it doesn't matter that the mechanism isn't phandles per-se.

The fact that we're trying to describe relationships between devices (which has
fuzzy overlap with other parts of ACPI) is the major concern.

Thanks,
Mark.
