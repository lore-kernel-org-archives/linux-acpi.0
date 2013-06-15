From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 07/16] ACPICA: New: Portable acpidump utility (get system ACPI tables)
Date: Sun, 16 Jun 2013 01:09:30 +0200
Message-ID: <4049831.iLWisgAOin@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <de987440373d946b6c672cd796aedc93f9390059.1369274559.git.lv.zheng@intel.com> <CAJvTdKkx6hfT8M3SOoMYmrwcC0ODGkGYvVaynS6KNXKPoKJFEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38751 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754681Ab3FOXAN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 15 Jun 2013 19:00:13 -0400
In-Reply-To: <CAJvTdKkx6hfT8M3SOoMYmrwcC0ODGkGYvVaynS6KNXKPoKJFEg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Wednesday, June 12, 2013 01:07:50 PM Len Brown wrote:
> > This utility dumps the system ACPI tables in an ascii format
> > suitable for extraction via the acpixtract utility.
> 
> This commit message does not match the contents of the patch,
> or explain how this patch is related (or not) to the acpidump utility
> already in the kernel tree under
> tools/power/acpi/acpidump/
> 
> Naked-by: Len Brown <len.brown@intel.com>

Well, I was on the verge of dropping this one before, so dropped now.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
