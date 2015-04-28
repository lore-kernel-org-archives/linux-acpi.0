From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell Inspiron
 7437
Date: Tue, 28 Apr 2015 18:11:00 +0100
Message-ID: <20150428171100.GA24599@srcf.ucam.org>
References: <1429759476-13186-1-git-send-email-alex.hung@canonical.com>
 <20150424082115.GA3783@srcf.ucam.org>
 <CAJ=jquYe97ObpE=3eTij705QsopnH4+hChssdj0qu7YFHGsSXg@mail.gmail.com>
 <20150427174646.GA22664@srcf.ucam.org>
 <CAJ=jquZ7wTNBMEwZaxKRd6B2iC6qaum5h+oW=Qf364+xhs20kg@mail.gmail.com>
 <20150428052448.GA3458@srcf.ucam.org>
 <CAJ=jquYYDixG7-XtVJRvuHDWHgF3Ww3fiafDbmgD5KY8QJjeQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:46748 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030470AbbD1RLD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2015 13:11:03 -0400
Content-Disposition: inline
In-Reply-To: <CAJ=jquYYDixG7-XtVJRvuHDWHgF3Ww3fiafDbmgD5KY8QJjeQQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

With Windows 8 enabled you're going down this path:

        If (_OSI (WIN8))
        {
            Local0 = 0x81
        }

With it blacklisted, you're going down this path:

        If (_OSI (WIN7))
        {
            Local0 = 0x80
            Local1 = _REV /* \_REV */
            If ((Local1 == 0x05))
            {
                Local0 = 0x40
            }
        }

So your guess about _REV was actually correct - if the OS claims to be 
Windows 7 and returns 5 to _REV, it'll let Local0 to 0x40. This results 
in:

        If ((Local0 == 0x40))
        {
            MIS0 = SMI (0x98, Zero)
            MIS0 &= 0x13
        }

MIS0 appears to be involved in various event delivery paths, so my 
suspicion is that the firmware is deliberately working around a quirk of 
Linux behaviour in order to deliver events appropriately. If so, your 
patch won't help in 4.1 because _REV now returns 2, and so we need to 
root cause the actual problem and fix that instead.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
