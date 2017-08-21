From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Mon, 21 Aug 2017 23:49:39 +0200
Message-ID: <CAJZ5v0jvPEDuezyjzuj0nYiiu6ZT-GxLb+28orvrwMCm2=UWqA@mail.gmail.com>
References: <20170818194644.14538-1-toshi.kani@hpe.com> <20170818194644.14538-2-toshi.kani@hpe.com>
 <20170821112657.hrtjoeagxhc67rrr@pd.tnic> <1503333107.2042.163.camel@hpe.com>
 <20170821170415.kttnqiwj2fkntsc7@pd.tnic> <1503335626.2042.165.camel@hpe.com>
 <20170821173612.i3zxlmxklmvv5kzd@pd.tnic> <CAJZ5v0iMR-m6JRDJBeYLDH3uz4_gGAoxQY6Yk3-vf9L=x6G-_A@mail.gmail.com>
 <1503349011.2042.168.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503349011.2042.168.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "rafael@kernel.org" <rafael@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 21, 2017 at 11:06 PM, Kani, Toshimitsu <toshi.kani@hpe.com> wrote:
> On Mon, 2017-08-21 at 22:31 +0200, Rafael J. Wysocki wrote:
>> On Mon, Aug 21, 2017 at 7:36 PM, Borislav Petkov <bp@alien8.de>
>> wrote:
>> > On Mon, Aug 21, 2017 at 05:23:37PM +0000, Kani, Toshimitsu wrote:
>> > > > > 'data' here is private to the caller.  So, I do not think we
>> > > > > need to define the bits.  Shall I change the name to
>> > > > > 'driver_data' to make it more explicit?
>> > > >
>> > > > You changed it to 'data'. It was a u32-used-as-boolean
>> > > > is_critical_error before.
>> > > >
>> > > > So you can just as well make it into flags and people can
>> > > > extend those flags if needed. A flag bit should be enough in
>> > > > most cases anyway. If they really need driver_data, then they
>> > > > can add a void *member.
>> > >
>> > > Hmm.. In patch 2, intel_pstate_platform_pwr_mgmt_exists() uses
>> > > this field for PSS and PCC, which are enum values.  I think we
>> > > should allow drivers to set any values here.  I agree that it may
>> > > need to be void * if we also allow drivers to set a pointer here.
>> >
>> > Let's see what Rafael prefers.
>>
>> I would retain the is_critical_error field and use that for printing
>> the recoverable / non-recoverable message.  This is kind of
>> orthogonal to whether or not any extra data is needed and that can be
>> an additional field.  In that case unsigned long should be sufficient
>> to accommodate a pointer if need be.
>
> Yes, we will retain the field.  The question is whether this field
> should be retained as a driver's private data or ACPI-managed flags.

Thanks for the clarification.

> My patch implements the former, which lets the callers to define the
> data values.  For instance, acpi_blacklisted() uses this field as
> is_critical_error value, and intel_pstate_platform_pwr_mgmt_exists()
> uses it as oem_pwr_table value.
>
> Boris suggested the latter, which lets ACPI to define the flags, which
> are then used by the callers.  For instance, he suggested ACPI to
> define bit0 as is_critical_error.
>
> #define ACPI_PLAT_IS_CRITICAL_ERROR     BIT(0)

So my point is that we can have both the ACPI-managed flags and the
the caller-defined data at the same time as separate items.

That would allow of maximum flexibility IMO.

Thanks,
Rafael
