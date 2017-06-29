From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 1/4] ACPI / property: Don't evaluate objects for
 devices w/o handle
Date: Thu, 29 Jun 2017 10:30:58 +0300
Message-ID: <20170629073058.GY629@lahna.fi.intel.com>
References: <cover.1498636759.git.lukas@wunner.de>
 <f3596c7e5add8803a6022c04cedbaace11d70288.1498636759.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47049 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752362AbdF2Hb3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Jun 2017 03:31:29 -0400
Content-Disposition: inline
In-Reply-To: <f3596c7e5add8803a6022c04cedbaace11d70288.1498636759.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mark Brown <broonie@kernel.org>, Ronald Tschalaer <ronald@innovation.ch>, Federico Lorenzi <florenzi@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org

On Wed, Jun 28, 2017 at 07:20:19PM +0200, Lukas Wunner wrote:
> Fabricated devices such as LNXPWRBN lack a handle, causing evaluation
> of _CCA and _DSD to always fail with AE_BAD_PARAMETER.  While that is
> merely a (negligible) waste of processing power, evaluating a _DSM for
> them (such as Apple's device properties _DSM which we're about to add)
> results in an ugly error:
> 
>     ACPI: \: failed to evaluate _DSM (0x1001)
> 
> Avoid by not evaluating _DSD and the upcoming _DSM for devices without
> handle.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
