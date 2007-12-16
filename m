From: Jan Willies <jan@willies.info>
Subject: Re: No battery status with 2.6.24-rcX anymore
Date: Sun, 16 Dec 2007 13:58:38 +0100
Message-ID: <476520FE.4080101@willies.info>
References: <4762C081.4010000@willies.info> <200712141504.41707.lenb@kernel.org> <476408D2.1060205@willies.info> <200712160030.08991.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from will39.synserver.de ([212.40.172.10]:40432 "EHLO
	will39.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbXLPM7x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Dec 2007 07:59:53 -0500
In-Reply-To: <200712160030.08991.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
> On Saturday, 15 of December 2007, Jan Willies wrote:
>> Len Brown wrote:
>>> On Friday 14 December 2007 12:42, Jan Willies wrote:
>>>
>>>> ACPI: Table DSDT replaced by host OS
>>> Sorry, can't help you if you are running a modified BIOS.
>> Uh sorry, I totally forgot about that. It's just some compile errors fixed with intel compiler [1] and a little undervolting [2], don't know if it matters at all. Here is a clean log:
> [--snip--]
>> What else information is needed?
> 
> Have you tested the latest Linus' tree?  We've had some ACPI fixes recently.

Latest as in 2.6.24-rc5-git3? Because I can't see any acpi changes in the shortlog [1] since 2.6.24-rc5.


- Jan

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=shortlog
