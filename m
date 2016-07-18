From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5] acpi: dptf_power: Add DPTF power participant
Date: Tue, 19 Jul 2016 01:00:50 +0200
Message-ID: <CAJZ5v0gJr_tqGL+4z_idFRFZCzt91g6uv+sXdA7=5WddzW8k8Q@mail.gmail.com>
References: <1468788332-32518-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1468788332-32518-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37978 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbcGRXAw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Jul 2016 19:00:52 -0400
Received: by mail-wm0-f42.google.com with SMTP id o80so5303997wme.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jul 2016 16:00:51 -0700 (PDT)
In-Reply-To: <1468788332-32518-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sun, Jul 17, 2016 at 10:45 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> This driver adds support for Dynamic Platform and Thermal Framework
> (DPTF) Platform Power Participant device (INT3407) support.
>
> This participant is responsible for exposing platform telemetry such as:
>     max_platform_power
>     platform_power_source
>     adapter_rating
>     battery_steady_power
>     charger_type
>
> These attributes are presented via sysfs interface under the INT3407
> platform device:
> $ls /sys/bus/platform/devices/INT3407\:00/dptf_power/
>     adapter_rating_mw
>     battery_steady_power_mw
>     charger_type
>     max_platform_power_mw
>     platform_power_source
>     `
> ACPI methods description used in this driver:
>     PMAX: Maximum platform power that can be supported by the battery in
>           mW.
>     PSRC: System charge source,
>             0x00 = DC
>             0x01 = AC
>             0x02 = USB
>             0x03 = Wireless Charger
>     ARTG: Adapter rating in mW (Maximum Adapter power) Must be 0 if no
>           AC adapter is plugged in.
>     CTYP: Charger Type,
>             Traditional : 0x01
>             Hybrid: 0x02
>             NVDC: 0x03
>     PBSS: Returns max sustained power for battery in milliWatts.
>
> The INT3407 also contains _BTS and _BIX objects, which are compliant to
> ACPI 5.0, specification. Those objects are already used by ACPI battery
> (PNP0C0A) driver and information about them is exported via Linux power
> supply class registration.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This looks good to me.

You had a patch moving some other DPTF stuff to the dptf subdirectory,
can you please resend it?

Thanks,
Rafael
