From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/5] ACPI: Switch to use generic guid_t in acpi_evaluate_dsm()
Date: Thu, 01 Jun 2017 00:42:30 +0200
Message-ID: <1607580.J10jKUyf1a@aspire.rjw.lan>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com> <20170531194152.65927-6-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49624 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750952AbdEaWtY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 May 2017 18:49:24 -0400
In-Reply-To: <20170531194152.65927-6-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx@lists.freedesktop.org, Amir Goldstein <amir73il@gmail.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Ben Skeggs <bskeggs@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>

On Wednesday, May 31, 2017 10:41:52 PM Andy Shevchenko wrote:
> acpi_evaluate_dsm() and friends take a pointer to a raw buffer of 16
> bytes. Instead we convert them to use guid_t type. At the same time we
> convert current users.
> 
> acpi_str_to_uuid() becomes useless after the conversion and it's safe to
> get rid of it.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

with one caveat.

I have a pending patch that will use acpi_evaluate_dsm(), so I'd like this to
be made available in an immutable branch once applied.

Thanks,
Rafael

