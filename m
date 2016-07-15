From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 1/5] ACPI/CPPC: restructure read/writes for efficient sys
 mapped reg ops
Date: Fri, 15 Jul 2016 14:26:04 -0600
Message-ID: <a7acdd38-e144-3d10-a1bc-7ed49820ed15@codeaurora.org>
References: <1467309758-26536-1-git-send-email-pprakash@codeaurora.org>
 <1467309758-26536-2-git-send-email-pprakash@codeaurora.org>
 <CAFHUOYw77rXXtRNviMiuRock638Zjjs1o-DtZZv_vtodWzeyUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51441 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbcGOU0H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2016 16:26:07 -0400
In-Reply-To: <CAFHUOYw77rXXtRNviMiuRock638Zjjs1o-DtZZv_vtodWzeyUw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hoan Tran <hotran@apm.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexey Klimov <alexey.klimov@arm.com>, cov@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hi Hoan,
>> -static int cpc_read(struct cpc_reg *reg, u64 *val)
>> +static int cpc_read(struct cpc_register_resource *reg_res, u64 *val)
>>  {
>>         int ret_val = 0;
>> +       void __iomem *vaddr = 0;
>> +       struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>> +
>> +       if (reg_res->type == ACPI_TYPE_INTEGER) {
>> +               *val = reg_res->int_value;
> It should be "*val = reg_res->cpc_entry.int_value;", isn't it ?
>
Yes, that's correct. I will fix it in the next version. Thanks!
Interestingly, I don't think I saw an error or warning during compile:)

Thanks,
Prashanth


