From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 00/16] ACPICA: 20130517 release
Date: Tue, 18 Jun 2013 23:04:25 +0200
Message-ID: <2920193.Fi63sGCWjD@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <1585522.1qyMjQu16g@vostro.rjw.lan> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE885A7@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41784 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756282Ab3FRUzJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Jun 2013 16:55:09 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE885A7@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Tuesday, June 18, 2013 06:55:33 PM Moore, Robert wrote:
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> > Sent: Saturday, June 15, 2013 4:25 PM
> > To: Zheng, Lv
> > Cc: Len Brown; Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> > Subject: Re: [PATCH 00/16] ACPICA: 20130517 release
> > 
> > On Wednesday, June 12, 2013 02:04:46 PM Len Brown wrote:
> > > I would like to see this series re-freshed before it goes up-stream.
> > > Generally, the commit messages need to be improved before they go into
> > > the permanent kernel history.
> > 
> > Lv,
> > 
> > I've dropped [7/16] 
> 
> Again, this is a new version of acpidump and should replace the existing utility.

OK, and how does the patch actually work?  That is, what is a user supposed to
do to build the generic acpidump with the patch applied?

> and [12/16] permanently (please do not resend them).
> 
> 
> This is the makefile change for apple, yes? Depends on how you want to handle
> such things. If you don't accept these kinds of changes, it introduces
> divergence from the ACPICA code.

Yes, it does, but on the other hand that change is not necessary in the kernel
source.

This is a policy issue and we don't seem to have a clear policy here: whether
or not divergences related to things that don't have to be in the kernel need
to be "fixed".  I don't think that they do and Len seems to agree with me.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
