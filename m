From: "Tony Luck" <tony.luck@gmail.com>
Subject: Re: regression on HP zx1 platform from ACPI autoload modules patches
Date: Mon, 30 Jul 2007 22:12:51 -0700
Message-ID: <12c511ca0707302212o3702789bt8d597ec53a389e0a@mail.gmail.com>
References: <1185836238.31298.36.camel@deimos.americas.hpqcorp.net>
	 <6bffcb0e0707301607x5484f114q9117007d131f7118@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <6bffcb0e0707301607x5484f114q9117007d131f7118@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ia64-owner@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Doug Chapman <doug.chapman@hp.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org, trenn@suse.de
List-Id: linux-acpi@vger.kernel.org

> > During bootup it panics with:
> >
> > Kernel panic - not syncing: Unable to find SBA IOMMU: Try a generic or DIG kernel

I think that the fix for this has already gone into Linus's tree (on
Friday).  Commit SHA1
for the patch that should fix this is:
8c8eb78f673c07b60f31751e1e47ac367c60c6b7

If latest GIT tree still has this problem, then please let us know.

-Tony
