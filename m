From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI / APEI: Fix NMI notification handling
Date: Fri, 02 Dec 2016 00:12:18 +0100
Message-ID: <5033158.rooYzydQzm@aspire.rjw.lan>
References: <20161129193624.krjz2bpinl2ioi7o@pd.tnic> <10086382.uM7IovncFW@aspire.rjw.lan> <20161201224717.4tkp5glpib5fhusv@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59824 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751227AbcLAXPy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Dec 2016 18:15:54 -0500
In-Reply-To: <20161201224717.4tkp5glpib5fhusv@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@kernel.org>, Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Tyler Baicar <tbaicar@codeaurora.org>, Punit Agrawal <punit.agrawal@arm.com>, Don Zickus <dzickus@redhat.com>, Linux ACPI <linux-acpi@vger.kernel.org>

On Thursday, December 01, 2016 11:47:17 PM Borislav Petkov wrote:
> On Thu, Dec 01, 2016 at 11:29:45PM +0100, Rafael J. Wysocki wrote:
> > Well, there's another ARM-related patch touching APEI.
> > 
> > I guess whoever takes this one should also take the other one and
> > honestly they can go in via any tree as far as I'm concerned, I'm just trying to
> > avoid merge clashes here. :-)
> 
> Maybe have ARM-folk ACK the other one and take both through your ACPI
> tree? They both do have ACPI in common :-)

That one have been ACKed already.

OK, I'll take them both.

Thanks,
Rafael

