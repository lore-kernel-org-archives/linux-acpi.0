From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/5] acpi, nfit: Switch to use new generic UUID API
Date: Thu, 1 Jun 2017 07:26:12 -0700
Message-ID: <CAPcyv4hPCXbykGrzQHSe85_rXO1apif1ScnSQ9r2wMND+9GitA@mail.gmail.com>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com> <20170531194152.65927-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35198 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFAO0O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2017 10:26:14 -0400
Received: by mail-oi0-f45.google.com with SMTP id l18so55758124oig.2
        for <linux-acpi@vger.kernel.org>; Thu, 01 Jun 2017 07:26:13 -0700 (PDT)
In-Reply-To: <20170531194152.65927-2-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx@lists.freedesktop.org

On Wed, May 31, 2017 at 12:41 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> There are new types and helpers that are supposed to be used in new code.
>
> As a preparation to get rid of legacy types and API functions do
> the conversion here.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/nfit/core.c | 54 ++++++++++++++++++++++++------------------------
>  drivers/acpi/nfit/nfit.h |  3 +--
>  include/linux/acpi.h     |  1 +
>  3 files changed, 29 insertions(+), 29 deletions(-)
>

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
