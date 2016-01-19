From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v3] dell-wmi: Support new hotkeys on the XPS 13 9350 (Skylake)
Date: Tue, 19 Jan 2016 15:03:33 -0800
Message-ID: <CALCETrXrtrsLX5gj_1BGNWnqTrFmKbWGWSBTgrjQwgCEn8USJA@mail.gmail.com>
References: <54397d72fbadcc340ca3ef1339c1a62fe0a07ab8.1453151401.git.luto@kernel.org>
 <20160119225007.GC3253@malice.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20160119225007.GC3253@malice.jf.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Jon Eyolfson <jon@eyl.io>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 19, 2016 at 2:50 PM, Darren Hart <dvhart@infradead.org> wrote:
> On Mon, Jan 18, 2016 at 01:14:58PM -0800, Andy Lutomirski wrote:
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
> Hi Andy, what did you apply this against? It doesn't apply to my current
> for-next, nor my rebased for-next.
>

It applies before the interface version stuff.  I can send a trivially
rebased version.

--Andy
