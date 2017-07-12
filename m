From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI: EC: Drop EC noirq hooks to fix a regression
Date: Wed, 12 Jul 2017 23:17:53 +0200
Message-ID: <1959612.ejQZU5VTTY@aspire.rjw.lan>
References: <26498770711bbb36ca2888b33b56a0a56dc29083.1499828705.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60908 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754085AbdGLVZh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Jul 2017 17:25:37 -0400
In-Reply-To: <26498770711bbb36ca2888b33b56a0a56dc29083.1499828705.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Stable # all applicable <stable@vger.kernel.org>

On Wednesday, July 12, 2017 11:09:09 AM Lv Zheng wrote:
> According to the bug report, though the busy polling mode can make noirq
> stages executed faster, it causes abnormal fan blowing up after a system
> resume (see link #1 for a video demonstration) on Lenovo ThinkPad X1 Carbon
>  - the 5th Generation. The problem can be fixed by an upgraded EC firmware.
> 
> However many reporters can also confirm that the problem can be fixed by
> stopping busy polling during suspend/resume.
> 
> This patch drops noirq stage hooks so that the regression can be fixed
> without upgrading the EC firmware.
> 
> Fixes: c3a696b6e8f8 ("ACPI / EC: Use busy polling mode when GPE is not enabled")
> Link: https://youtu.be/9NQ9x-Jm99Q                       [#1]
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=196129
> Reported-by: Andreas Lindhe <andreas@lindhe.io>
> Tested-by: Gjorgji Jankovski <j.gjorgji@gmail.com>
> Tested-by: Damjan Georgievski <gdamjan@gmail.com>
> Tested-by: Fernando Chaves <nanochaves@gmail.com>
> Tested-by: Tomislav Ivek <tomislav.ivek@gmail.com>
> Tested-by: Denis P. <theoriginal.skullburner@gmail.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Stable <stable@vger.kernel.org> # all applicable

Both patches applied with some minor modifications in the changelogs.

Thanks,
Rafael

