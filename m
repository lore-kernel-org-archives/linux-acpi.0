From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 15/16] ACPICA: _CST repair: Handle null package entries
Date: Tue, 18 Jun 2013 23:50:06 +0200
Message-ID: <2701902.tBNGLava1W@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <CAJvTdKm06aCeLvV28=TSrv5wqoapUY0vh2=ppY5p5pFW0pUKFw@mail.gmail.com> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE8856C@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41870 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756342Ab3FRVkq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Jun 2013 17:40:46 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE8856C@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Tuesday, June 18, 2013 06:52:12 PM Moore, Robert wrote:
> This change fixes a bug in the original _CST repair code.

Well, in that case the changelog should explain what the bug is/was.

Thanks,
Rafael


> > -----Original Message-----
> > From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> > Sent: Wednesday, June 12, 2013 11:00 AM
> > To: Zheng, Lv
> > Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> > Subject: Re: [PATCH 15/16] ACPICA: _CST repair: Handle null package
> > entries
> > 
> > On Fri, Jun 7, 2013 at 9:01 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> > > Sort package only after null/bad elements have been removed.
> > > Lv Zheng.
> > 
> > 
> > again, please explain WHY.
> > 
> > Every line of change to the kernel adds risk.
> > I see no justification in this commit message why any risk should be added
> > to the kernel.
> > 
> > Nacked-by: Len Brown <len.brown@intel.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
