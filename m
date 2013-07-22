From: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Subject: Re: Linux 3.11-rc2
Date: Mon, 22 Jul 2013 17:43:13 +0200
Message-ID: <51ED5311.7070200@mni.thm.de>
References: <CA+55aFy330bSRjK5HT1n0wXioPykL3RquHXyBPjm5GpTz_Y=DQ@mail.gmail.com> <51EC4D77.2010502@mni.thm.de> <2494093.OzngazxDQW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2494093.OzngazxDQW@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 22.07.2013 15:08, Rafael J. Wysocki wrote:
> On Sunday, July 21, 2013 11:07:03 PM Tobias Klausmann wrote:
>> On 21.07.2013 21:53, Linus Torvalds wrote:
>>> So it's been another week, and -rc2 is out there.
>> ...
>>>    (b) we had a late change to how ACPI backlight handling is done on
>>> certain machines, and while this kind of thing really shouldn't be
>>> done outside the merge window, I ended up pulling it anyway. But I'd
>>> *really* like to have people test this thing particularly on laptops
>>> with intel-based graphics. It should only matter (and hopefully
>>> improve things) for the newer ones with BIOSes designed for Windows 8,
>>> but hey, the more testing, the better. Backlight handling has been
>>> painful before, so I'm mentioning this explicitly.
>>>
>> This pach finally fixes my backlight control!
> Yes, it fixes that for a number of people, which is the reason why I send
> the pull request in the first place, but it also turns out to break things
> for some people and therefore it'll have to be reverted.
>
> We're still going to work on that, though.
>
> Thanks,
> Rafael
>
>
If you have new patches ready for this and you want them to be tested, 
let me know!

Thanks,
Tobias
