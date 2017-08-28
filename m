From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Mon, 28 Aug 2017 23:19:07 +0200
Message-ID: <2068052.V7iCDDLeOo@aspire.rjw.lan>
References: <20170823225447.15608-1-toshi.kani@hpe.com> <1587060.BVEodWPrhf@aspire.rjw.lan> <20170828212151.dawlnvvxhkkcmqo3@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62938 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751218AbdH1V1q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Aug 2017 17:27:46 -0400
In-Reply-To: <20170828212151.dawlnvvxhkkcmqo3@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Toshi Kani <toshi.kani@hpe.com>, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, August 28, 2017 11:21:52 PM CEST Borislav Petkov wrote:
> On Mon, Aug 28, 2017 at 10:55:07PM +0200, Rafael J. Wysocki wrote:
> > So what about the [3-5/5] in this series?
> > 
> > My current plan is to apply them too and expose a branch with them, can I
> > go ahead with that?
> 
> No, please expose a branch with only the ACPI patches, i.e., 1 and 2 and
> I can merge it and apply the EDAC patches ontop.
> 
> Then you and I need to sync up so that you send your pull requests first
> and I follow you so that Linus applies them in the proper order.
> 
> Makes sense?

Yup, works for me!

