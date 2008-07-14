From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Mon, 14 Jul 2008 08:36:42 +0200
Message-ID: <20080714063642.GG31949@elf.ucw.cz>
References: <200807010148.02135.rjw@sisk.pl> <200807122253.32382.rjw@sisk.pl> <48793A0E.3050803@myrealbox.com> <200807130133.12324.rjw@sisk.pl> <20080713085603.GB6890@elf.ucw.cz> <487A4686.209@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52887 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbYGNGgB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jul 2008 02:36:01 -0400
Content-Disposition: inline
In-Reply-To: <487A4686.209@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andy Lutomirski <luto@myrealbox.com>, Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sun 2008-07-13 11:16:38, H. Peter Anvin wrote:
> Pavel Machek wrote:
>>
>> In such case, you could verify by disabling intel framebuffer and just
>> using plain VGA driver (or vesafb).
>>
>> Breaking video bios calls would be bad.
>
> It would... but it doesn't seem to make much sense.  What, in detail, does 
> this particular quirk do?

lcall 0xc000, 3 into the BIOS :-(.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
