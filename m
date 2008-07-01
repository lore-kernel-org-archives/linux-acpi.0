From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Tue, 01 Jul 2008 10:28:48 -0700
Message-ID: <486A6950.6050507@zytor.com>
References: <200807010148.02135.rjw@sisk.pl> <20080701063133.GC16642@elte.hu> <4869D67B.4060902@zytor.com> <486A2AC3.2060107@firstfloor.org> <486A5378.7020601@zytor.com> <486A5977.8020905@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45270 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYGAR3c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jul 2008 13:29:32 -0400
In-Reply-To: <486A5977.8020905@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Ingo Molnar <mingo@elte.hu>, "Rafael J. Wysocki" <rjw@sisk.pl>, kernel-testers@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

Andi Kleen wrote:
> H. Peter Anvin wrote:
>> Andi Kleen wrote:
>>>> It still seems incredibly risky to push this for 2.6.26, especially
>>>> given the Elan revelation.
>>> Do Elans even support S3?
>> I don't know if they do, but I don't know offhand the extent of machines
>> that may have that problem, especially since Intel now document it as
>> "failures are readily seen".
> 
> What document is that exactly?
> 

Per Jeremy's recent email, volume 3a, section 8.9.1:

>    Random failures can occur if other instructions exist between steps
>    3 and 4 above.  Failures will be readily seen in some situations,
>    such as when instructions that reference memory are inserted between
>    steps 3 and 4 while in system management mode. 

	-hpa
