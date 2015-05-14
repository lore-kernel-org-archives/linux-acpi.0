From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell
 Inspiron 7437
Date: Thu, 14 May 2015 20:13:59 +0100
Message-ID: <20150514191358.GB23853@srcf.ucam.org>
References: <1429759476-13186-1-git-send-email-alex.hung@canonical.com>
 <20150424082115.GA3783@srcf.ucam.org>
 <CAJ=jquYe97ObpE=3eTij705QsopnH4+hChssdj0qu7YFHGsSXg@mail.gmail.com>
 <20150427174646.GA22664@srcf.ucam.org>
 <CAJ=jquZ7wTNBMEwZaxKRd6B2iC6qaum5h+oW=Qf364+xhs20kg@mail.gmail.com>
 <20150428052448.GA3458@srcf.ucam.org>
 <CAJ=jquYYDixG7-XtVJRvuHDWHgF3Ww3fiafDbmgD5KY8QJjeQQ@mail.gmail.com>
 <20150428171100.GA24599@srcf.ucam.org>
 <CAJ=jquZMMBNsKO2CZe649OcXTBxfzO43gkxwkJn2mvHhnp+zSQ@mail.gmail.com>
 <5554F12A.3010003@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52179 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964981AbbENTOD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2015 15:14:03 -0400
Content-Disposition: inline
In-Reply-To: <5554F12A.3010003@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Alex Hung <alex.hung@canonical.com>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Thu, May 14, 2015 at 02:02:02PM -0500, Mario Limonciello wrote:

> * Battery information was not displayed in the OS.  The BIOS team
> found that the Linux wasn't asking for battery information in the OS
> in the same way that Windows does.  The delta path creates a SMI
> event to get battery information.

Huh. Is there any chance we can find out what the difference is so we 
can make them equivalent?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
