From: Mike Travis <travis@sgi.com>
Subject: Re: [PATCH 1/4] printk: Allocate kernel log buffer earlier
Date: Mon, 28 Feb 2011 11:26:04 -0800
Message-ID: <4D6BF6CC.4000407@sgi.com>
References: <20110225180633.857892225@gulag1.americas.sgi.com> <20110225180634.017570095@gulag1.americas.sgi.com> <20110227120949.GF16453@elte.hu> <20110227121518.GA19165@elte.hu> <4D6AFBB0.70401@kernel.org> <20110228080133.GB1600@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.179.30]:43043 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755121Ab1B1T0D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Feb 2011 14:26:03 -0500
In-Reply-To: <20110228080133.GB1600@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Yinghai Lu <yinghai@kernel.org>, David Rientjes <rientjes@google.com>, Jack Steiner <steiner@sgi.com>, Robin Holt <holt@sgi.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yhlu.kernel@gmail.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Because I haven't been able to test on a fully configured
system, this might be crucial info to figure out how to
fix this when it happens on a customer system.  Are you
saying this small line is any less important than the
other thousands and thousands of seemingly meaningless
lines?

Ingo Molnar wrote:
> * Yinghai Lu <yinghai@kernel.org> wrote:
> 
>> +	pr_info("log_buf_len: %d\n", log_buf_len);
>> +	pr_info("early log buf free: %d(%d%%)\n",
>> +		free, (free * 100) / __LOG_BUF_LEN);
> 
> Such debug printks should be removed from the final version of the patch ...
> 
> Thanks,
> 
> 	Ingo
