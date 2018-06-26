From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: ACPI support in common clock framework
Date: Tue, 26 Jun 2018 14:29:27 +0530
Message-ID: <CABe79T6tnWjCZkHgoO+qfHbtTvevPFH_KE6+XsvCa6cKAbVJjg@mail.gmail.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
 <CAJZ5v0iJcTg=X_j-4nap9d_H4jq2rwOETT8Sukx6UL5UsDKjgA@mail.gmail.com>
 <152908459103.16708.4012421602830600322@swboyd.mtv.corp.google.com>
 <CAJZ5v0gA76NwwgRnuztY+dUOKXS+__-7Ghw7Azb-84h_eMRt4w@mail.gmail.com>
 <152994466823.143105.11787470853817181844@swboyd.mtv.corp.google.com>
 <914341e7-ca94-054d-6127-522b745006b4@arm.com> <152996983664.143105.1441423217241075965@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152996983664.143105.1441423217241075965@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk <linux-clk@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael, Stephen,

Thank you so much for detailed inputs.

In our platform, all HW clocks are accessed (enable/disable/set rate)
in Linux through common clock framework (drivers/clk/) using clock
nodes exported by device tree.
To manage our HW clocks operations (enable/disable/set rate) we have
driver in common clock framework (clk-iproc-pll.c, clk-sr.c).
At present, clock drivers get properties information from device tree framework.
Also many devices to access (enable/disable/set rate) its clock source
in their driver. it must call clk_get function and clocks phandler in
its device tree node.
It means, common clock framework is tightly coupled with device tree framework.

We want to upgrade our platforms to ACPI support in the place of
device tree support.
So that we need to have ACPI support in common clock framework, to
modify our HW clock drivers.
At the same time we also configure few clocks as "fixed-factor-clock".
so fixed-factor-clock also need ACPI support.
These are all the reasons insists to have ACPI support in common clock
framework.

Ex: SP805 watch dog used in our platform whose driver is register as
AMBA device.
In this case both apb_pclk and watch dog clock devices get (clk_get
API) through device tree APIs.
AMBA framework has ACPI support. so probe function of sp805_wdt driver
is called. But failed with clk_get API
because common clock does not have ACPI support.

I thought a solution to upgrade ACPI support in common clock
framework, in the similar way we have ACPI support in normal device
drivers using DSDT ACPI tables.
DSDT table of all devices including clock devices contain all resource
specific information of device and clock device name.
Need to implement similar APIs like of_clk* for ACPI purpose also to
get clock device in driver software.
Ex:
of_clk_src_simple_get
of_clk_hw_simple_get
of_clk_src_onecell_get
of_clk_hw_onecell_get
of_clk_add_provider
of_clk_add_hw_provider
of_clk_del_provider
of_clk_get_from_provider
of_clk_get_parent_count
of_clk_get_parent_name
of_clk_parent_fill

With this approach no dependency on AML to provide clock rate, enable,
disable. It is like translating device tree into ACPI.

Please provide your inputs.

Regards,
Srinath.


On Tue, Jun 26, 2018 at 5:07 AM, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Sudeep Holla (2018-06-25 10:15:45)
>>
>>
>> On 25/06/18 17:37, Stephen Boyd wrote:
>> > Quoting Rafael J. Wysocki (2018-06-16 08:50:18)
>> >> On Fri, Jun 15, 2018 at 7:43 PM, Stephen Boyd <sboyd@kernel.org> wrote:
>> >>>
>> >>> Is this for clk_enable/disable? What about clk_set_rate() or
>> >>> clk_set_phase()? Is ACPI's AML taking care of that?
>> >>
>> >> That's for clk_enable/disable AFAICS.
>> >>
>> >> AML doesn't manage device performance states at all.
>> >
>> > Alright. We may need to add a better way for device drivers to get
>> > handles to clk pointers on ACPI firmware so they can change frequencies
>> > or phase, etc.
>>
>> Is there any specific usecase/device needing this in the kernel ? SPI
>> slaves ?
>
> Mark Brown has been pushing x86 folks to use clk framework for audio
> drivers in ASoC. I haven't seen other uses besides that really.
>
