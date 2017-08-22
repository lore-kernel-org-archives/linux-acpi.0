From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/4] ACPI / EC: Cleanup EC GPE mask flag
Date: Tue, 22 Aug 2017 15:17:20 +0200
Message-ID: <4438656.LA1ApnlN3k@aspire.rjw.lan>
References: <99f23db65bbe89ee856018629654584a96734c84.1501141963.git.lv.zheng@intel.com> <cover.1502432974.git.lv.zheng@intel.com> <00b4445d67d2e56fef8c319c2651f655d7e6d8e9.1502432974.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48335 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932791AbdHVNZw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Aug 2017 09:25:52 -0400
In-Reply-To: <00b4445d67d2e56fef8c319c2651f655d7e6d8e9.1502432974.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Friday, August 11, 2017 8:36:28 AM CEST Lv Zheng wrote:
> EC_FLAGS_COMMAND_STORM is actually used to mask GPE during IRQ processing.
> This patch cleans it up using more readable flag/function names.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Tested-by: Tomislav Ivek <tomislav.ivek@gmail.com>

Applied, thanks!

I'm not sure about the rest of the series, though, but let me comment on the
specific patches.

Thanks,
Rafael

