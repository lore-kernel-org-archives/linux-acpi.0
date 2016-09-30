From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 3/3] libnvdimm: clear the internal poison_list when
 clearing badblocks
Date: Fri, 30 Sep 2016 15:48:37 -0700
Message-ID: <CAPcyv4jqXSjS-Yeex-1rG4Xinx5saxM2LrkyQ=qdVVEBnqi2Ag@mail.gmail.com>
References: <1475266203-18559-1-git-send-email-vishal.l.verma@intel.com> <1475266203-18559-4-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34286 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbcI3Wsj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Sep 2016 18:48:39 -0400
Received: by mail-oi0-f43.google.com with SMTP id n132so82050143oih.1
        for <linux-acpi@vger.kernel.org>; Fri, 30 Sep 2016 15:48:38 -0700 (PDT)
In-Reply-To: <1475266203-18559-4-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Linda Knippers <linda.knippers@hpe.com>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Fri, Sep 30, 2016 at 1:10 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> nvdimm_clear_poison cleared the user-visible badblocks, and sent
> commands to the NVDIMM to clear the areas marked as 'poison', but it
> neglected to clear the same areas from the internal poison_list which is
> used to marshal ARS results before sorting them by namespace. As a
> result, once on-demand ARS functionality was added:
>
> 37b137f nfit, libnvdimm: allow an ARS scrub to be triggered on demand
>
> A scrub triggered from either sysfs or an MCE was found to be adding
> stale entries that had been cleared from gendisk->badblocks, but were
> still present in nvdimm_bus->poison_list.
>
> This adds the missing step of clearing poison_list entries when clearing
> poison, so that it is in sync with badblocks.
>
> Fixes: 37b137f nfit, libnvdimm: allow an ARS scrub to be triggered on demand
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good, when you resend the other patches amend this changelog to
also say that the cleared errors come back if you disable and
re-enable a namespace.
