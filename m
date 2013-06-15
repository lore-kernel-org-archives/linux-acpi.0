From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 15/16] ACPICA: _CST repair: Handle null package entries
Date: Sun, 16 Jun 2013 01:18:10 +0200
Message-ID: <3444830.RFzkpWTp5C@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <f941986213920b382a8f43af43caec298cd16a5a.1369274559.git.lv.zheng@intel.com> <CAJvTdKm06aCeLvV28=TSrv5wqoapUY0vh2=ppY5p5pFW0pUKFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38764 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698Ab3FOXIx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Jun 2013 19:08:53 -0400
In-Reply-To: <CAJvTdKm06aCeLvV28=TSrv5wqoapUY0vh2=ppY5p5pFW0pUKFw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Wednesday, June 12, 2013 02:00:14 PM Len Brown wrote:
> On Fri, Jun 7, 2013 at 9:01 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> > Sort package only after null/bad elements have been removed.
> > Lv Zheng.
> 
> 
> again, please explain WHY.
> 
> Every line of change to the kernel adds risk.
> I see no justification in this commit message why any risk should be
> added to the kernel.
> 
> Nacked-by: Len Brown <len.brown@intel.com>

Dropped for now, Lv please resend this one.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
