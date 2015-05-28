From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/6] nfit: Fix up address spaces, sparse warnings
Date: Thu, 28 May 2015 15:40:46 -0700
Message-ID: <CAPcyv4hDxtny18+d2_u-oBeSU8MgU2_mdsTWkTHsz-VwGpba=w@mail.gmail.com>
References: <1432852553-24865-1-git-send-email-ross.zwisler@linux.intel.com>
	<1432852553-24865-3-git-send-email-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33219 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932533AbbE1Wkr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 May 2015 18:40:47 -0400
Received: by wicmx19 with SMTP id mx19so1767948wic.0
        for <linux-acpi@vger.kernel.org>; Thu, 28 May 2015 15:40:46 -0700 (PDT)
In-Reply-To: <1432852553-24865-3-git-send-email-ross.zwisler@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Thu, May 28, 2015 at 3:35 PM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> Fix a couple of sparse warnings (duplicate const, incorrect address
> space), and go back to using memcpy() instead of memcpy_toio() and
> memcpy_fromio() when talking to our block apertures.  Instead, include a
> union to alias mmio->base and mmio->aperture so that we can continue to
> reuse common code for ioremapping and deinterleaving.  mmio->base still
> has the __iomem annotation and is used via readq() and writeq() for the
> control and status registers.  mmio->aperture is used via normal
> memcpy() for aperture I/O.
>
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-acpi@vger.kernel.org

Folded into libnd-for-next.

Thanks Ross!
