From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 6/6] libnvdimm: fix potential deadlock while clearing errors
Date: Thu, 20 Jul 2017 20:23:34 -0700
Message-ID: <CAPcyv4jbMwtZLnNuwpaVF-W21HLc8QD5rYn6b7wBxcnV5eDAow@mail.gmail.com>
References: <20170717235655.26424-1-vishal.l.verma@intel.com> <20170717235655.26424-7-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34428 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdGUDXf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2017 23:23:35 -0400
Received: by mail-yw0-f179.google.com with SMTP id x6so13056155ywd.1
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jul 2017 20:23:35 -0700 (PDT)
In-Reply-To: <20170717235655.26424-7-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Jeff Moyer <jmoyer@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Robert Moore <robert.moore@intel.com>

On Mon, Jul 17, 2017 at 4:56 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> With the ACPI NFIT 'DSM' methods, acpi can be called from IO paths.
> Specifically, the DSM to clear media errors is called during writes, so
> that we can provide a writes-fix-errors model.
>
> However it is easy to imagine a scenario like:
>  -> write through the nvdimm driver
>    -> acpi allocation
>      -> writeback, causes more IO through the nvdimm driver
>        -> deadlock
>
> Fix this by using memalloc_noio_{save,restore}, which sets the GFP_NOIO
> flag for the current scope when issuing commands/IOs that are expected
> to clear errors.
>
> Cc: <linux-acpi@vger.kernel.org>
> Cc: <linux-nvdimm@lists.01.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good to me. Please move this up in the series before we start
calling nvdimm_clear_poison() in the btt I/O path so there's no
bisection point where this deadlock comes back.
