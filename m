From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/6] acpi: change memory allocations to GFP_NOIO
Date: Sat, 15 Jul 2017 14:45:39 +0200
Message-ID: <4302778.he6LcxrvFg@aspire.rjw.lan>
References: <20170714221148.11232-1-vishal.l.verma@intel.com> <20170714221148.11232-6-vishal.l.verma@intel.com> <CAPcyv4jkJHKh0kXA3jGSU=QdmoZCVQuM7YaMBzoSPqn4hVXk4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42263 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751187AbdGOMxZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 15 Jul 2017 08:53:25 -0400
In-Reply-To: <CAPcyv4jkJHKh0kXA3jGSU=QdmoZCVQuM7YaMBzoSPqn4hVXk4g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, "Moore, Robert" <robert.moore@intel.com>

On Friday, July 14, 2017 10:26:42 PM Dan Williams wrote:
> [ adding Bob ]
> 
> On Fri, Jul 14, 2017 at 3:11 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> > With the ACPI NFIT 'DSM' methods, acpi can be called from IO paths.
> > Specifically, the DSM to clear media errors is called during writes, so
> > that we can provide a writes-fix-errors model.
> >
> > However it is easy to imagine a scenario like:
> >  - write through the nvdimm driver
> >  - acpi allocation
> >  - writeback, causes more IO through the nvdimm driver
> >  - deadlock
> >
> > Making the acpi allocations GPF_NOIO would ensure that it doesn't
> > trigger writeback, and avoids the above deadlock.

Well, no.

The above is not a good enough reason to switch the entire subsystem over to
using GPF_NOIO wholesale, especially on systems that don't care about NFIT and
the related things (and that's the majority of systems shipping today AFAICS let
alone the systems already in production).

If that's one of *multiple* reasons to do the switch-over, we can talk about
that, but otherwise it just looks like an attempt to cut corners.

> Another option would be to custom code an acpi_ars_clear_error()
> routine that manages to issue the proper DSM without needing to
> perform any memory allocations, but this will have implications for
> the common ACPICA code.

But isn't that the *right* way to address the problem at hand?

I guess any OS using ACPICA will run into this problem sooner or later, so it
would not be unreasonable to request ACPICA modifications to address it IMO.

Thanks,
Rafael

