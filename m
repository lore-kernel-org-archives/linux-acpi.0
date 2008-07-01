From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Tue, 01 Jul 2008 15:01:55 +0200
Message-ID: <486A2AC3.2060107@firstfloor.org>
References: <200807010148.02135.rjw@sisk.pl> <20080701063133.GC16642@elte.hu> <4869D67B.4060902@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34659 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772AbYGANCC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jul 2008 09:02:02 -0400
In-Reply-To: <4869D67B.4060902@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@elte.hu>, "Rafael J. Wysocki" <rjw@sisk.pl>, kernel-testers@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>


> 
> It still seems incredibly risky to push this for 2.6.26, especially
> given the Elan revelation.

Do Elans even support S3?

>  I think it needs to be tested on the 2.6.27
> track, and then possibly be pushed back via the 2.6.26-stable route.

I'm just not sure how many suspend/resume cycles people really do
on a early (pre -rc) mainline kernel (or in linux-next for that
matter). You usually have to install on a laptop and actually
use it.

Since this code is only executed on resume some directed testing
would be better. That is what Rafael asked for in this mail.

I think it would be ok for .26 if we can get confirmation it works
on a few systems with S3 suspend/resume.

-Andi

