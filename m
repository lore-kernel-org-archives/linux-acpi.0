From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 14/16] ACPICA: Add several repairs for _CST predefined name
Date: Tue, 18 Jun 2013 23:48:46 +0200
Message-ID: <4747911.BQxTeXVdnl@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <CAJvTdKk9i+qcmKhuoCzqoL_hDUgv8Y3qZrs=j=onUb46kZWZGQ@mail.gmail.com> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88565@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41860 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933061Ab3FRVj0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Jun 2013 17:39:26 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88565@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Tuesday, June 18, 2013 06:51:45 PM Moore, Robert wrote:
> Correct, additional _CST sanity checks and repairs.

OK, and what AML breakage does it help against, in particular?

Rafael


> > -----Original Message-----
> > From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> > Sent: Wednesday, June 12, 2013 10:59 AM
> > To: Zheng, Lv
> > Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> > Subject: Re: [PATCH 14/16] ACPICA: Add several repairs for _CST predefined
> > name
> > 
> > On Fri, Jun 7, 2013 at 9:01 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> > > Sort list based on the C-state, remove invalid/zero entries.
> > > ACPICA BZ 890. Lv Zheng.
> > 
> > The commit message should not just say what the code does, it should more
> > importantly answer WHY the change was made, and why anybody should care
> > about the patch.
> > 
> > I think the answer here is that we are adding _CST sanity checking --
> > presumably to deal with buggy AML?
> > 
> > What will we see happen after this patch that we did not see before it?
> > 
> > Nacked-by: Len Brown <len.brown@intel.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
