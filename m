From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 7/7] tools/testing/nvdimm: fix nfit_test shutdown crashes
Date: Fri, 14 Apr 2017 16:37:54 -0700
Message-ID: <CAPcyv4iC6y__-QQszBCy3dv6AHs9L+4qsEp6waMU-oj=6EFJ3g@mail.gmail.com>
References: <149220702552.36563.10552898152402020832.stgit@dwillia2-desk3.amr.corp.intel.com>
 <149220706287.36563.2986440928438769021.stgit@dwillia2-desk3.amr.corp.intel.com>
 <58F15A92.3000101@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33710 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755233AbdDNXh4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Apr 2017 19:37:56 -0400
Received: by mail-oi0-f53.google.com with SMTP id b187so102846168oif.0
        for <linux-acpi@vger.kernel.org>; Fri, 14 Apr 2017 16:37:55 -0700 (PDT)
In-Reply-To: <58F15A92.3000101@hpe.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linda Knippers <linda.knippers@hpe.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Fri, Apr 14, 2017 at 4:26 PM, Linda Knippers <linda.knippers@hpe.com> wrote:
> On 04/14/2017 05:57 PM, Dan Williams wrote:
>> Keep the nfit_test instances alive until after nfit_test_teardown(), as
>> we may be doing resource lookups until the final un-registrations have
>> completed. This fixes crashes of the form.
>
> Sorry Dan, it didn't help in my case.

Ok, no worries, the search continues.
