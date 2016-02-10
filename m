From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH V3 1/4] ACPI / CPPC: Optimize PCC Read Write operations
Date: Wed, 10 Feb 2016 14:42:51 -0600
Message-ID: <56BBA0CB.2000504@codeaurora.org>
References: <1455134762-31400-1-git-send-email-pprakash@codeaurora.org>
 <1455134762-31400-2-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46202 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbcBJUmz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2016 15:42:55 -0500
In-Reply-To: <1455134762-31400-2-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>, rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, ashwin.chaugule@linaro.org, alexey.klimov@arm.com

Prashanth Prakash wrote:

> +static int check_pcc_chan(void)
> +{
> +	int ret = -EIO;
> +	struct acpi_pcct_shared_memory __iomem *generic_comm_base = pcc_comm_addr;
> +	ktime_t next_deadline = ktime_add(ktime_get(), deadline);
> +
> +	/* Retry in case the remote processor was too slow to catch up. */
> +	while (!ktime_after(ktime_get(), next_deadline)) {
> +		if (readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE) {
> +			ret = 0;
> +			break;
> +		}
> +		/*
> +		 * Reducing the bus traffic in case this loop takes longer than
> +		 * a few retries.
> +		 */
> +		udelay(3);
> +	}

Like I said last time, you really should use 
readq_relaxed_poll_timeout(), which does exactly the same thing as this 
loop, but more elegantly.  I think this will work:

u32 status;
ret = readq_relaxed_poll_timeout(&generic_comm_base->status, status, 
status & PCC_CMD_COMPLETE, 3, deadline);
return ret ? -EIO : 0;
...
deadline = NUM_RETRIES * cppc_ss->latency;

This lets you completely eliminate all usage of ktime.  You can 
eliminate the global variable 'deadline' also, if you can figure out how 
to pass the cppc_ss object to check_pcc_chan().

> -	/* Wait for a nominal time to let platform process command. */
> -	udelay(cmd_latency);
> -
> -	/* Retry in case the remote processor was too slow to catch up. */
> -	for (retries = NUM_RETRIES; retries > 0; retries--) {
> -		if (readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE) {
> -			result = 0;
> -			break;
> -		}
> -	}
> +	/*
> +	 * For READs we need to ensure the cmd completed to ensure
> +	 * the ensuing read()s can proceed. For WRITEs we dont care

"don't"



-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
