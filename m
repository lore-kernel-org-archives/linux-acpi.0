From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 20/22] fjes: epstop_task
Date: Thu, 18 Jun 2015 16:55:35 +0300
Message-ID: <5582CDD7.9030304@cogentembedded.com>
References: <1434588359-25589-1-git-send-email-izumi.taku@jp.fujitsu.com> <1434588587-25655-1-git-send-email-izumi.taku@jp.fujitsu.com> <1434588587-25655-20-git-send-email-izumi.taku@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35134 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbbFRNzj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2015 09:55:39 -0400
Received: by lbbwc1 with SMTP id wc1so52932093lbb.2
        for <linux-acpi@vger.kernel.org>; Thu, 18 Jun 2015 06:55:38 -0700 (PDT)
In-Reply-To: <1434588587-25655-20-git-send-email-izumi.taku@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Taku Izumi <izumi.taku@jp.fujitsu.com>, platform-driver-x86@vger.kernel.org, dvhart@infradead.org
Cc: rkhan@redhat.com, alexander.h.duyck@redhat.com, netdev@vger.kernel.org, linux-acpi@vger.kernel.org

Hello.

On 6/18/2015 3:49 AM, Taku Izumi wrote:

> This patch adds epstop_task.
> This task is used to process other receiver's
> cancellation request.

> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>   drivers/platform/x86/fjes/fjes_hw.c   | 34 ++++++++++++++++++++++++++++++++++
>   drivers/platform/x86/fjes/fjes_hw.h   |  1 +
>   drivers/platform/x86/fjes/fjes_main.c |  1 +
>   3 files changed, 36 insertions(+)

> diff --git a/drivers/platform/x86/fjes/fjes_hw.c b/drivers/platform/x86/fjes/fjes_hw.c
> index e07b266..c22679a 100644
> --- a/drivers/platform/x86/fjes/fjes_hw.c
> +++ b/drivers/platform/x86/fjes/fjes_hw.c
[...]
> @@ -1123,3 +1126,34 @@ static void fjes_hw_update_zone_task(struct work_struct *work)
>   	}
>   }
>
> +static void fjes_hw_epstop_task(struct work_struct *work)
> +{
> +	struct fjes_hw *hw = container_of(work,
> +			struct fjes_hw, epstop_task);

    Please start the continuation lines under 'work' on the first line.

> +	struct fjes_adapter *adapter = (struct fjes_adapter *)hw->back;
> +	int epid_bit;
> +	unsigned long remain_bit;
> +
> +	while ((remain_bit = hw->epstop_req_bit)) {
> +

    Don't think this empty line is needed.

> +		for (epid_bit = 0; remain_bit; (remain_bit >>= 1),
> +			(epid_bit++)) {

    Inner parens not needed, the comma operator has lowest priority.

> +
> +			if (remain_bit & 1) {
> +

    Don't think this empty line is needed.

[...]

WBR, Sergei

