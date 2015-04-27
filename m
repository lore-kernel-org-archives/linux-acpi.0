From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell Inspiron 7437
Date: Mon, 27 Apr 2015 16:30:11 +0800
Message-ID: <CAJ=jquYe97ObpE=3eTij705QsopnH4+hChssdj0qu7YFHGsSXg@mail.gmail.com>
References: <1429759476-13186-1-git-send-email-alex.hung@canonical.com>
	<20150424082115.GA3783@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33850 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbbD0IaL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Apr 2015 04:30:11 -0400
Received: by qkgx75 with SMTP id x75so58505877qkg.1
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2015 01:30:11 -0700 (PDT)
In-Reply-To: <20150424082115.GA3783@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

I don't have any Win8 media to test it but I will try to look for one.

I recalled that kernel 4.1rc has a patch "ACPICA: Permanently set _REV
to the value '2'" that may also change firmware's behaviours, but it
does not fix Inspiron 7437's ACPI event just for references.

On Fri, Apr 24, 2015 at 4:21 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Thu, Apr 23, 2015 at 11:24:35AM +0800, Alex Hung wrote:
>> Dell Inspiron 7437's ACPI events does not work well with Win8 OSI.
>> Disabling Win8 OSI can fix wireless hotkey and ACPI battery.
>
> Does this machine work if you actually install Windows 8 on it?
> --
> Matthew Garrett | mjg59@srcf.ucam.org



-- 
Cheers,
Alex Hung
