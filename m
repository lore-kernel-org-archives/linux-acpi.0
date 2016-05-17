From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v5 2/5] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
Date: Tue, 17 May 2016 11:46:13 -0600
Message-ID: <573B58E5.2020005@codeaurora.org>
References: <1462981062-24909-1-git-send-email-sudeep.holla@arm.com>
 <1462981062-24909-3-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34749 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbcEQRqY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2016 13:46:24 -0400
In-Reply-To: <1462981062-24909-3-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Hi Sudeep,

On 5/11/2016 9:37 AM, Sudeep Holla wrote:
> +
> +static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
> +{
> +	int ret, i;
> +	struct acpi_lpi_states_array *info;
> +	struct acpi_device *d = NULL;
> +	acpi_handle handle = pr->handle, pr_ahandle;
> +	acpi_status status;
> +
> +	if (!osc_pc_lpi_support_confirmed)
> +		return -EOPNOTSUPP;
> +
> +	max_leaf_depth = 0;
> +	if (!acpi_has_method(handle, "_LPI"))
> +		return -EINVAL;
> +	flat_state_cnt = 0;
> +
> +	while (ACPI_SUCCESS(status = acpi_get_parent(handle, &pr_ahandle))) {
> +		if (!acpi_has_method(handle, "_LPI"))
> +			continue;
> +
> +		acpi_bus_get_device(handle, &d);
> +		if (!strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
> +			break;
> +
> +		max_leaf_depth++;
> +		handle = pr_ahandle;
> +	}
> +
In the above loop, we break when we find a device with HID == ACPI_PROCESSOR_CONTAINER_HID.
Shouldn't we continue to parse as long as the parent HID == ACPI_PROCESSOR_CONTAINER_HID?
This is required to make sure we parse states in levels higher than cluster level
in processor hierarchy.

Also, I think it might be safe to break out of the loop if we didn't find _LPI
package, instead of continuing. Given  the presence of LPI entry: "Enabled Parent
State", I can't think of a non-ambiguous scenario where we might find LPI packages
in state N and N+2, but not in N+1, as we will not be able to figure out which
state in N enables which states in N+2. Thoughts?

Thanks,
Prashanth
