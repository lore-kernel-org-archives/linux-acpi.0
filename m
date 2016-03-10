From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4 0/5] acpi: cppc optimization patches
Date: Fri, 11 Mar 2016 00:36:03 +0100
Message-ID: <3161640.R8xYpdOEaQ@vostro.rjw.lan>
References: <1455740463-19192-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58958 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932857AbcCJXeJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 18:34:09 -0500
In-Reply-To: <1455740463-19192-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: ashwin.chaugule@linaro.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, alexey.klimov@arm.com

On Wednesday, February 17, 2016 01:20:58 PM Prashanth Prakash wrote:
> Changes in V4: 
> [1] Added another patch which decides if or when to send a request to the 
> platform based on the Minimum Request Turnaround Time(MRTT) and Maximum 
> Periodic Access Rate(MPAR) to make sure the implementation is compliant
> to ACPI spec
> [2] Fixed the condition for pr_debug message in cppc_chan_tx_done() 
> 
> Changes in V3: Addressed the review comments from Alexey, Ashwin and Timur
> 
> Changes in V2: Fixed compilation error on i386
> 
> This series introduces changes to reduce the time required to send a frequency
> transition requests to the platform while using the cppc-cpufreq driver.
> 
> With these changes we see significant improvement in the average time to send
> freq. transition request to the platform. Profiling on an ARM platform showed
> that the average transaction time per request reduced from 200us to under 20us.
> 
> Ashwin Chaugule (1):
>   ACPI / CPPC: Optimize PCC Read Write operations
> 
> Prashanth Prakash (4):
>   acpi: cppc: optimized cpc_read and cpc_write
>   mailbox: pcc: optimized pcc_send_data
>   acpi: cppc: replace writeX/readX to PCC with relaxed version
>   acpi/cppc: use MRTT/MPAR to decide if/when a req can be sent
> 
>  drivers/acpi/cppc_acpi.c | 237 ++++++++++++++++++++++++++++++++++++++---------
>  drivers/mailbox/pcc.c    | 111 ++++++++++++++++++++--
>  2 files changed, 295 insertions(+), 53 deletions(-)

All applied (with minor modifications of subjects and similar).

Thanks,
Rafael

