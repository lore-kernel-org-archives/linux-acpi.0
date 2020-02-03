Return-Path: <SRS0=KFxj=3X=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33AEC3524D
	for <linux-acpi@archiver.kernel.org>; Mon,  3 Feb 2020 09:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16242070A
	for <linux-acpi@archiver.kernel.org>; Mon,  3 Feb 2020 09:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgBCJAG (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:00:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:8009 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbgBCJAG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 Feb 2020 04:00:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 01:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,397,1574150400"; 
   d="scan'208";a="234560355"
Received: from unknown (HELO [10.237.72.55]) ([10.237.72.55])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2020 01:00:02 -0800
Subject: Re: [PATCH v2 1/2] ACPI / APD: Add clock frequency for Hisilicon
 Hip08-Lite I2C controller
To:     Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linuxarm@huawei.com, Sheng Feng <fengsheng5@huawei.com>
References: <1580693767-5185-1-git-send-email-guohanjun@huawei.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <b4f8eab1-a540-7011-4433-6a8133594ddf@linux.intel.com>
Date:   Mon, 3 Feb 2020 11:00:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1580693767-5185-1-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2/3/20 3:36 AM, Hanjun Guo wrote:
> I2C clock frequency of Designware ip for Hisilicon Hip08 Lite
> is 125M, use a new ACPI HID to enable it.
> 
> Tested-by: Sheng Feng <fengsheng5@huawei.com>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
> 
> v2:
>   - Reverse the order of the two patches suggested by Andy;
> 
>   drivers/acpi/acpi_apd.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
