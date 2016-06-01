From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 3/3] ACPI / button: Send "open" state after boot/resume
Date: Wed, 1 Jun 2016 10:07:40 +0200
Message-ID: <CAN+gG=GwPzNXn2Wfz5CV7e94r800CfUkAAUuYUDsspJboP25UA@mail.gmail.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
	<cover.1464332745.git.lv.zheng@intel.com>
	<4472be3d63af1b56c2f0f7cfbccd73538dc36252.1464332745.git.lv.zheng@intel.com>
	<CAN+gG=EaTOSbkx82HCYwLOtR9b_6291obNnpokJ2PhOXD8bWHw@mail.gmail.com>
	<1AE640813FDE7649BE1B193DEA596E883BBB5C64@SHSMSX101.ccr.corp.intel.com>
	<CAN+gG=Fzx0K6O4K9GRAjCe9Bg8-iGQhsYAiOdBZRpwoGeafRuw@mail.gmail.com>
	<1AE640813FDE7649BE1B193DEA596E883BBB6FAA@SHSMSX101.ccr.corp.intel.com>
	<1AE640813FDE7649BE1B193DEA596E883BBB71A8@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBB71A8@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Bastien Nocera:" <hadess@hadess.net>, "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 1, 2016 at 9:51 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
> [cut]
>> > We could have a parameter (say "send_lid_open_on_resume" or
>> > "use_bios_lid_value") in acpi/button.c which would allow people to
>> > choose if they want the "new" behavior or the old one. And we could
>> > also add some DMI matching for the messed up laptops/tablets where
>> we
>> > force one or the other quirk. When we agree that user space now
>> > behaves gently with us, we could then remove entirely the quirk and
>> > the dmi matching.
>> >
>> > How does that sound?
>> [Lv Zheng]
>> The choices are in my first revision.
>> I could restore it back and re-send this series.
>> Also I need to update PATCH 02 to eliminate wrong IS_ERR_VALUE().
> [Lv Zheng]
> I forgot to mention.
> IMO, if the issue is because of uncertain gaps, not a confirmed BIOS bug, or a confirmed gap that has to be solved in a spirit of compromise, we should not add quirks.
> We could just provide boot parameters for users to choose.
> Because the quirk table could grow bigger and bigger, exceeding our control.
>
> So I probably would just implement the parameter part, without adding the DMI entries.
>

Works for me. I think in Fedora, we might default to keep the current
behavior, but document that some tablets need the parameter to be set.
As soon as systemd changes its policy, we can change the default
value.


As for the Surface3, I think the LID state and irq is just not enough
robust to be used through the ACPI node PNP0C0D. I get all the
information from the touchscreen ACPI Node and the WMI, so I think
there might be a way to remove the standard ACPI LID and use our own,
or simply override the ACPI call by a different one (through the WMI).
It's a shame logind only expects one LID event node :).

Cheers,
Benjamin
