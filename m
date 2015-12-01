From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 5/5] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
Date: Tue, 1 Dec 2015 17:43:34 +0000
Message-ID: <565DDC46.6020707@arm.com>
References: <1438710406-3822-1-git-send-email-sudeep.holla@arm.com>
 <1442411963-14398-1-git-send-email-sudeep.holla@arm.com>
 <1442411963-14398-6-git-send-email-sudeep.holla@arm.com>
 <CAJ5Y-ebOPE1oamRk31nxL6VkgSdDd6AmEe2Fw1ku5pGt25D2Rg@mail.gmail.com>
 <565DD7A6.1000802@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37569 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894AbbLARnm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Dec 2015 12:43:42 -0500
In-Reply-To: <565DD7A6.1000802@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, x86@kernel.org, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mahesh Sivasubramanian <msivasub@codeaurora.org>, wufan@codeaurora.org

Hi Prashanth,

On 01/12/15 17:23, Prakash, Prashanth wrote:
> Hi Sudeep,
>>> +static void combine_lpi_states(struct acpi_processor_lpi *l_lpi,
>>> +                              struct acpi_processor_lpi *p_lpi,
>>> +                              struct acpi_processor_lpi *c_lpi)
>>> +{
>>> +       c_lpi->min_residency = max(l_lpi->min_residency, p_lpi->min_residency);
>>> +       c_lpi->wake_latency = l_lpi->wake_latency + p_lpi->wake_latency;
>>> +       c_lpi->enable_parent_state = p_lpi->enable_parent_state;
>>> +       c_lpi->entry_method = l_lpi->entry_method;
>>> +       c_lpi->address = l_lpi->address + p_lpi->address;
>>> +       c_lpi->index = p_lpi->index;
>>> +       c_lpi->flags = p_lpi->flags;
>>> +       c_lpi->arch_flags = p_lpi->arch_flags;
>>> +       strncpy(c_lpi->desc, l_lpi->desc, ACPI_CX_DESC_LEN);
>>> +       strncat(c_lpi->desc, "+", ACPI_CX_DESC_LEN);
>>> +       strncat(c_lpi->desc, p_lpi->desc, ACPI_CX_DESC_LEN);
>>> +}
> I suppose you meant to use strl* instead of strn* operations.  Below is a
> simple patch to fix these. Can you please fold these changes into your next
> version as well?
>

Thanks for reporting, I had fixed it already as I ran into same issue
when I was playing around with the description string in the LPI tables.

Just adding some comments to the code now where ever it's not so
obvious, will post it tomorrow.

--
Regards,
Sudeep
