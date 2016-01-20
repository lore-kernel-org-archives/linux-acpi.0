From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4] dell-wmi: Support new hotkeys on the XPS 13 9350 (Skylake)
Date: Wed, 20 Jan 2016 12:46:23 -0800
Message-ID: <CALCETrUqH7FLPyHasx020vyjZNtTdVSk+0LJKcGjXyj+iwE8Dw@mail.gmail.com>
References: <a343d7d11816d86d04c51505f6e33c5b99086ff6.1453244706.git.luto@kernel.org>
 <20160120194050.GL7192@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20160120194050.GL7192@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Jon Eyolfson <jon@eyl.io>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 20, 2016 at 11:40 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> On Tuesday 19 January 2016 15:07:47 Andy Lutomirski wrote:
>> The XPS 13 9350 sends WMI keypress events that aren't enumerated in
>> the DMI table.  Add a table listing them.  To avoid breaking things
>> that worked before, these un-enumerated hotkeys won't be used if the
>> DMI table maps them to something else.
>>
>> FWIW, it appears that the DMI table may be a legacy thing and we
>> might want to rethink how we handle events in general.  As an
>> example, a whole lot of things map to KEY_PROG3 via the DMI table.
>>
>> So far, this doesn't send keypress events for any of the new
>> events.  Depnding on whether we figure out exactly what needs to
>> happen to get the wireless button working in time for Linux 4.5,
>> we might want to temporarily handle it in dell-wmi.
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>
> Looks good,
>
> Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Darren, if/when you apply this, can you fix up the last paragraph of
the commit message?

    This doesn't send keypress events for any of the new
    events, as no models appear to require it.

I wrote the old text before intel-hid landed.

--Andy
