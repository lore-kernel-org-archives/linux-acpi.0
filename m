From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Tue, 01 Jul 2008 08:55:36 -0700
Message-ID: <486A5378.7020601@zytor.com>
References: <200807010148.02135.rjw@sisk.pl> <20080701063133.GC16642@elte.hu> <4869D67B.4060902@zytor.com> <486A2AC3.2060107@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:53674 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbYGAP5P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jul 2008 11:57:15 -0400
In-Reply-To: <486A2AC3.2060107@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Ingo Molnar <mingo@elte.hu>, "Rafael J. Wysocki" <rjw@sisk.pl>, kernel-testers@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

Andi Kleen wrote:
>> It still seems incredibly risky to push this for 2.6.26, especially
>> given the Elan revelation.
> 
> Do Elans even support S3?

I don't know if they do, but I don't know offhand the extent of machines 
that may have that problem, especially since Intel now document it as 
"failures are readily seen".

>>  I think it needs to be tested on the 2.6.27
>> track, and then possibly be pushed back via the 2.6.26-stable route.
> 
> I'm just not sure how many suspend/resume cycles people really do
> on a early (pre -rc) mainline kernel (or in linux-next for that
> matter). You usually have to install on a laptop and actually
> use it.
 >
> Since this code is only executed on resume some directed testing
> would be better. That is what Rafael asked for in this mail.

The issue is mostly if it breaks some obscure system.  I have put it on 
my laptop, Ingo has it on this test system with a suspend-testing cycle, 
and so on, but the number of systems exposed is going to be small.

> I think it would be ok for .26 if we can get confirmation it works
> on a few systems with S3 suspend/resume.

That we already know it does, but it took a long time even until the 
regression came to light.

	-hpa

