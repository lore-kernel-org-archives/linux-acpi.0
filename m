From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 1/5] ACPI / blacklist: add acpi_match_platform_list()
Date: Mon, 21 Aug 2017 22:31:26 +0200
Message-ID: <CAJZ5v0iMR-m6JRDJBeYLDH3uz4_gGAoxQY6Yk3-vf9L=x6G-_A@mail.gmail.com>
References: <20170818194644.14538-1-toshi.kani@hpe.com> <20170818194644.14538-2-toshi.kani@hpe.com>
 <20170821112657.hrtjoeagxhc67rrr@pd.tnic> <1503333107.2042.163.camel@hpe.com>
 <20170821170415.kttnqiwj2fkntsc7@pd.tnic> <1503335626.2042.165.camel@hpe.com> <20170821173612.i3zxlmxklmvv5kzd@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35007 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdHUUb2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2017 16:31:28 -0400
In-Reply-To: <20170821173612.i3zxlmxklmvv5kzd@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Aug 21, 2017 at 7:36 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Aug 21, 2017 at 05:23:37PM +0000, Kani, Toshimitsu wrote:
>> > > 'data' here is private to the caller.  So, I do not think we need
>> > > to define the bits.  Shall I change the name to 'driver_data' to
>> > > make it more explicit?
>> >
>> > You changed it to 'data'. It was a u32-used-as-boolean
>> > is_critical_error before.
>> >
>> > So you can just as well make it into flags and people can extend
>> > those flags if needed. A flag bit should be enough in most cases
>> > anyway. If they really need driver_data, then they can add a void *
>> > member.
>>
>> Hmm.. In patch 2, intel_pstate_platform_pwr_mgmt_exists() uses this
>> field for PSS and PCC, which are enum values.  I think we should allow
>> drivers to set any values here.  I agree that it may need to be void *
>> if we also allow drivers to set a pointer here.
>
> Let's see what Rafael prefers.

I would retain the is_critical_error field and use that for printing
the recoverable / non-recoverable message.  This is kind of orthogonal
to whether or not any extra data is needed and that can be an
additional field.  In that case unsigned long should be sufficient to
accommodate a pointer if need be.

Thanks,
Rafael
