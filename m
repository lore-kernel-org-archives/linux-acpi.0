From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 4/7] ACPI / debugger: Add IO interface to access debugger functionalities
Date: Fri, 04 Dec 2015 00:34:10 +0100
Message-ID: <14360198.FgS2FrizGL@vostro.rjw.lan>
References: <cover.1446790780.git.lv.zheng@intel.com> <38be30c67ffbea7618e65fbf1f62bf666a50e56c.1449108826.git.lv.zheng@intel.com> <CALCETrUjb199X4cFkcr2upH1kTx1mrwxwzPPxZGCYkqpV-8GRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52531 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751448AbbLCXES (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2015 18:04:18 -0500
In-Reply-To: <CALCETrUjb199X4cFkcr2upH1kTx1mrwxwzPPxZGCYkqpV-8GRQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Andy Lutomirski <luto@kernel.org>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Thursday, December 03, 2015 02:27:41 PM Andy Lutomirski wrote:
> On Wed, Dec 2, 2015 at 6:43 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> > This patch adds /sys/kernel/debug/acpi/acpidbg, which can be used by
> > userspace programs to access ACPICA debugger functionalities.
> 
> What's this one generated against?  My Kconfig contains:
> 
> config ACPI_DEBUGGER
>     bool "In-kernel debugger (EXPERIMENTAL)"
>     select ACPI_DEBUG
> 
> which isn't quite the same as what you generated this against.  I'm
> starting with 4.4-rc3.

Probably on top of linux-next (or my linux-next branch).

There's a fix commit against Kconfig in my tree which is going to be pushed
for 4.4-rc4 tomorrow.

Thanks,
Rafael

