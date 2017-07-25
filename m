From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / watchdog: Fix init failure with overlapping
 register regions
Date: Tue, 25 Jul 2017 16:13:41 +0300
Message-ID: <20170725131341.GU2369@lahna.fi.intel.com>
References: <20170715214818.24979-1-ryan5544@gmail.com>
 <2680739.BCCY7oeAKy@aspire.rjw.lan>
 <20170725093731.GE2369@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:3072 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751127AbdGYNNq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jul 2017 09:13:46 -0400
Content-Disposition: inline
In-Reply-To: <20170725093731.GE2369@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ryan Kennedy <ryan5544@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Tue, Jul 25, 2017 at 12:37:31PM +0300, Mika Westerberg wrote:
> I wonder why we need to do this?
> 
> +                           if (res.start < rentry->res->start)
> +                                   rentry->res->start = res.start;
> +                           if (res.end > rentry->res->end)
> +                                   rentry->res->end = res.end;
> 
> IIRC we don't use rentry for anything else when we go out of the loop.
> Tuning those limits seems unnecessary.

OK, Ryan pointed out that the later code then uses the adjusted rentry
so this is indeed needed.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
