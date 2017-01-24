From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v14 0/6] Enable PMUs in ACPI systems
Date: Tue, 24 Jan 2017 15:49:57 +0800
Message-ID: <cea38f4f-4696-baab-b539-f9d0a8db3f42@linaro.org>
References: <1485210765-9422-1-git-send-email-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33083 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdAXHuJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2017 02:50:09 -0500
Received: by mail-pg0-f53.google.com with SMTP id 204so52965171pge.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2017 23:50:09 -0800 (PST)
In-Reply-To: <1485210765-9422-1-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, punit.agrawal@arm.com, steve.capper@arm.com, msalter@redhat.com, mlangsdorf@redhat.com, linux@armlinux.org.uk, lorenzo.pieralisi@arm.com, bamvor.zhangjian@linaro.org



On 2017/1/24 6:32, Jeremy Linton wrote:
> This patch expands and reworks the patches published by Mark Salter
> in order to clean up a few of the previous review comments, as well as
> add support for newer CPUs and big/little configurations.
>
> v14:
> - drop rename patch requested for v6
> - Shuffle couple include lines from one patch to a later
>   patch.

Test again on D03 and works fine as before,

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Hanjun
