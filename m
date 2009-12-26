From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Regression in module wmi since 2.6.32 (bisected to commit 1caab3c)
Date: Sat, 26 Dec 2009 13:04:54 -0600
Message-ID: <4B365E56.9030302@lwfinger.net>
References: <4B352513.90302@lwfinger.net> <200912260118.26391.carlos@strangeworlds.co.uk> <4B362C95.4040700@lwfinger.net> <200912261836.41882.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:49359 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbZLZTE6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Dec 2009 14:04:58 -0500
In-Reply-To: <200912261836.41882.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Matthew Garrett <mjg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On 12/26/2009 12:36 PM, Carlos Corbacho wrote:
> On Saturday 26 December 2009 15:32:37 Larry Finger wrote:
>>> Initial patch below which takes the "ignore all duplicate GUIDs" approach.
>>
>> The patch fixes my machine.
> 
> Can you test this instead? It should actually do the right thing.

This one worked, and I got the message that there was a duplicate in the logs.

Larry
