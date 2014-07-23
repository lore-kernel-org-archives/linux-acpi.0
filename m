From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 6/7] ACPI: Add support to force header inclusion rules
 for <acpi/acpi.h>.
Date: Wed, 23 Jul 2014 11:53:00 +0800
Message-ID: <53CF319C.4070605@linaro.org>
References: <cover.1387336613.git.lv.zheng@intel.com> <cover.1405500886.git.lv.zheng@intel.com> <83e64d3b252019ce4b13fa46244a5c9a63bfc69f.1405500886.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:48015 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbaGWDyH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jul 2014 23:54:07 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so869313pab.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jul 2014 20:54:06 -0700 (PDT)
In-Reply-To: <83e64d3b252019ce4b13fa46244a5c9a63bfc69f.1405500886.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Lv,

On 2014-7-16 16:58, Lv Zheng wrote:
> As there is only CONFIG_ACPI=n processing in the <linux/acpi.h>, it is not
> safe to include <acpi/acpi.h> directly for source out of Linux ACPI
> subsystems.
> 
> This patch adds error messaging to warn developers of such wrong
> inclusions.

Thanks for doing this, it makes life much easier for people who want to
use ACPI but not so familiar with ACPI.

Best Regards
Hanjun

