From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] acpi, nfit: check for the correct event code in notifications
Date: Mon, 22 Aug 2016 15:43:22 -0700
Message-ID: <CAPcyv4iw0ErHB-1yp+w4nd+7A5aVHXbieRq2ikR953UL4FBUVQ@mail.gmail.com>
References: <1471639258-28106-1-git-send-email-vishal.l.verma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35697 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754599AbcHVWnX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Aug 2016 18:43:23 -0400
Received: by mail-oi0-f54.google.com with SMTP id 4so173224791oih.2
        for <linux-acpi@vger.kernel.org>; Mon, 22 Aug 2016 15:43:23 -0700 (PDT)
In-Reply-To: <1471639258-28106-1-git-send-email-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linda Knippers <linda.knippers@hpe.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Fri, Aug 19, 2016 at 1:40 PM, Vishal Verma <vishal.l.verma@intel.com> wrote:
> Commit 209851649dc4 "acpi: nfit: Add support for hot-add" added
> support for _FIT notifications, but it neglected to verify the
> notification event code matches the one in the ACPI spec for
> "NFIT Update". Currently there is only one code in the spec, but
> once additional codes are added, older kernels (without this fix)
> will misbehave by assuming all event notifications are for an
> NFIT Update.
>
> Fixes: 209851649dc4 ("acpi: nfit: Add support for hot-add")
> Cc: <stable@vger.kernel.org>
> Cc: <linux-acpi@vger.kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Linda Knippers <linda.knippers@hpe.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good to me.  Given the lead time of spec changes I think this
can wait for the 4.9 merge window.  I'll add it to the -next branch.
