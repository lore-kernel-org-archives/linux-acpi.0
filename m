From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 3/4] mailbox: pcc: optimized pcc_send_data
Date: Wed, 20 Jan 2016 17:05:23 -0700
Message-ID: <56A020C3.6060309@codeaurora.org>
References: <1452883415-24452-4-git-send-email-pprakash@codeaurora.org>
 <201601160304.RK00pi2j%fengguang.wu@intel.com>
 <CAJ5Y-ebHmNNjzt8j=REpmOxuGCFEHU1saK0k6BPkg2-2ZzFk1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51769 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbcAUAFZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2016 19:05:25 -0500
In-Reply-To: <CAJ5Y-ebHmNNjzt8j=REpmOxuGCFEHU1saK0k6BPkg2-2ZzFk1Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>



On 1/20/2016 3:29 PM, Ashwin Chaugule wrote:
>>>> drivers/mailbox/pcc.c:221:3: error: implicit declaration of function 'writeq' [-Werror=implicit-function-declaration]
>>       writeq(val, vaddr);
>>       ^
>>    cc1: some warnings being treated as errors
> You probably need to include asm-generic/io.h
>
Thanks! I will update, test and re-post the patch set.

-Prashanth
