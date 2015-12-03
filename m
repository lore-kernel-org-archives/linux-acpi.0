From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 4/7] ACPI / debugger: Add IO interface to access
 debugger functionalities
Date: Thu, 3 Dec 2015 14:27:41 -0800
Message-ID: <CALCETrUjb199X4cFkcr2upH1kTx1mrwxwzPPxZGCYkqpV-8GRQ@mail.gmail.com>
References: <cover.1446790780.git.lv.zheng@intel.com> <cover.1449108825.git.lv.zheng@intel.com>
 <38be30c67ffbea7618e65fbf1f62bf666a50e56c.1449108826.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34388 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbLCW2C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2015 17:28:02 -0500
Received: by igvg19 with SMTP id g19so23671037igv.1
        for <linux-acpi@vger.kernel.org>; Thu, 03 Dec 2015 14:28:01 -0800 (PST)
In-Reply-To: <38be30c67ffbea7618e65fbf1f62bf666a50e56c.1449108826.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Andy Lutomirski <luto@kernel.org>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Wed, Dec 2, 2015 at 6:43 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> This patch adds /sys/kernel/debug/acpi/acpidbg, which can be used by
> userspace programs to access ACPICA debugger functionalities.

What's this one generated against?  My Kconfig contains:

config ACPI_DEBUGGER
    bool "In-kernel debugger (EXPERIMENTAL)"
    select ACPI_DEBUG

which isn't quite the same as what you generated this against.  I'm
starting with 4.4-rc3.

--Andy
