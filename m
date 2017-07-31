From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] ACPI / Processor: add sysfs support for low power idle
Date: Mon, 31 Jul 2017 17:25:44 +0100
Message-ID: <3212e387-9f7d-5bd9-4612-79dddc77b05f@arm.com>
References: <1499968082-7753-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54880 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752045AbdGaQZr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Jul 2017 12:25:47 -0400
In-Reply-To: <1499968082-7753-1-git-send-email-pprakash@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, lenb@kernel.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>



On 13/07/17 18:48, Prashanth Prakash wrote:
> Add support to expose idle statistics maintained by platform to
> userspace via sysfs in addition to other data of interest from
> each LPI(Low Power Idle) state.
> 
> LPI described in section 8.4.4 of ACPI spec 6.1 provides different
> methods to obtain idle statistics maintained by the platform. These
> show a granular view of how each of the LPI state is being used at
> different level of hierarchy. sysfs data is exposed at each level in
> the hierarchy by creating a directory named 'lpi' at each level and
> the LPI state information is presented under it. Below is the
> representation of LPI information at one such level in the hierarchy
> 
> .../ACPI00XX: XX/lpi
> 	|-> state0
> 	|	|-> desc
> 	|	|-> time
> 	|	|-> usage
> 	|	|-> latency
> 	|	|-> min_residency
> 	|
> 	<<more states>>
> 
> ACPI00XX can be ACPI0007(processor) or ACPI0010(processor container)
> 
> stateX contains information related to a specific LPI state defined
> in the LPI ACPI tables.
> 
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> ---
> v2
> * Add Documentation/ABI/testing/sysfs-acpi-lpi
> v1
> * Drop flags, arch_flags and summary_stats field (Sudeep)
> * Create sysfs entries after we know that LPI will be used (Sudeep & Rafael)
> 
>  Documentation/ABI/testing/sysfs-acpi-lpi |  47 +++++
>  drivers/acpi/processor_idle.c            | 343 ++++++++++++++++++++++++++++++-
>  include/acpi/processor.h                 |  14 ++
>  3 files changed, 402 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-acpi-lpi
> 
> diff --git a/Documentation/ABI/testing/sysfs-acpi-lpi b/Documentation/ABI/testing/sysfs-acpi-lpi
> new file mode 100644
> index 0000000..5b054a1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-acpi-lpi

Sorry for the delay, I initial thought having this ABI under testing is
fine as I really don't want any *real* user space programs to depend on
this for various reasons stated in earlier threads, e.g. h/w auto
promotable states, accuracy of the stats, ..etc

But from Documentation/ABI/README, I see

testing/
	This directory documents interfaces that are felt to be stable,
	as the main development of this interface has been completed.
	The interface can be changed to add new features, but the
	current interface will not break by doing this, unless grave
	errors or security problems are found in them. User space
	programs can start to rely on these interfaces,...

which makes me worry. Since the use for this is purely for debug or
optimization purposes, I still prefer simple single file debugfs entry.
I still can't digest the fact that reading single file is time consuming
as we are not using this interface at runtime IIUC. i.e. statistic are
collected and analyzed offline.

But if Rafael is fine with this, that's fine.

-- 
Regards,
Sudeep
