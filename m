From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v2] ACPI / Processor: add sysfs support for low power idle
Date: Mon, 31 Jul 2017 12:18:08 -0600
Message-ID: <8beff6e7-e27c-0b44-6236-a95fcd5335d5@codeaurora.org>
References: <1499968082-7753-1-git-send-email-pprakash@codeaurora.org>
 <3212e387-9f7d-5bd9-4612-79dddc77b05f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdGaSSK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jul 2017 14:18:10 -0400
In-Reply-To: <3212e387-9f7d-5bd9-4612-79dddc77b05f@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>

Hi Sudeep,

On 7/31/2017 10:25 AM, Sudeep Holla wrote:
> Sorry for the delay, I initial thought having this ABI under testing is
> fine as I really don't want any *real* user space programs to depend on
> this for various reasons stated in earlier threads, e.g. h/w auto
> promotable states, accuracy of the stats, ..etc
<sorry for repeating this part>
These fields are optional, so if there is no reliable way to keep track of  stats, platform
can choose not to expose it. If a platform is exposing inaccurate stats via this ACPI
interface, it is breaking the spec.
> But from Documentation/ABI/README, I see
>
> testing/
> 	This directory documents interfaces that are felt to be stable,
> 	as the main development of this interface has been completed.
> 	The interface can be changed to add new features, but the
> 	current interface will not break by doing this, unless grave
> 	errors or security problems are found in them. User space
> 	programs can start to rely on these interfaces,...
>
> which makes me worry. Since the use for this is purely for debug or
> optimization purposes, I still prefer simple single file debugfs entry.
> I still can't digest the fact that reading single file is time consuming
> as we are not using this interface at runtime IIUC. i.e. statistic are
> collected and analyzed offline.
These fields has the same utility/use-cases as the usage & time fields in cpuidle sysfs,
but provides more granularity - idle stats for different levels hierarchy and accurate
idle stats for states that require platform co-ordination.

The argument for having a single sysfs file per node was that reading individual
files might get expensive to get a snapshot(not the other way around). But, that
argument was weak as we typically read these only in debug settings and not that
often during runtime. So, the summary_stats file was removed and went with one
value per file.

--
Thanks,
Prashanth
