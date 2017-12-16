From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI, APEI, Fix use resource_size
Date: Sat, 16 Dec 2017 16:54:12 +0100
Message-ID: <2204439.yeF237Ovv0@aspire.rjw.lan>
References: <1513007072-32020-1-git-send-email-gomonovych@gmail.com> <CAJZ5v0hA9QdAc1_Gwtu+hBGiH8nn84TS0Bwx0Ln4by6UpKDpSg@mail.gmail.com> <20171216115615.j5uncek3iiigwkl7@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43503 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752746AbdLPPzA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Dec 2017 10:55:00 -0500
In-Reply-To: <20171216115615.j5uncek3iiigwkl7@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Vasyl Gomonovych <gomonovych@gmail.com>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Saturday, December 16, 2017 12:56:15 PM CET Borislav Petkov wrote:
> On Sat, Dec 16, 2017 at 11:43:27AM +0100, Rafael J. Wysocki wrote:
> > The argument of resource_size() is (const struct resource *) and res
> > is of type (struct apei_res *).
> > 
> > I'm dropping this one.
> 
> Yeah, us reviewing this one was one big FAIL.

I don't know.

We didn't catch this issue, but that's what 0-day is for, isn't it? :-)

IMO it is not generally wrong to assume certain level of due diligence
on the part of submitters and that assumption is actually met most of the
time from my experience.

It sometimes isn't, but then the submitter lands in my "suspicious" list
and subsequent patches coming from them are subject to special treatment.

Which basically boils down to "Don't do that".

> And I tell myself everytime - build those patches first! Srsly! People
> really don't even build-test their shit before submitting. Because look
> at the compiler output - it is everything but quiet. Crap didn't even
> build.

Right, but at least we know that the current code isn't correct.

Thanks,
Rafael

