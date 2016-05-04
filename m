From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 08/15] ACPICA: Dispatcher: Update thread ID for recursive
 method calls
Date: Wed, 4 May 2016 22:45:37 +0200
Message-ID: <CAJZ5v0hZp_ZDkN7K=Ovr4EHTfE=GAB6n891N4n-VSUvnbQWTxA@mail.gmail.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
	<b1748e389752c1f7d499770dea3fe5f4950aaecc.1462331121.git.lv.zheng@intel.com>
	<572A10CE.20106@redhat.com>
	<CAJZ5v0j=4pGH-0guSQnVYTFo=zZ66duS8MrYmjxBtEy55Do=8Q@mail.gmail.com>
	<d28841bfa9d947c39a1cf54622299be8@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34233 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752820AbcEDUpj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 May 2016 16:45:39 -0400
In-Reply-To: <d28841bfa9d947c39a1cf54622299be8@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <Mario_Limonciello@dell.com>, Prarit Bhargava <prarit@redhat.com>, Lv <lv.zheng@intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, =?UTF-8?B?5b6L6YOR?= <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Andy Lutomirski <luto@kernel.org>

On Wed, May 4, 2016 at 10:30 PM,  <Mario_Limonciello@dell.com> wrote:
>> -----Original Message-----
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
>> Rafael J. Wysocki
>> Sent: Wednesday, May 4, 2016 2:23 PM
>> To: Prarit Bhargava <prarit@redhat.com>
>> Cc: Lv Zheng <lv.zheng@intel.com>; Rafael J. Wysocki
>> <rafael.j.wysocki@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Len
>> Brown <len.brown@intel.com>; Lv Zheng <zetalog@gmail.com>; Linux
>> Kernel Mailing List <linux-kernel@vger.kernel.org>; ACPI Devel Maling List
>> <linux-acpi@vger.kernel.org>; Bob Moore <robert.moore@intel.com>;
>> Limonciello, Mario <Mario_Limonciello@Dell.com>; stable
>> <stable@vger.kernel.org>
>> Subject: Re: [PATCH 08/15] ACPICA: Dispatcher: Update thread ID for
>> recursive method calls
>>
>> On Wed, May 4, 2016 at 5:10 PM, Prarit Bhargava <prarit@redhat.com>
>> wrote:
>> >
>> >
>> > On 05/04/2016 01:48 AM, Lv Zheng wrote:
>> >> From: Prarit Bhargava <prarit@redhat.com>
>> >>
>> >> ACPICA commit 7a3bd2d962f221809f25ddb826c9e551b916eb25
>> >>
>> >> Set the mutex owner thread ID.
>> >> Original patch from: Prarit Bhargava <prarit@redhat.com>
>> >>
>> >> Link: https://github.com/acpica/acpica/commit/7a3bd2d9
>> >> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> >> Signed-off-by: Bob Moore <robert.moore@intel.com>
>> >> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>> >
>> > cc'ing Mario @ Dell and stable.
>>
>> It won't help if you CC stable at this point.
>>
>> What stable series should this go into?
>
> At least I was really hoping to see this land in kernels that are in the common distros today: 4.4, 4.2 and 3.19.
>

OK, let's make it "all applicable", then.

Applied and queued up as a fix for v4.6, thanks everybody!
