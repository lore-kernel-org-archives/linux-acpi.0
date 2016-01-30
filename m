From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4] dell-wmi: Support new hotkeys on the XPS 13 9350 (Skylake)
Date: Sat, 30 Jan 2016 09:17:47 -0800
Message-ID: <CALCETrVZ06EpseG9Rkr59rB4QboAJhMEremQrQ1oLxxNrDTKWA@mail.gmail.com>
References: <a343d7d11816d86d04c51505f6e33c5b99086ff6.1453244706.git.luto@kernel.org>
 <20160120194050.GL7192@pali> <CALCETrUqH7FLPyHasx020vyjZNtTdVSk+0LJKcGjXyj+iwE8Dw@mail.gmail.com>
 <20160130170411.GB1749@malice.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35901 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215AbcA3RSH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Jan 2016 12:18:07 -0500
Received: by mail-oi0-f52.google.com with SMTP id j125so1822008oih.3
        for <linux-acpi@vger.kernel.org>; Sat, 30 Jan 2016 09:18:07 -0800 (PST)
In-Reply-To: <20160130170411.GB1749@malice.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Jon Eyolfson <jon@eyl.io>

On Sat, Jan 30, 2016 at 9:04 AM, Darren Hart <dvhart@infradead.org> wro=
te:
> On Wed, Jan 20, 2016 at 12:46:23PM -0800, Andy Lutomirski wrote:
>> On Wed, Jan 20, 2016 at 11:40 AM, Pali Roh=C3=A1r <pali.rohar@gmail.=
com> wrote:
>> > On Tuesday 19 January 2016 15:07:47 Andy Lutomirski wrote:
>> >> The XPS 13 9350 sends WMI keypress events that aren't enumerated =
in
>> >> the DMI table.  Add a table listing them.  To avoid breaking thin=
gs
>> >> that worked before, these un-enumerated hotkeys won't be used if =
the
>> >> DMI table maps them to something else.
>> >>
>> >> FWIW, it appears that the DMI table may be a legacy thing and we
>> >> might want to rethink how we handle events in general.  As an
>> >> example, a whole lot of things map to KEY_PROG3 via the DMI table=
=2E
>> >>
>> >> So far, this doesn't send keypress events for any of the new
>> >> events.  Depnding on whether we figure out exactly what needs to
>> >> happen to get the wireless button working in time for Linux 4.5,
>> >> we might want to temporarily handle it in dell-wmi.
>> >>
>> >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> >
>> > Looks good,
>> >
>> > Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>>
>> Darren, if/when you apply this, can you fix up the last paragraph of
>> the commit message?
>>
>>     This doesn't send keypress events for any of the new
>>     events, as no models appear to require it.
>>
>> I wrote the old text before intel-hid landed.
>>
>> --Andy
>
> This had some problems applying to 4.5-rc1 (refactoring of handle_dmi=
_...). I've
> done the merge, it builds, but I can't test it. Please have a look at=
 the
> dell-wmi branch and let me know if this is correct and working as exp=
ected.
>

It's probably okay, but I think you applied it out of order.  This
patch was intended to be applied after the handle_dmi_xyz fixes.  If
you back this one out, apply those, and then re-apply this, it should
apply cleanly.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
