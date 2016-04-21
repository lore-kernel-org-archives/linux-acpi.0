From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] tools/power/acpi: close file only if it is open
Date: Thu, 21 Apr 2016 02:19:53 +0200
Message-ID: <23224433.esXf81m7aH@vostro.rjw.lan>
References: <1458795688-2147-1-git-send-email-lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59710 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751609AbcDUARC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Apr 2016 20:17:02 -0400
In-Reply-To: <1458795688-2147-1-git-send-email-lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Thursday, March 24, 2016 01:01:28 PM Lv Zheng wrote:
> The logic on the test for a valid fd to close is incorrect.
> This was just a mistake and was pointed out by Colin Ian King.
> 
> Link: https://patchwork.kernel.org/patch/8620201/
> Original-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

Applied, thanks!

