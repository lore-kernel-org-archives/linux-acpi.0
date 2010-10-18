From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH] ACPI: Read TSC upon resume
Date: Mon, 18 Oct 2010 10:41:48 +0800
Message-ID: <4CBBB3EC.9000609@linux.intel.com>
References: <1286406919-6236-1-git-send-email-snanda@chromium.org> <AANLkTik=imw5XRpXSkboyB6txXio6Y65bLV+EdfvRXg3@mail.gmail.com> <20101007181536.GA24811@suse.de> <201010072344.22166.rjw@sisk.pl> <E92FAF79A8BBC642A36EEE3AA7F152D884DB9CA072@GVW1089EXB.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41380 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321Ab0JRCly (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Oct 2010 22:41:54 -0400
In-Reply-To: <E92FAF79A8BBC642A36EEE3AA7F152D884DB9CA072@GVW1089EXB.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Koornstra, Reinoud" <koornstra@hp.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <gregkh@suse.de>, Sameer Nanda <snanda@chromium.org>, "lenb@kernel.org" <lenb@kernel.org>, "stefan.bader@canonical.com" <stefan.bader@canonical.com>, "brad.figg@canonical.com" <brad.figg@canonical.com>, "apw@canonical.com" <apw@canonical.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

=E4=BA=8E 10/16/2010 11:03 AM, Koornstra, Reinoud =E5=86=99=E9=81=93:
>> -----Original Message-----
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>> owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
>> Sent: Thursday, October 07, 2010 2:44 PM
>> To: Greg KH
>> Cc: Sameer Nanda; lenb@kernel.org; stefan.bader@canonical.com;
>> brad.figg@canonical.com; apw@canonical.com; linux-acpi@vger.kernel.o=
rg;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] ACPI: Read TSC upon resume
>>
>> On Thursday, October 07, 2010, Greg KH wrote:
>>> On Thu, Oct 07, 2010 at 11:05:21AM -0700, Sameer Nanda wrote:
>>>> On Thu, Oct 7, 2010 at 10:46 AM, Greg KH<gregkh@suse.de>  wrote:
>>>>> On Thu, Oct 07, 2010 at 10:43:34AM -0700, Sameer Nanda wrote:
>>>>>> On Wed, Oct 6, 2010 at 7:19 PM, Greg KH<gregkh@suse.de>  wrote:
>>>>>>> And are you always going to be printing this out?  Why do we
>> want to
>>>>>>> know this every time?
>>>>>>>
>>>>>>
>>>>>> Yes, every time.  This helps track variance in BIOS resume times
>> within a
>>>>>> single boot.
>>>>>
>>>>> Is that really something that users can do something about?
>>>>
>>>> Aside from complaining to the BIOS vendors, no :)
>>>
>>> Then I would not recommend adding this patch, as it is irrelevant f=
or
>>> 99.9999% of all Linux users.
>>
>> It may be somewhat useful, but the rdtscll() call seems to be x86-
>> specific, in
>> which case it shouldn't be used at this place.
>
> Also, in the case of an intel core 2 duo cpu, the tsc is not stable, =
hence upon resume the cpu is spinning up and the first tsc's will be sl=
ower.
> During idle-time the tsc will not be incremented. The tsc is only sta=
bly incremented upon 100% cpu usage. It also doesn't increment faster i=
n turbo mode in case of some core 2 duo and certainly the Nehalem cpu's=
=2E Calculating in time in terms of tsc might not be so reliable.
>
If I'm wrong, please feel free to fix me.

I have 2 questions to your answer:

1.  CPU has a flag named constant_tsc to keep TSC always working in a=20
constant way, so it is irrelvant to the CPU freq. whether in turbo mode=
=20
or any P-state CPU currently belongs to, TSC should be not affected.=20
IIRC, this flag should exist long before, at least before Core 2 duo. I=
f=20
so, TSC shoule be stable in this kind of environment.

2. though during idle-time TSC will not be incremented, here I want to
remind it is right before Westmere (TSC not always running), and you=20
mentioned "upon resume the cpu is spinning up and the first tsc's will=20
be slower", I don't know if this commit cd7240c0b can fix it up.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
