From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v4 4/5] arm64: add support for ACPI Low Power Idle(LPI)
Date: Tue, 26 Apr 2016 09:51:25 -0600
Message-ID: <571F8E7D.4000706@codeaurora.org>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
 <1461069013-13292-5-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37283 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbcDZPva (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Apr 2016 11:51:30 -0400
In-Reply-To: <1461069013-13292-5-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mark Rutland <mark.rutland@arm.com>

Hi Sudeep,

On 4/19/2016 6:30 AM, Sudeep Holla wrote:
> +struct acpi_processor_lpi *lpi;
> +int acpi_processor_ffh_lpi_enter(struct acpi_processor_lpi *lpi, int idx)
> +{
> +	int ret;
> +
> +	if (!idx) {
> +		cpu_do_idle();
> +		return idx;
> +	}
> +
> +	/* TODO cpu_pm_{enter,exit} can be done in generic code ? */
> +	ret = cpu_pm_enter();
Can we avoid calling cpu_pm_enter and cpu_pm_exit for retention states as it is not necessary?
May be we can check LPI architecture specific context loss flags prior to calling these.
> +	if (!ret) {
> +		/*
> +		 * Pass idle state index to cpu_suspend which in turn will
> +		 * call the CPU ops suspend protocol with idle index as a
> +		 * parameter.
> +		 */
> +		ret = arm_cpuidle_suspend(idx);
> +
> +		cpu_pm_exit();
same here
> +	}
> +
> +	return ret ? -1 : idx;
> +}
> +

By the way, thanks for posting these patches!

-Prashanth
