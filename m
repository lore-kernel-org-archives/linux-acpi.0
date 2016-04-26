From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/4] ACPI / osi: Change default _OSI(Darwin) support
Date: Tue, 26 Apr 2016 22:13:27 +0200
Message-ID: <CAJZ5v0gOY==-PUNcp-5rsp1mrD=V215rUAWmx6LFM7+CgF=8dA@mail.gmail.com>
References: <cover.1461656216.git.lv.zheng@intel.com>
	<721499bcaa3559f71023c6ab960481564f58f22a.1461656216.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36544 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbcDZUN3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Apr 2016 16:13:29 -0400
In-Reply-To: <721499bcaa3559f71023c6ab960481564f58f22a.1461656216.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Chen Yu <yu.c.chen@intel.com>

On Tue, Apr 26, 2016 at 9:40 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> From: Chen Yu <yu.c.chen@intel.com>
>
> Commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly") always
> reports positive value when Apple hardware queries _OSI("Darwin"). However
> since this implementation places the judgement in runtime, it breaks
> acpi_osi=!Darwin and cannot return unsupported for _OSI("WinXXX") invoked
> before invoking _OSI("Darwin").
>
> This patch fixes the issues by reverting the wrong support and implementing
> the default behavior of _OSI("Darwin")/_OSI("WinXXX") on Apple hardware via
> DMI matching.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=92111
> Reported-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

Why don't you add a Fixes tag pointing to the problematic commit?
