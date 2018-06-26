From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: ACPI support in common clock framework
Date: Tue, 26 Jun 2018 20:27:43 +0300
Message-ID: <CAHp75VfJQOZ9K=SusdDpV5NGeSnCvLvcg9w7nqqiyudH7+QGgA@mail.gmail.com>
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
Cc: Srinath Mannam <srinath.mannam@broadcom.com>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk <linux-clk@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 26, 2018 at 2:37 AM, Stephen Boyd <sboyd@kernel.org> wrote:
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

All LPSS code based on fixed rate clocks created by some platform
code. Since we have no board files for modern x86 platforms the clock
providers and consumers often are located in the same / adjoining
drivers.

-- 
With Best Regards,
Andy Shevchenko
