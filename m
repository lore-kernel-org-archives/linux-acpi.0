From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] drivers/acpi: make evged.c explicitly non-modular
Date: Mon, 9 May 2016 15:59:29 -0400
Message-ID: <20160509195928.GB18139@windriver.com>
References: <1462819227-28297-1-git-send-email-paul.gortmaker@windriver.com>
 <5730E671.8070201@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5730E671.8070201@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

[Re: [PATCH] drivers/acpi: make evged.c explicitly non-modular] On 09/05/2016 (Mon 15:35) Sinan Kaya wrote:

> +Rafael,
> 
> On 5/9/2016 2:40 PM, Paul Gortmaker wrote:
> > The Makefile/Kconfig currently controlling compilation of this code is:
> > 
> > Makefile:acpi-$(CONFIG_ACPI_REDUCED_HARDWARE_ONLY) += evged.o
> > 
> > -
> > -module_platform_driver(ged_driver);
> > -MODULE_LICENSE("GPL v2");
> > +builtin_platform_driver(ged_driver);
> > 
> 
> Thanks, it looks good to me. I realized Rafael was missing in your post.
> I added him here.

Thanks for spotting that.  It looks like I fat fingered his "Cc:" line
into a "c:" at some point and I didn't notice his name was absent when
git gave me the summary of recipients before hitting send.  :-(

Would have been nice if git send-email had given me a warning, but I
guess there are so many different non-stanadard headers out there now,
it would be impossible to assume "c:" wasn't valid for someone....

P.
