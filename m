From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] ACPI: Fix acpi_evaluate_object() return value check
Date: Wed, 22 Jan 2014 14:37:45 -0700
Message-ID: <CAErSpo4_VCVHcq2cs_HP-_0kFSnUWsxsr6Y1iiR==3XLNaVc2w@mail.gmail.com>
References: <1390272375-28728-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55420 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbaAVViH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jan 2014 16:38:07 -0500
Received: by mail-ie0-f174.google.com with SMTP id tp5so165213ieb.5
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jan 2014 13:38:06 -0800 (PST)
In-Reply-To: <1390272375-28728-1-git-send-email-wangyijing@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yijing Wang <wangyijing@huawei.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org, DRI mailing list <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Airlie <airlied@redhat.com>, Hanjun Guo <guohanjun@huawei.com>

On Mon, Jan 20, 2014 at 7:46 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> Since acpi_evaluate_object() returns acpi_status and not plain int,
> ACPI_FAILURE() should be used for checking its return value.
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
> v3->v4: Fix spell error, add Jani Nikula reviewed-by.
> v2->v3: Fix compile error pointed out by Hanjun.
> v1->v2: Add CC to related subsystem MAINTAINERS
> ---
>  drivers/gpu/drm/i915/intel_acpi.c              |   24 ++++++++++++++----------
>  drivers/gpu/drm/nouveau/core/subdev/mxm/base.c |    9 +++++----
>  drivers/gpu/drm/nouveau/nouveau_acpi.c         |   23 +++++++++++++----------
>  drivers/pci/pci-label.c                        |    9 ++++++---

For the drivers/pci/pci-label.c part,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +       status = acpi_evaluate_object(handle, "_DSM", &input, &output);
> +       if (ACPI_FAILURE(status)) {
> +               DRM_DEBUG_DRIVER("failed to evaluate _DSM: %s\n",
> +                               acpi_format_exception(status));

It's too bad there isn't an easy way to produce more informative error
messages, e.g., by including a namespace path or something.  A message
like:

    failed to evaluate _DSM: A requested entity is not found

is only useful if there's enough context to figure out what's going on.

Bjorn
