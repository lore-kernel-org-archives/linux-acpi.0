From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Regression between rc2 and rc6: ACPI EC problems
Date: Thu, 07 Jul 2016 02:36:23 +0200
Message-ID: <6839089.st9D67iqtO@vostro.rjw.lan>
References: <20160706141410.GA1430@tetsubishi> <2028379.c7e6Pd4oDW@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E883BC007B3@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45468 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756006AbcGGAbr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2016 20:31:47 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BC007B3@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thursday, July 07, 2016 12:26:49 AM Zheng, Lv wrote:
> Hi, Rafael
> 
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Thursday, July 7, 2016 5:29 AM
> > Subject: Re: Regression between rc2 and rc6: ACPI EC problems
> > 
> > On Wednesday, July 06, 2016 11:14:11 PM Wolfram Sang wrote:
> > > Hi,
> > >
> > > when upgrading from v4.7-rc2 to rc6 on my Dell Mini 9, battery and
> > > temperature status info got bogus. Here is the major change between
> > the
> > > boot logs:
> > >
> > > ACPI : EC: EC stopped
> > > ACPI Exception: AE_BAD_PARAMETER, Returned by Handler for
> > [EmbeddedControl] (20160422/evregion-300)
> > > ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.EC0._REG]
> > (Node f5d09870), AE_BAD_PARAMETER (20160422/psparse-542)
> > > ACPI Exception: AE_BAD_PARAMETER, from region _REG,
> > [EmbeddedControl] (20160422/evregion-397)
> > > ACPI Exception: AE_BAD_PARAMETER, Returned by Handler for
> > [EmbeddedControl] (20160422/evregion-300)
> > > ACPI Error: Method parse/execution failed [\_SB.PCI0.LPCB.EC0._REG]
> > (Node f5d09870), AE_BAD_PARAMETER (20160422/psparse-542)
> > > ACPI Exception: AE_BAD_PARAMETER, from region _REG,
> > [EmbeddedControl] (20160422/evregion-397)
> > > ACPI : EC: GPE = 0x19, I/O: command/status = 0x66, data = 0x62
> > > ACPI : EC: EC started
> [Lv Zheng] 
> This is a known order issue that ACPICA executes _REG(DISCONENCT) after removing the opregion handler.
> But this issue is not a function failure, it only generates error garbage in the kernel log.
> So we didn't fix it in a hurry.
> 
> There is another order issue detected in the same Bugzilla entry that:
> _REG(CONNECT/DISCONNECT) shouldn't be invoked for SystemMemory/SystemIo and PCI_Config that under a PCI root bus containing _BBN method.
> Which is also proven by the Windows behavior and spec definitions.
> 
> I was planning to fix the both issues in the ACPICA upstream.
> The bug is here for your reference:
> https://bugzilla.kernel.org/show_bug.cgi?id=102421
> 
> For now, since this is just a non-function-failure error report, we can ignore it.
> Because sometimes, when there are several problems related, we have to make a choice to fix one of them first.

Well, please look at the report again.  It says:

"when upgrading from v4.7-rc2 to rc6 on my Dell Mini 9, battery and
temperature status info got bogus".

So, it very much *is* a functional issue and I'm not going to ignore it.

Thanks,
Rafael

