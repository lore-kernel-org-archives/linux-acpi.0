From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell Inspiron 7437
Date: Tue, 28 Apr 2015 17:51:12 +0800
Message-ID: <CAJ=jquYYDixG7-XtVJRvuHDWHgF3Ww3fiafDbmgD5KY8QJjeQQ@mail.gmail.com>
References: <1429759476-13186-1-git-send-email-alex.hung@canonical.com>
	<20150424082115.GA3783@srcf.ucam.org>
	<CAJ=jquYe97ObpE=3eTij705QsopnH4+hChssdj0qu7YFHGsSXg@mail.gmail.com>
	<20150427174646.GA22664@srcf.ucam.org>
	<CAJ=jquZ7wTNBMEwZaxKRd6B2iC6qaum5h+oW=Qf364+xhs20kg@mail.gmail.com>
	<20150428052448.GA3458@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36125 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454AbbD1JvO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2015 05:51:14 -0400
Received: by lbbqq2 with SMTP id qq2so102783112lbb.3
        for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2015 02:51:12 -0700 (PDT)
In-Reply-To: <20150428052448.GA3458@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

Matthew,

Its acpidump is available @ http://people.canonical.com/~alexhung/LP1435731/


On Tue, Apr 28, 2015 at 1:24 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, Apr 28, 2015 at 12:53:10PM +0800, Alex Hung wrote:
>> I tried Windows 8.1 Pro, and it seems that wireless hotkey works fine
>> (with AirplaneMode driver installed) and ACPI battery works fine too.
>> I didn't observe similar ACPI interrupt problems that occur on Linux.
>
> Ok, sounds like we've got another problem somewhere. Do you have the
> acpidump?
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org



-- 
Cheers,
Alex Hung
