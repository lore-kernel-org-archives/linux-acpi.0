From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 13/16] ACPICA: Move _PRT repair into the standard complex repair module
Date: Tue, 18 Jun 2013 23:49:21 +0200
Message-ID: <32658874.38eDoNxZF3@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <CAJvTdKnYif42oaWnP4MBQbi6XYg3AchJnxZPrTr1XPct=uS+6g@mail.gmail.com> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88551@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41865 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933236Ab3FRVkB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Jun 2013 17:40:01 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88551@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Tuesday, June 18, 2013 06:51:10 PM Moore, Robert wrote:
> No functional change. This change simply moves the repair code from where it
> was originally implemented to the (more recent) repair module where it now belongs.

OK, I'll apply this one with a fixed-up changelog.

Thanks,
Rafael


> > -----Original Message-----
> > From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> > Sent: Wednesday, June 12, 2013 10:52 AM
> > To: Zheng, Lv
> > Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> > Subject: Re: [PATCH 13/16] ACPICA: Move _PRT repair into the standard
> > complex repair module
> > 
> > Please re-send this patch with a commit message that clarifies whether any
> > logical change in operation should result from this patch or not.
> > 
> > It looks like the answer is no, that this a clean-up of the implementation
> > of a AML workaround -- but I shouldn't have to read the code to figure
> > that out, and neither should anybody else.
> > 
> > Nacked-by: Len Brown <len.brown@intel.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
