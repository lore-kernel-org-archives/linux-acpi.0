From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor register on resume
Date: Tue, 01 Jul 2008 22:52:07 +0200
Message-ID: <486A98F7.1080203@firstfloor.org>
References: <200807010148.02135.rjw@sisk.pl> <200807012239.44105.rjw@sisk.pl> <486A96C1.2020106@firstfloor.org> <200807012250.39930.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:35202 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755367AbYGAUwK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jul 2008 16:52:10 -0400
In-Reply-To: <200807012250.39930.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, kernel-testers@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

Rafael J. Wysocki wrote:
> On Tuesday, 1 of July 2008, Andi Kleen wrote:
>>> I have tested it on the nx6325 (64-bit) on top of the today's linux-next.  It
>>> works fine for me.
>> Could a few more people with different laptops please test too?
> 
> Well, I think we can put it into the 2.6.27 queue in the hope it gets more
> testing in linux-next over time.

I'm just not sure how many people really put linux-next on their laptops.
Better would be some directed testing.

We'll see if that kernel-testers list actually does something or is just a placebo.

-Andi
