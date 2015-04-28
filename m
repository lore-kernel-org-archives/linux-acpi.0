From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell Inspiron 7437
Date: Tue, 28 Apr 2015 12:53:10 +0800
Message-ID: <CAJ=jquZ7wTNBMEwZaxKRd6B2iC6qaum5h+oW=Qf364+xhs20kg@mail.gmail.com>
References: <1429759476-13186-1-git-send-email-alex.hung@canonical.com>
	<20150424082115.GA3783@srcf.ucam.org>
	<CAJ=jquYe97ObpE=3eTij705QsopnH4+hChssdj0qu7YFHGsSXg@mail.gmail.com>
	<20150427174646.GA22664@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:36344 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbbD1ExK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2015 00:53:10 -0400
Received: by qcpm10 with SMTP id m10so65342766qcp.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2015 21:53:10 -0700 (PDT)
In-Reply-To: <20150427174646.GA22664@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

I tried Windows 8.1 Pro, and it seems that wireless hotkey works fine
(with AirplaneMode driver installed) and ACPI battery works fine too.
I didn't observe similar ACPI interrupt problems that occur on Linux.

On Tue, Apr 28, 2015 at 1:46 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Mon, Apr 27, 2015 at 04:30:11PM +0800, Alex Hung wrote:
>> I don't have any Win8 media to test it but I will try to look for one.
>>
>> I recalled that kernel 4.1rc has a patch "ACPICA: Permanently set _REV
>> to the value '2'" that may also change firmware's behaviours, but it
>> does not fix Inspiron 7437's ACPI event just for references.
>
> The _REV behaviour didn't change between Windows 7 and 8, so it
> shouldn't be relevant here.
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org



-- 
Cheers,
Alex Hung
