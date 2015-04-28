From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / blacklist: blacklist Win8 OSI for Dell Inspiron
 7437
Date: Tue, 28 Apr 2015 06:24:48 +0100
Message-ID: <20150428052448.GA3458@srcf.ucam.org>
References: <1429759476-13186-1-git-send-email-alex.hung@canonical.com>
 <20150424082115.GA3783@srcf.ucam.org>
 <CAJ=jquYe97ObpE=3eTij705QsopnH4+hChssdj0qu7YFHGsSXg@mail.gmail.com>
 <20150427174646.GA22664@srcf.ucam.org>
 <CAJ=jquZ7wTNBMEwZaxKRd6B2iC6qaum5h+oW=Qf364+xhs20kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37332 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbbD1FYw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2015 01:24:52 -0400
Content-Disposition: inline
In-Reply-To: <CAJ=jquZ7wTNBMEwZaxKRd6B2iC6qaum5h+oW=Qf364+xhs20kg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux ACPI Mailing List <linux-acpi@vger.kernel.org>

On Tue, Apr 28, 2015 at 12:53:10PM +0800, Alex Hung wrote:
> I tried Windows 8.1 Pro, and it seems that wireless hotkey works fine
> (with AirplaneMode driver installed) and ACPI battery works fine too.
> I didn't observe similar ACPI interrupt problems that occur on Linux.

Ok, sounds like we've got another problem somewhere. Do you have the 
acpidump?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
