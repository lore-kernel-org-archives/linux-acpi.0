From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Mon, 28 Aug 2017 23:21:52 +0200
Message-ID: <20170828212151.dawlnvvxhkkcmqo3@pd.tnic>
References: <20170823225447.15608-1-toshi.kani@hpe.com>
 <20170823225447.15608-2-toshi.kani@hpe.com>
 <20170824075348.gqvobmk7mf5ppaip@pd.tnic>
 <1587060.BVEodWPrhf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1587060.BVEodWPrhf@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Toshi Kani <toshi.kani@hpe.com>, mchehab@kernel.org, tony.luck@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 28, 2017 at 10:55:07PM +0200, Rafael J. Wysocki wrote:
> So what about the [3-5/5] in this series?
> 
> My current plan is to apply them too and expose a branch with them, can I
> go ahead with that?

No, please expose a branch with only the ACPI patches, i.e., 1 and 2 and
I can merge it and apply the EDAC patches ontop.

Then you and I need to sync up so that you send your pull requests first
and I follow you so that Linus applies them in the proper order.

Makes sense?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
