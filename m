From: Azael Avalos <coproscefalo@gmail.com>
Subject: Re: PROBLEM: Toshiba R700 backlight control lost on resume
Date: Mon, 27 Oct 2014 11:02:48 -0600
Message-ID: <CAGdLNWHY6M8TB7ekQEW3=1JUAogLN6zbmsmSXqHYXtRVUUXf7w@mail.gmail.com>
References: <CAN4ACkZtQvHCTikvz5Kh9Sk7s+88Aw9-D-XgfMJ7XbuBs+_70Q@mail.gmail.com>
	<CAGdLNWGuosjFf-DZet2XrgPiSCq-Ap9qW6GuJZ7-7QYwxjTVQw@mail.gmail.com>
	<CAN4ACka7uCuwM8AiB-r_zodjb1xtsr7r_fw0+nKtqtP-sBQx2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:63998 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbaJ0RCt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Oct 2014 13:02:49 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so3506499wiv.15
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2014 10:02:48 -0700 (PDT)
In-Reply-To: <CAN4ACka7uCuwM8AiB-r_zodjb1xtsr7r_fw0+nKtqtP-sBQx2w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Pater <alan.pater@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi there,


After reading (quite a lot of) posts linked on the bug reports,
I'll try to make a patch for you to test later today when I'm
back home. Which, let's hope it solves your issues.


Cheers
Azael


2014-10-27 9:46 GMT-06:00 Alan Pater <alan.pater@gmail.com>:
> No, I need to use /sys/class/backlight/intel_backlight/brightness to
> control the backlight after resume.
>
> On Mon, Oct 27, 2014 at 10:39 AM, Azael Avalos <coproscefalo@gmail.com> wrote:
>>
>> So, the backlight device (/sys/class/backlight/toshiba/brightness) can still
>> be used to change brightness, but not via the hotkeys on resume?
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
-- El mundo apesta y vosotros apestais tambien --
