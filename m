From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v2] mailbox: pcc: Add PCC request and free channel
 declarations
Date: Thu, 23 Jun 2016 09:39:28 -0600
Message-ID: <0f854204-e561-8d88-baaa-fe697a53c1fe@codeaurora.org>
References: <1466111378-4390-1-git-send-email-hotran@apm.com>
 <2673488.DmxRkxKR3W@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60028 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbcFWPjc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jun 2016 11:39:32 -0400
In-Reply-To: <2673488.DmxRkxKR3W@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hoan Tran <hotran@apm.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, lho@apm.com, Duc Dang <dhdang@apm.com>

Hi Rafael,

On 6/22/2016 6:49 PM, Rafael J. Wysocki wrote:
> On Thursday, June 16, 2016 02:09:38 PM Hoan Tran wrote:
>> Exports pcc_mbox_request_channel() and pcc_mbox_free_channel()
>> declarations into a pcc.h header file.
>>
>> v2
>>  * Introduce pcc.h header file for pcc client methods
>>
>> v1
>>  * Initial
>>
>> Signed-off-by: Hoan Tran <hotran@apm.com>
> Ashwin, Prakash, any comments anyone?

This change looks good.

Thanks,
Prashanth

