From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: Re: [BUG] acpica: ltp_acpi test case causes kernel crash at
 acpi_ns_walk_namespace
Date: Thu, 14 Dec 2017 01:34:35 -0800
Message-ID: <20171214093435.GA10734@localhost.localdomain>
References: <1513094360-1414-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <9523980.S2jPabPoO5@aspire.rjw.lan>
 <20171213145547.GB6692@localhost.localdomain>
 <CAJZ5v0iKWMBZXqGcpJqhdLLqPTY02yQOFJtn8zuCvsXd902nYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:44983
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750808AbdLNJel (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Dec 2017 04:34:41 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iKWMBZXqGcpJqhdLLqPTY02yQOFJtn8zuCvsXd902nYQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Lv <lv.zheng@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, vadim.lomovtsev@cavium.com

On Wed, Dec 13, 2017 at 05:52:38PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2017 at 3:55 PM, Vadim Lomovtsev
> <Vadim.Lomovtsev@caviumnetworks.com> wrote:
> > On Wed, Dec 13, 2017 at 12:45:50AM +0100, Rafael J. Wysocki wrote:
> >> On Tuesday, December 12, 2017 4:59:19 PM CET Vadim Lomovtsev wrote:
> >> > Hi guys,
> >> >
> >> > While running LTP tests I've faced kernel crash caused by ltp_acpi test case.
> >> > I have ACPI support enabled in kernel but kernel is boot with FDT having ACPI
> >> > disabled. The ltp_acpi test case application is built along with ltp_acpi_cmds
> >> > module to run ACPI tests.
> >> >
> >> > So my question is - should we update acpica implementation at kernel side by
> >> > adding 'acpi_disabled' variable checking to the 'acpi_get_devices' function (see
> >> > patch next to this email, maybe not a good approach) or this should be fixed at LTP
> >> > side so the ltp_acpi_cmds should be updated in order to check if acpi is enabled
> >> > before running tests ?
> >>
> >> There should be a check preventing acpi_get_devices() from being called in the
> >> acpi_disabled case.
> >
> > In my case I have to update ltp_acpi code then.
> 
> RIght.
> 
> >>
> >> acpi_disabled is Linux-specific and the ACPICA code isn't, so the code calling
> >> ACPICA functions should check acpi_disabled when necessary.
> >
> > Agree. However getting back to LTP tests it looks like such calls were implemented
> > intentionally without checking of aspi_disabled value.
> >
> > Don't we have any self-testing stuff in acpica to prevent such scenarious ?
> 
> ACPICA doesn't know anything about acpi_disabled as I said already.

And I got it from the first time. And assuming that I said that suggested patch
'maybe not a good approach' in the issue description. Just wanted to
highlight the issue and initiate discussion.

> 
> I would argue that testing unsupported use cases in LTP is not very useful.
>

The ltp_acpi test in particular shows that there is no any protection from such actions
so I wouldn't said that it is useless use case. From another hand, those calls were intialted
from kernel module (which is part of test case) so the solution here is to place ACPI
state check there - into kernel module.

But again, see your point. Thank you for your time.

> Thanks,
> Rafael

WBR,
Vadim
