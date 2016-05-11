From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] drivers/acpi: make evged.c explicitly non-modular
Date: Wed, 11 May 2016 02:11:31 +0200
Message-ID: <4257824.pGqX1khh3q@vostro.rjw.lan>
References: <1462819227-28297-1-git-send-email-paul.gortmaker@windriver.com> <5730E671.8070201@codeaurora.org> <20160509195928.GB18139@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50007 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752303AbcEKAIL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 May 2016 20:08:11 -0400
In-Reply-To: <20160509195928.GB18139@windriver.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Monday, May 09, 2016 03:59:29 PM Paul Gortmaker wrote:
> [Re: [PATCH] drivers/acpi: make evged.c explicitly non-modular] On 09/05/2016 (Mon 15:35) Sinan Kaya wrote:
> 
> > +Rafael,
> > 
> > On 5/9/2016 2:40 PM, Paul Gortmaker wrote:
> > > The Makefile/Kconfig currently controlling compilation of this code is:
> > > 
> > > Makefile:acpi-$(CONFIG_ACPI_REDUCED_HARDWARE_ONLY) += evged.o
> > > 
> > > -
> > > -module_platform_driver(ged_driver);
> > > -MODULE_LICENSE("GPL v2");
> > > +builtin_platform_driver(ged_driver);
> > > 
> > 
> > Thanks, it looks good to me. I realized Rafael was missing in your post.
> > I added him here.
> 
> Thanks for spotting that.  It looks like I fat fingered his "Cc:" line
> into a "c:" at some point and I didn't notice his name was absent when
> git gave me the summary of recipients before hitting send.  :-(
> 
> Would have been nice if git send-email had given me a warning, but I
> guess there are so many different non-stanadard headers out there now,
> it would be impossible to assume "c:" wasn't valid for someone....

No worries.

If it goes to linux-acpi@vger.kernel.org, I can find it.

Patch applied, thanks!

