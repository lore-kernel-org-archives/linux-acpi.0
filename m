From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 4/5] acpi: dptf_power: Add DPTF power participant
Date: Fri, 1 Jul 2016 00:15:41 +0200
Message-ID: <CAJZ5v0iRHfzVfVXvXmhNCpffDkJq1GeT+HNiKVD8+=GpyMhZew@mail.gmail.com>
References: <1467244819-19046-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1467244819-19046-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36676 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbcF3WQG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jun 2016 18:16:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id c82so883718wme.3
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jun 2016 15:15:43 -0700 (PDT)
In-Reply-To: <1467244819-19046-5-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Jun 30, 2016 at 2:00 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> This driver adds support for Dynamic Platform and Thermal Framework
> (DPTF) Platform Power Participant device support.
> This participant is responsible for exposing platform telemetry such as
> platform Power, battery Information such as state of Charge, estimated
> maximum sustainable power (PMax), SMART battery spec information.
>
> This driver is implemented as a platform driver for INT3407. This driver
> uses services of battery_common to read battery information and state to
> avoid code duplication.
> Optionally this can register with power supply class and can act as
> ACPI Battery. This feature is activated only when CONFIG_ACPI_BATTERY
> is not defined in the configuration
>
> There are two types of objects in INT3407:
> - Same as ACPI Battery objects: _BST and _BIX. They are read directly
> using the interface from battery_common
> - Specific to INT3407: These objects are read directly executing
> ACPI methods in this module.
> These attributes are presented via sysfs interface under the INT3407
> platform device:
>
> #ls /sys/bus/platform/devices/INT3407\:00/dptf_power/
> adapter_rating_mw
> charger_type
> design_capacity_warning_mwh
> oem_info
> remaining_capacity_mwh
> battery_steady_power_mw
> charging_state
> design_voltage_mv
> platform_power_source
> serial_number
> capacity_granularity_1_mwh
> cycle_count
> last_full_charge_capacity_mwh
> power_sampling_period_us  type
> capacity_granularity_2_mwh
> design_capacity_low_mwh
> max_platform_power_mw
> present_rate_mw
> capacity_state
> design_capacity_mwh
> model_number
> present_voltage_mv
>
> ACPI methods description used in this driver:
> PSOC: Platform Battery State Of Charge as a percentage.
> PMAX: Maximum platform power that can be supported by the battery in mW.
> PSRC: System charge source,
>         0x00 = DC
>         0x01 = AC
>         0x02 = USB
>         0x03 = Wireless Charger
> ARTG: Adapter rating in mW (Maximum Adapter power) Must be 0 if no AC
>         Adaptor is plugged in.
> CTYP: Charger Type,
>         Traditional : 0x01
>         Hybrid: 0x02
>         NVDC: 0x03
> PBSS: Returns max sustained power for battery in milliWatts.
> DPSP: Polling interval in 10ths of seconds.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---

[cut]

> +
> +static int dptf_power_add(struct platform_device *pdev)
> +{
> +       struct acpi_device *acpi_dev;
> +       acpi_status status;
> +       unsigned long long ptype;
> +       int result;
> +
> +       acpi_dev = ACPI_COMPANION(&(pdev->dev));
> +       if (!acpi_dev)
> +               return -ENODEV;
> +
> +       status = acpi_evaluate_integer(acpi_dev->handle, "PTYP", NULL, &ptype);
> +       if (ACPI_FAILURE(status))
> +               return -ENODEV;
> +
> +       if (ptype != 0x11)
> +               return -ENODEV;
> +
> +#if IS_ENABLED(CONFIG_ACPI_BATTERY)
> +       result = acpi_battery_common_add(acpi_dev, false);
> +#else
> +       result = acpi_battery_common_add(acpi_dev, true);
> +#endif

You could write that as

    result = acpi_battery_common_add(acpi_dev,
!IS_ENABLED(CONFIG_ACPI_BATTERY));

However, I would always pass false as the second argument here.  At
least that would make the behavior more consistent and predictable
across different configurations.

And if that is done, the [5/5] can be improved slightly.
