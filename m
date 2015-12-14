From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 7/7] ACPI / x86: introduce acpi_os_readable() support
Date: Tue, 15 Dec 2015 00:43:38 +0100
Message-ID: <2219149.L6btt78o4y@vostro.rjw.lan>
References: <cover.1446790780.git.lv.zheng@intel.com> <cover.1449108825.git.lv.zheng@intel.com> <af8b1799e7eec686fbb3bf239f6f400adb3b8082.1449108826.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56195 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753404AbbLNXNc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Dec 2015 18:13:32 -0500
In-Reply-To: <af8b1799e7eec686fbb3bf239f6f400adb3b8082.1449108826.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Andy Lutomirski <luto@kernel.org>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

On Thursday, December 03, 2015 10:43:21 AM Lv Zheng wrote:
> From: Chen Yu <yu.c.chen@intel.com>
> 
> This patch implements acpi_os_readable(). The function is used by ACPICA
> AML debugger to validate user specified pointers for dumping the memory as
> ACPICA descriptor objects.
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

This has to be resent with CCs to the x86 maintainers.

Thanks,
Rafael

