From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 15/16] ACPICA: _CST repair: Handle null package entries
Date: Tue, 18 Jun 2013 23:51:56 +0200
Message-ID: <1740311.uDCIxlT6hC@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE88016@ORSMSX103.amr.corp.intel.com> <51BF7230.4040805@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:41873 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756342Ab3FRVmh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Jun 2013 17:42:37 -0400
In-Reply-To: <51BF7230.4040805@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Monday, June 17, 2013 10:31:44 PM Rafael J. Wysocki wrote:
> On 6/17/2013 6:41 PM, Moore, Robert wrote:
> > This one is just adding additional checks on the _CST that are obvious errors in the AML. The eventual goal of the "repair" code in ACPICA is to never return a bad package from things like _CST. In other words, an AE_OK guarantees that the return value is usable.
> >
> > So, this is an additional implementation of this longer-range project.
> >
> 
> Thanks Bob!
> 
> Lv, care to add the above explanation from Bob to the changelog of the 
> $subject patch?

Well, I can add it too, I suppose.

Thanks,
Rafael


> >> -----Original Message-----
> >> From: lenb417@gmail.com [mailto:lenb417@gmail.com] On Behalf Of Len Brown
> >> Sent: Wednesday, June 12, 2013 11:00 AM
> >> To: Zheng, Lv
> >> Cc: Wysocki, Rafael J; Moore, Robert; Brown, Len; linux acpi
> >> Subject: Re: [PATCH 15/16] ACPICA: _CST repair: Handle null package
> >> entries
> >>
> >> On Fri, Jun 7, 2013 at 9:01 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> >>> Sort package only after null/bad elements have been removed.
> >>> Lv Zheng.
> >>
> >> again, please explain WHY.
> >>
> >> Every line of change to the kernel adds risk.
> >> I see no justification in this commit message why any risk should be added
> >> to the kernel.
> >>
> >> Nacked-by: Len Brown <len.brown@intel.com>
> 
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> z siedziba w Gdansku
> ul. Slowackiego 173
> 80-298 Gdansk
> 
> Sad Rejonowy Gdansk Polnoc w Gdansku, 
> VII Wydzial Gospodarczy Krajowego Rejestru Sadowego, 
> numer KRS 101882
> 
> NIP 957-07-52-316
> Kapital zakladowy 200.000 zl
> 
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
