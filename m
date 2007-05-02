From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: ACPI/APIC bug
Date: Wed, 02 May 2007 18:22:55 +0200
Message-ID: <4638BADF.5080900@tzi.de>
References: <46389B41.3060204@tzi.de> <20070502154427.GA18127@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:42539 "EHLO
	informatik.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S2993480AbXEBQW6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2007 12:22:58 -0400
In-Reply-To: <20070502154427.GA18127@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org



Henrique de Moraes Holschuh schrieb:
> On Wed, 02 May 2007, Janosch Machowinski wrote:
>> can someone with more knowledge than me please take a look at this bug :
>> http://bugzilla.kernel.org/show_bug.cgi?id=8367
>> and say weather this is a bios or linux bug.
> 
> It is about a bug on a ASUS M6Ne laptop, which hard-locks if the lapic is
> used.  Booting with nolapic fixes the crash.
> 
> Janosh, does your M6Ne also crashes hard if the lapic is enabled? That
> information is not clear in the bug report.
Yep, my M6Ne also crashes if lapic is enabled and I press the magic key
combination (Fn+F8).
> 
> Anyway, looks like, at the very least, a blacklist entry for that machine
> would be in order.  And that's supposing we are doing nothing wrong while
> setting up the lapic in it, as I know nothing about lapics.
> 
> I don't trust Windows to be using the lapic at all, if you know how to
> verify that, you might want to do so and send that information to the bug
> report.
I don't have windows installed on this machine, so I can't say anything
about it.
