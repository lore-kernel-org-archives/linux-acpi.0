From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose
 embedded WMI MOF metadata
Date: Tue, 30 May 2017 09:46:27 -0700
Message-ID: <20170530164627.GB118811@localhost.localdomain>
References: <cover.1495862272.git.dvhart@infradead.org>
 <27758381c6cb77efab75a266e21243a964cce0ba.1495862272.git.dvhart@infradead.org>
 <201705271314.16241@pali>
 <CALCETrWgFqhYCVmr+rox5GuwAO8HzenjRt7MeKJbAmV3gJCmng@mail.gmail.com>
 <1496157894.28981.31.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:57859 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdE3Qqc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 May 2017 12:46:32 -0400
Content-Disposition: inline
In-Reply-To: <1496157894.28981.31.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Tue, May 30, 2017 at 06:24:54PM +0300, Andy Shevchenko wrote:
> On Sat, 2017-05-27 at 14:07 -0700, Andy Lutomirski wrote:
> > On Sat, May 27, 2017 at 4:14 AM, Pali Rohár <pali.rohar@gmail.com>
> > wrote:
> > > > Quite a few laptops (and maybe servers?) have embedded WMI MOF
> > > 
> > > Not "a few", but "lots of" :-)
> 
> Aren't they are synonyms ("quite a few" vs "lots of")?

The difference is subtle enough that people we can probably get several
different answers, but generally yes. I'm happy to update it in any case.

-- 
Darren Hart
VMware Open Source Technology Center
