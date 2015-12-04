From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 2/3] dell-wmi: Support new hotkeys on the XPS 13 9350 (Skylake)
Date: Thu, 3 Dec 2015 16:00:54 -0800
Message-ID: <CALCETrUeW3XOYBGwGSvFswQg8SuQCQkvg5sMkmivEDrjhoit+g@mail.gmail.com>
References: <cover.1448931589.git.luto@kernel.org> <d9ff5adc7e496b7714202785f8279af313bbcc59.1448931589.git.luto@kernel.org>
 <20151203235211.GD1800@malice.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35474 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbbLDABP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2015 19:01:15 -0500
Received: by igl9 with SMTP id 9so22509530igl.0
        for <linux-acpi@vger.kernel.org>; Thu, 03 Dec 2015 16:01:14 -0800 (PST)
In-Reply-To: <20151203235211.GD1800@malice.jf.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>

On Thu, Dec 3, 2015 at 3:52 PM, Darren Hart <dvhart@infradead.org> wrote:
> On Mon, Nov 30, 2015 at 05:02:00PM -0800, Andy Lutomirski wrote:
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
>> ---
>>  drivers/platform/x86/dell-wmi.c | 59 ++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 52 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
>> index ad6e965c5862..baff658a3621 100644
>> --- a/drivers/platform/x86/dell-wmi.c
>> +++ b/drivers/platform/x86/dell-wmi.c
>> @@ -161,6 +161,27 @@ static const u16 bios_to_linux_keycode[256] __initconst = {
>>       [255]   = KEY_PROG3,
>>  };
>>
>> +/* These are applied if the hk table is present and doesn't override them. */
>
>
> Please do not abbreviate in comments.

Will fix for v3.

>
>
>> +static const struct key_entry dell_wmi_extra_keymap[] __initconst = {
>> +     /* Fn-lock */
>> +     { KE_IGNORE, 0x151, { KEY_RESERVED } },
>> +
>> +     /* Change keyboard illumination */
>> +     { KE_IGNORE, 0x152, { KEY_KBDILLUMTOGGLE } },
>> +
>> +     /*
>> +      * Radio disable (notify only -- there is no model for which the
>> +      * WMI event is supposed to trigger an action.
>> +      */
>> +     { KE_IGNORE, 0x153, { KEY_RFKILL } },
>> +
>> +     /* RGB keyboard backlight control */
>> +     { KE_IGNORE, 0x154, { KEY_RESERVED } },
>> +
>> +     /* Stealth mode toggle */
>> +     { KE_IGNORE, 0x155, { KEY_RESERVED } },
>> +};
>> +
>>  static struct input_dev *dell_wmi_input_dev;
>>
>>  static void dell_wmi_process_key(int reported_key)
>> @@ -319,9 +340,10 @@ static const struct key_entry * __init dell_wmi_prepare_new_keymap(void)
>>       int hotkey_num = (dell_bios_hotkey_table->header.length - 4) /
>>                               sizeof(struct dell_bios_keymap_entry);
>>       struct key_entry *keymap;
>> -     int i;
>> +     int i, pos = 0, num_bios_keys;
>>
>> -     keymap = kcalloc(hotkey_num + 1, sizeof(struct key_entry), GFP_KERNEL);
>> +     keymap = kcalloc(hotkey_num + ARRAY_SIZE(dell_wmi_extra_keymap),
>> +                      sizeof(struct key_entry), GFP_KERNEL);
>
> Did something change since our last round of review making the +1 for KE_END
> no longer necessary? It looks like it should be possible to use all the bios
> hotkey keymap and all the extra keymap, so we would still need +1 for KE_END.

No, my bad.  That's embarrassing :(

--Andy
