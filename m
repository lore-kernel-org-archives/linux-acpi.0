From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 0/7] CPPC enhancements
Date: Tue, 13 Sep 2016 00:07:55 +0200
Message-ID: <2522176.850UacRmuH@vostro.rjw.lan>
References: <1471379984-15712-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61056 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755650AbcILWBt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Sep 2016 18:01:49 -0400
In-Reply-To: <1471379984-15712-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org

On Tuesday, August 16, 2016 02:39:37 PM Prashanth Prakash wrote:
> Hi,
> 
> This series has patches related to cppc that either improves the performance
> or adds some features.
> 
> v3:
>   * Fixed the error path in send_pcc_cmd in CPPC batching patch
>   * Included a patch to consolidate all the global variables
>   * Included a patch to check for PCC error bit (Alexey)
> v2:
>   * Sysfs entry for counter wraparound time(Alexey)
>   * Updated latency calculation to sum of Nominal and MRTT(Alexey)
>   * Moved refernce_perf from perf_caps to fb_ctrs
>   * Addressed review comments from Hoan and few minor cleanups
> v1:
>   * Pulled in the CPPC batching path to this series
>   * Addressed POSTCHANGE issue(Alexey) and switch to RW semaphore(Hoan)
> 
> Thanks,
> Prashanth
> Ashwin Chaugule (2):
>   ACPI/CPPC: restructure read/writes for efficient sys mapped reg ops
>   ACPI/CPPC: add sysfs support to compute delivered performance
> 
> Prashanth Prakash (5):
>   ACPI/CPPC: acquire pcc_lock only while accessing PCC subspace
>   ACPI/CPPC: support for batching CPPC requests
>   ACPI/CPPC: set a non-zero value for transition_latency
>   ACPI/CPPC: move all PCC related information into pcc_data
>   ACPI/CPPC: check for error bit in PCC status field
> 
>  drivers/acpi/cppc_acpi.c       | 600 +++++++++++++++++++++++++++++++----------
>  drivers/cpufreq/cppc_cpufreq.c |   1 +
>  include/acpi/cppc_acpi.h       |  14 +-
>  3 files changed, 466 insertions(+), 149 deletions(-)

All applied.

Thanks,
Rafael

