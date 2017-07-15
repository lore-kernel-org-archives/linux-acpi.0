From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 5/6] acpi: change memory allocations to GFP_NOIO
Date: Fri, 14 Jul 2017 22:26:42 -0700
Message-ID: <CAPcyv4jkJHKh0kXA3jGSU=QdmoZCVQuM7YaMBzoSPqn4hVXk4g@mail.gmail.com>
References: <20170714221148.11232-1-vishal.l.verma@intel.com> <20170714221148.11232-6-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yb0-f170.google.com ([209.85.213.170]:34853 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdGOF0o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Jul 2017 01:26:44 -0400
Received: by mail-yb0-f170.google.com with SMTP id j80so24460849ybg.2
        for <linux-acpi@vger.kernel.org>; Fri, 14 Jul 2017 22:26:44 -0700 (PDT)
In-Reply-To: <20170714221148.11232-6-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, "Moore, Robert" <robert.moore@intel.com>

[ adding Bob ]

On Fri, Jul 14, 2017 at 3:11 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> With the ACPI NFIT 'DSM' methods, acpi can be called from IO paths.
> Specifically, the DSM to clear media errors is called during writes, so
> that we can provide a writes-fix-errors model.
>
> However it is easy to imagine a scenario like:
>  - write through the nvdimm driver
>  - acpi allocation
>  - writeback, causes more IO through the nvdimm driver
>  - deadlock
>
> Making the acpi allocations GPF_NOIO would ensure that it doesn't
> trigger writeback, and avoids the above deadlock.

Another option would be to custom code an acpi_ars_clear_error()
routine that manages to issue the proper DSM without needing to
perform any memory allocations, but this will have implications for
the common ACPICA code.
