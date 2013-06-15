From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 13/16] ACPICA: Move _PRT repair into the standard complex repair module
Date: Sun, 16 Jun 2013 01:17:14 +0200
Message-ID: <2873439.oGpl4Wzcqe@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <f2c59ef61be4cf02903c633ad38592121db86419.1369274559.git.lv.zheng@intel.com> <CAJvTdKnYif42oaWnP4MBQbi6XYg3AchJnxZPrTr1XPct=uS+6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38759 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698Ab3FOXH5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Jun 2013 19:07:57 -0400
In-Reply-To: <CAJvTdKnYif42oaWnP4MBQbi6XYg3AchJnxZPrTr1XPct=uS+6g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Wednesday, June 12, 2013 01:52:17 PM Len Brown wrote:
> Please re-send this patch with a commit message that clarifies
> whether any logical change in operation should result from this patch or not.
> 
> It looks like the answer is no, that this a clean-up of the implementation
> of a AML workaround -- but I shouldn't have to read the code to figure that out,
> and neither should anybody else.
> 
> Nacked-by: Len Brown <len.brown@intel.com>

Dropped for now, Lv please resend this one.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
