From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] ACPI: EC: Change EC noirq tuning to be an optional behavior
Date: Wed, 28 Jun 2017 23:31:16 +0200
Message-ID: <1792284.us4mECpxNF@aspire.rjw.lan>
References: <d8ac96c8fd988daec20f7a22a2acb3119ccd149b.1497418749.git.lv.zheng@intel.com> <157972fa5572b0f0c157142ea151b8508e7640b4.1497418749.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45949 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751541AbdF1Vio (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Jun 2017 17:38:44 -0400
In-Reply-To: <157972fa5572b0f0c157142ea151b8508e7640b4.1497418749.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, June 14, 2017 01:59:24 PM Lv Zheng wrote:
> According to the bug report, though the busy polling mode can make noirq
> stages executed faster, it causes abnormal fan blowing in noirq stages.
> 
> This patch prepares an option so that the automatic busy polling mode
> switching for noirq stages can be enabled by who wants to tune it, not all
> users.
> Noticed that the new global option cannot be changed during noirq stages.
> There is no need to lock its value changes to sync with polling mode
> settings switches.
> 
> For reporters and testers in the thread, as there are too many reporters
> on the bug link, this patch only picks names from most active commenters.
> Sorry for the neglet.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=191181
> Reported-by: Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
> Reported-by: Claudio Sacerdoti Coen <claudio.sacerdoticoen@unibo.it>
> Tested-by: Nicolo' <nicolopiazzalunga@gmail.com>
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Tested-by: Gjorgji Jankovski <j.gjorgji@gmail.com>
> Tested-by: Damjan Georgievski <gdamjan@gmail.com>
> Tested-by: Fernando Chaves <nanochaves@gmail.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

First of all, this seems to be a fix for commit c3a696b6e8f8 (ACPI / EC: Use busy polling
mode when GPE is not enabled), so there should be a Fixes: tag pointing to that
one.

Moreover, if that is just a performance optimization and not a matter of correctness,
why don't we simply drop acpi_ec_enter/leave_noirq() entirely?

What is going to break if we do that?

Thanks,
Rafael

