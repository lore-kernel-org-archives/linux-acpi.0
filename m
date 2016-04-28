From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] ACPI: fix Thunderbolt hotplug
Date: Thu, 28 Apr 2016 11:46:42 -0700
Message-ID: <CALCETrVoVS2rt6jeM_crgXPe5GTRu67N8=xi+TyS2aEQfXSpMQ@mail.gmail.com>
References: <1461760019-12930-1-git-send-email-prarit@redhat.com>
 <b80830ab-20b4-bd75-5331-4ad55cbff355@kernel.org> <0502496faa2f494a8d81e4789fa2a77e@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <0502496faa2f494a8d81e4789fa2a77e@ausx13mpc120.AMER.DELL.COM>
Sender: stable-owner@vger.kernel.org
To: Mario Limonciello <Mario_Limonciello@dell.com>
Cc: Andrew Lutomirski <luto@kernel.org>, Prarit Bhargava <prarit@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, stable <stable@vger.kernel.org>, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 28, 2016 at 11:44 AM,  <Mario_Limonciello@dell.com> wrote:
>
>
>> -----Original Message-----
>> From: Andy Lutomirski [mailto:luto@kernel.org]
>> Sent: Thursday, April 28, 2016 1:39 PM
>> To: Prarit Bhargava <prarit@redhat.com>; linux-kernel@vger.kernel.org
>> Cc: Robert Moore <robert.moore@intel.com>; Lv Zheng
>> <lv.zheng@intel.com>; Rafael J. Wysocki <rafael.j.wysocki@intel.com>; Len
>> Brown <lenb@kernel.org>; linux-acpi@vger.kernel.org; Limonciello, Mario
>> <Mario_Limonciello@Dell.com>; stable@vger.kernel.org; devel@acpica.org
>> Subject: Re: [PATCH] ACPI: fix Thunderbolt hotplug
>>
>> On 04/27/2016 05:26 AM, Prarit Bhargava wrote:
>> > Rafael, this patch is in the acpica.git tree as 7a3bd2d ("Dispatcher:
>> > Update thread ID for recursive method calls").  I've had many positive
>> > testing results from hardware vendors and users with this patch and
>> > this resolves many of the problems seen here:
>> >
>> > https://bugzilla.kernel.org/show_bug.cgi?id=115121
>> >
>> > This does not fix the problems with the TB docking station.  Although
>> > this patch will also be required, the docking station issues require a FW
>> update.
>> > Updated FW should be coming soon to resolve those problems.
>> >
>>
>> No kidding!?!  Will that update be installable from Linux?  If so, could you cc
>> me on that?
>>
>
>
> This patch does let the dock hotplug properly after the BIOS fix is applied.
>
> For the dock devices not showing up on the other side of the thunderbolt bridge:
> It's going to be a system firmware update for both the XPS 9350 and Precision 5510.  It will get distributed to LVFS and can be loaded up with fwupd/fwupdate.
> I don't yet have an ETA that I can share other than "Next BIOS release"
>
> After the update, set Thunderbolt Security to "No Security" and devices should be available.

Great!

Does this mean that I won't need to boot into Windows and run the
little Intel tool to update the Alpine Ridge firmware?  I.e. will the
LVFS / EFI executable do that part?

--Andy

>
> Thanks,
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
