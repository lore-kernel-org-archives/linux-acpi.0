From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] tools/power/acpi/tools/acpidbg: Add multi-commands support in batch mode
Date: Thu, 21 Jul 2016 15:45:14 +0200
Message-ID: <1843492.Yub8jGoblF@vostro.rjw.lan>
References: <cover.1468464391.git.lv.zheng@intel.com> <804f8558b9e65d6022cdb982e1772194ba52d292.1469002094.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63863 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750728AbcGUNkU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Jul 2016 09:40:20 -0400
In-Reply-To: <804f8558b9e65d6022cdb982e1772194ba52d292.1469002094.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, July 20, 2016 04:12:08 PM Lv Zheng wrote:
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
> multiple single-stepping mode commands in the batch mode.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

Does this depend on the kernel flushing support series?

Thanks,
Rafael

