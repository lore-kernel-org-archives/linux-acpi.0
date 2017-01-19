From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v13 0/7] Enable PMUs in ACPI systems
Date: Thu, 19 Jan 2017 11:57:04 +0800
Message-ID: <1b75c424-dfe3-6382-a38a-d784ab495b43@linaro.org>
References: <1484686210-7211-1-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33676 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbdASD5J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jan 2017 22:57:09 -0500
Received: by mail-pg0-f45.google.com with SMTP id 204so10230236pge.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2017 19:57:09 -0800 (PST)
In-Reply-To: <1484686210-7211-1-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, steve.capper@arm.com, mlangsdorf@redhat.com, punit.agrawal@arm.com, will.deacon@arm.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, msalter@redhat.com, bamvor.zhangjian@linaro.org

On 2017/1/18 4:50, Jeremy Linton wrote:
> This patch expands and reworks the patches published by Mark Salter
> in order to clean up a few of the previous review comments, as well as
> add support for newer CPUs and big/little configurations.
>
> v13:
> - Correct int/bool conversion bug in pmu_acpi_init()

I tested this patch set on Hisilicon D03 and using "perf list"
then I can get hardware event which it's not available before
adding this patch set, and "perf stat -e <event>" works fine
with available perf event.

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
