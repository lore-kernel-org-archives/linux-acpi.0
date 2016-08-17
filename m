From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 3/3] tools/power/acpi/acpidbg: Add multi-commands support in batch mode
Date: Wed, 17 Aug 2016 02:30:50 +0200
Message-ID: <3470775.ryIxlEgpGv@vostro.rjw.lan>
References: <cover.1468464391.git.lv.zheng@intel.com> <cover.1469528979.git.lv.zheng@intel.com> <3492bf600484b4d625be1407013eef0062e6246a.1469528980.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55489 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752152AbcHQAZU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Aug 2016 20:25:20 -0400
In-Reply-To: <3492bf600484b4d625be1407013eef0062e6246a.1469528980.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, July 26, 2016 07:01:45 PM Lv Zheng wrote:
> This patch adds multi-commands support for the batch mode. The same mode
> can be seen in acpiexec.
> 
> However people may think this is not useful for an in-kernel debugger,
> because the in-kernel debugger is always running, never exits. So we can
> run another command by running another acpidbg batch mode instance.
> 
> But this mode should still be useful for acpidbg. The reason is: when the
> in-kernel debugger has entered the single-stepping mode, ending acpidbg
> (which closes the debugger IO interface) will lead to the end of the
> single-stepping mode.
> 
> So we need the acpidbg multi-commands batch mode in order to execute
> multiple single-stepping mode commands in scripts.

An example would be really useful here IMO.

Thanks,
Rafael

