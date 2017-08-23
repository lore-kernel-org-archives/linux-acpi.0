From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v3 1/4] ACPI / EC: Cleanup EC GPE mask flag
Date: Wed, 23 Aug 2017 04:19:02 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF0FD64@SHSMSX101.ccr.corp.intel.com>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com>
 <cover.1502432974.git.lv.zheng@intel.com>
 <00b4445d67d2e56fef8c319c2651f655d7e6d8e9.1502432974.git.lv.zheng@intel.com>
 <4438656.LA1ApnlN3k@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60938 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbdHWETH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Aug 2017 00:19:07 -0400
In-Reply-To: <4438656.LA1ApnlN3k@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Subject: Re: [PATCH v3 1/4] ACPI / EC: Cleanup EC GPE mask flag
> 
> On Friday, August 11, 2017 8:36:28 AM CEST Lv Zheng wrote:
> > EC_FLAGS_COMMAND_STORM is actually used to mask GPE during IRQ processing.
> > This patch cleans it up using more readable flag/function names.
> >
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > Tested-by: Tomislav Ivek <tomislav.ivek@gmail.com>
> 
> Applied, thanks!

Thanks!

> 
> I'm not sure about the rest of the series, though, but let me comment on the
> specific patches.

Though it is a long bug fix story, it's actually simple and can be summarized with 1 line:
The patchset polls EC IRQs during noirq stage to fix EC event handling issues.

I've submitted this solution several years ago using an IRQ polling kernel thread.
You commented me to use a timer instead, here you are.

During these years, I tried different solutions than the "polling IRQ in noirq stage".
But they didn't work perfectly.
The noirq stage makes the EC event handling issue fixes mutual exclusive.
Fixing one issue can trigger regression for the other.
And bug reports prove that we must handle EC events during noirq stage.

So finally I picked the IRQ polling solution back, and refreshed it to follow your comment (using a timer instead of a kthread).

If you apply this patch and enable EC debugging log with "dyndbg='file ec.c +p'".
You should be able to see some event handling logs in noirq stages.
Without this solution applied, EC event handling log is silent during noirq stages.
That could be the only difference.

Thanks and best regards
Lv
