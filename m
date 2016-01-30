From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4] dell-wmi: Support new hotkeys on the XPS 13 9350 (Skylake)
Date: Sat, 30 Jan 2016 09:58:57 -0800
Message-ID: <CALCETrVTvxXngMxg4Vnxma74NRU=EvXczPFfqCH=zTZ4CMnJ7g@mail.gmail.com>
References: <a343d7d11816d86d04c51505f6e33c5b99086ff6.1453244706.git.luto@kernel.org>
 <20160120194050.GL7192@pali> <CALCETrUqH7FLPyHasx020vyjZNtTdVSk+0LJKcGjXyj+iwE8Dw@mail.gmail.com>
 <20160130170411.GB1749@malice.jf.intel.com> <CALCETrVZ06EpseG9Rkr59rB4QboAJhMEremQrQ1oLxxNrDTKWA@mail.gmail.com>
 <20160130174545.GD9269@malice.jf.intel.com> <20160130175640.GA1862@malice.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36015 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbcA3R7R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Jan 2016 12:59:17 -0500
Received: by mail-ob0-f177.google.com with SMTP id ba1so88417771obb.3
        for <linux-acpi@vger.kernel.org>; Sat, 30 Jan 2016 09:59:17 -0800 (PST)
In-Reply-To: <20160130175640.GA1862@malice.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Jon Eyolfson <jon@eyl.io>

On Sat, Jan 30, 2016 at 9:56 AM, Darren Hart <dvhart@infradead.org> wro=
te:
> On Sat, Jan 30, 2016 at 09:45:45AM -0800, Darren Hart wrote:
>> On Sat, Jan 30, 2016 at 09:17:47AM -0800, Andy Lutomirski wrote:
>> > On Sat, Jan 30, 2016 at 9:04 AM, Darren Hart <dvhart@infradead.org=
> wrote:
>> > > On Wed, Jan 20, 2016 at 12:46:23PM -0800, Andy Lutomirski wrote:
>> > >> On Wed, Jan 20, 2016 at 11:40 AM, Pali Roh=C3=A1r <pali.rohar@g=
mail.com> wrote:
>> > >> > On Tuesday 19 January 2016 15:07:47 Andy Lutomirski wrote:
>> > >> >> The XPS 13 9350 sends WMI keypress events that aren't enumer=
ated in
>> > >> >> the DMI table.  Add a table listing them.  To avoid breaking=
 things
>> > >> >> that worked before, these un-enumerated hotkeys won't be use=
d if the
>> > >> >> DMI table maps them to something else.
>> > >> >>
>> > >> >> FWIW, it appears that the DMI table may be a legacy thing an=
d we
>> > >> >> might want to rethink how we handle events in general.  As a=
n
>> > >> >> example, a whole lot of things map to KEY_PROG3 via the DMI =
table.
>> > >> >>
>> > >> >> So far, this doesn't send keypress events for any of the new
>> > >> >> events.  Depnding on whether we figure out exactly what need=
s to
>> > >> >> happen to get the wireless button working in time for Linux =
4.5,
>> > >> >> we might want to temporarily handle it in dell-wmi.
>> > >> >>
>> > >> >> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> > >> >
>> > >> > Looks good,
>> > >> >
>> > >> > Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>> > >>
>> > >> Darren, if/when you apply this, can you fix up the last paragra=
ph of
>> > >> the commit message?
>> > >>
>> > >>     This doesn't send keypress events for any of the new
>> > >>     events, as no models appear to require it.
>> > >>
>> > >> I wrote the old text before intel-hid landed.
>> > >>
>> > >> --Andy
>> > >
>> > > This had some problems applying to 4.5-rc1 (refactoring of handl=
e_dmi_...). I've
>> > > done the merge, it builds, but I can't test it. Please have a lo=
ok at the
>> > > dell-wmi branch and let me know if this is correct and working a=
s expected.
>> > >
>> >
>> > It's probably okay, but I think you applied it out of order.  This
>> > patch was intended to be applied after the handle_dmi_xyz fixes.  =
If
>> > you back this one out, apply those, and then re-apply this, it sho=
uld
>> > apply cleanly.
>> >
>> > --Andy
>>
>> Ah, thanks. Sometimes that gets lost in the INBOX, I was starting to=
 think the
>> same thing as I went through the patchwork list though. I'll back it=
 out and do
>> that. Thanks!
>
> Turns out I wasn't Cc'd on the dependent dmi fixes series. Please inc=
lude me on
> Cc for patches where I show up as a maintainer.
>

Oops.  I cc'd platform-driver-x86@vger.kernel.org and assumed that was
sufficient.  Sorry.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
