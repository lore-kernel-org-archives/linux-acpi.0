From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 06/16] ACPICA: Do not use extended sleep registers unless HW-reduced bit is set
Date: Sun, 16 Jun 2013 01:08:21 +0200
Message-ID: <1967178.AXdQBGsFrb@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <bc6233f5a24ca6175c1b3414c9662d6b4f63db25.1369274559.git.lv.zheng@intel.com> <CAJvTdKm3VUbW89sO9qSmJBj-XcZa2=UHjm6TsH83KXH2Z-AAeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38747 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754666Ab3FOW7F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Jun 2013 18:59:05 -0400
In-Reply-To: <CAJvTdKm3VUbW89sO9qSmJBj-XcZa2=UHjm6TsH83KXH2Z-AAeg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Wednesday, June 12, 2013 01:11:42 PM Len Brown wrote:
> This commit message should state when this regression started in Linux,
> so that people reading the messages know how far back to port the fix.

Yes, that would be nice.

That said, I was able to track it down to the 3.4 time frame ->

> Likely this patch should also be marked for -stable

-> so I marked it for "3.4+-stable" in the commit message.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
