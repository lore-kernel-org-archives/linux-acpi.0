From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI / APEI: Fix NMI notification handling
Date: Thu, 01 Dec 2016 23:29:45 +0100
Message-ID: <10086382.uM7IovncFW@aspire.rjw.lan>
References: <20161129193624.krjz2bpinl2ioi7o@pd.tnic> <3848089.cIkXoRipBG@aspire.rjw.lan> <20161201215149.fvb3ki77det7bnjq@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51666 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752680AbcLAWeM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Dec 2016 17:34:12 -0500
In-Reply-To: <20161201215149.fvb3ki77det7bnjq@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@kernel.org>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Tyler Baicar <tbaicar@codeaurora.org>, Punit Agrawal <punit.agrawal@arm.com>, Don Zickus <dzickus@redhat.com>, Linux ACPI <linux-acpi@vger.kernel.org>

On Thursday, December 01, 2016 10:51:49 PM Borislav Petkov wrote:
> On Thu, Dec 01, 2016 at 10:17:54PM +0100, Rafael J. Wysocki wrote:
> > I guess I should pick up this one, then?
> 
> If you already have stuff touching this area, it probably would be more
> prudent if you took it. If not, I can take it through tip's ras branch,
> if you prefer.

Well, there's another ARM-related patch touching APEI.

I guess whoever takes this one should also take the other one and
honestly they can go in via any tree as far as I'm concerned, I'm just trying to
avoid merge clashes here. :-)

Thanks,
Rafael

