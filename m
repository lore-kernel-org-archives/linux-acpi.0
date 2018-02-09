From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] acpi/dptf: document sysfs atttributes
Date: Fri, 9 Feb 2018 11:31:35 +0100
Message-ID: <CAJZ5v0i5=EdmR_6Kcg=r5XUBtt8yaQX_yHt_qRfZLU-q85gkBQ@mail.gmail.com>
References: <cover.1518009225.git.aishpant@gmail.com> <01eb929d8dbfa3e2041d33619a7d30a6b0f4748c.1518009225.git.aishpant@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01eb929d8dbfa3e2041d33619a7d30a6b0f4748c.1518009225.git.aishpant@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aishwarya Pant <aishpant@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 7, 2018 at 2:18 PM, Aishwarya Pant <aishpant@gmail.com> wrote:
> The descriptions have been collected from git commit logs and reading
> through code.
>
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-platform-dptf | 30 +++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-dptf
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
> new file mode 100644
> index 000000000000..e8168e5198d7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> @@ -0,0 +1,30 @@
> +sysfs interface for ACPI DPTF platform power driver
> +---------------------------------------------------

The header isn't necessary.

> +
> +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/charger_type
> +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/adapter_rating_mw
> +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/max_platform_power_mw
> +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/platform_power_source
> +What:          /sys/bus/platform/devices/INT3407:00/dptf_power/battery_steady_power

There should be one entry per attribute AFAICS.

Also I need Srinivas to tell me whether or not the descriptions are
accurate enough.

> +Date:          Jul, 2016
> +KernelVersion: v4.10
> +Contact:       linux-acpi@vger.kernel.org
> +Description:
> +               charger_type:           (RO) The charger type- Traditional,
> +                                       Hybrid or NVDC.
> +
> +               adapter_rating_mw:      (RO) Adapter rating in milliwatts (the
> +                                       maximum Adapter power). Must be 0 if no
> +                                       AC Adaptor is plugged in.
> +
> +               max_platform_power_mw:  (RO) Maximum platform power that can be
> +                                       supported by the battery in milliwatts.
> +
> +               platform_power_source:  (RO) Display the platform power source
> +                                       0x00 = DC
> +                                       0x01 = AC
> +                                       0x02 = USB
> +                                       0x03 = Wireless Charger
> +
> +               battery_steady_power_mw:(RO) The maximum sustained power for
> +                                       battery in milliwatts.
> --
