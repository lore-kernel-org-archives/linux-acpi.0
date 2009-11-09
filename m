From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Mon, 9 Nov 2009 12:49:56 -0500
Message-ID: <cb0375e10911090949o4a51cfd5x4f896d983398a7bc@mail.gmail.com>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
	 <20091109165420.GA28672@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36210 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbZKIRtw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Nov 2009 12:49:52 -0500
Received: by bwz27 with SMTP id 27so3722190bwz.21
        for <linux-acpi@vger.kernel.org>; Mon, 09 Nov 2009 09:49:56 -0800 (PST)
In-Reply-To: <20091109165420.GA28672@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, ibm-acpi@hmh.eng.br

On Mon, Nov 9, 2009 at 11:54 AM, Matthew Garrett <mjg59@srcf.ucam.org> =
wrote:
> On Mon, Nov 09, 2009 at 11:47:30AM -0500, Andrew Lutomirski wrote:
>> The ThinkPad X200s, like the X61, requires OSI=3DLinux for the mute
>> button to work. =A0Without this patch (or the equivalent command-lin=
e
>> parameter), the mute button does not generate a keystroke and,
>> instead, messes up the sound hardware.
>
> No. How does this work on Windows? Note that we *have* a special driv=
er
> for Thinkpads, and it's entirely acceptable to require it in order to
> have sensible behaviour. We do not want to encourage vendors to
> special-case Linux.

The Thinkpad mixer is really weird AFAICT.  I have no idea how the
mute button works in Windows with the driver, but I'm not sure that it
looks like a key press -- I think it does something to the mixer and
the driver detects it.

cc: Henrique: can we fix this in thinkpad-acpi?

I actually think the "Linux" behavior makes more sense -- the volume
up and down buttons already work on all operating systems, and with
this patch the mute button works the same way.

There's precedent for this hack, and regardless of what we want to
convince Lenovo to do, making existing hardware work is nice:
http://bugzilla.kernel.org/show_bug.cgi?id=3D9907

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
