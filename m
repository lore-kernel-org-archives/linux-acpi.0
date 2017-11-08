From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3] ACPI / Processor: add sysfs support for low power idle
Date: Wed, 8 Nov 2017 14:18:43 +0000
Message-ID: <0569bb96-bd27-6c01-eb3c-5e4e1d868b2a@arm.com>
References: <1508437188-14463-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbdKHOSs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Nov 2017 09:18:48 -0500
In-Reply-To: <1508437188-14463-1-git-send-email-pprakash@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>, linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, lenb@kernel.org

Hi,


On 19/10/17 19:19, Prashanth Prakash wrote:
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
> 	|	|-> state_name
> 	|	|-> residency
> 	|	|-> usage
> 	|	|-> wakeup_latency
> 	|	|-> min_residency
> 	|	|-> state_index
> 	|	|-> enabled_parent_state
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


> v3
> * Changed sysfs names to follow spec names (Rafael)
> * Added enabled_parent_state(Rafael) and state_index to sysfs entries
>   state_index was added to make sense of enabled_parent_state
> 
> Couldn't find a clean way to expose the hierarchical LPI information under
> cpuidle
> 
> v2
> * Add Documentation/ABI/testing/sysfs-acpi-lpi
> 
> v1
> * Drop flags, arch_flags and summary_stats field (Sudeep)
> * Create sysfs entries after we know that LPI will be used (Sudeep & Rafael)
> 

I still prefer this as debugfs and not as sysfs ABI. We already have
issues with multiple interfaces for the same thing. E.g. cpufreq on x86.
I don't want this to end up in the same way after few years. CPUIdle
sysfs should be only sysfs ABI for these, adding an alternative is
inviting troubles for future especially if some user-space starts using
it and we will be stuck with that. Moreover with more h/w controlled
idle we may not provide accurate data sooner.

Sorry for the noise, I will shup up now ;). Since this may be last
chance to make some noise, I am trying it. I completely understand that
this is just my opinion and am fine if others thinks it's good to make
this sysfs ABI.

-- 
Regards,
Sudeep
