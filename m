From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: suspend hangs at platform phase [was: mmotm 2010-12-23-16-58
 uploaded]
Date: Wed, 05 Jan 2011 22:36:04 +0100
Message-ID: <4D24E444.6080308@gmail.com>
References: <201012240132.oBO1W8Ub022207@imap1.linux-foundation.org> <4D232352.2030809@gmail.com> <4D234F8E.7080102@gmail.com> <201101042357.08600.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43297 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab1AEVgK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jan 2011 16:36:10 -0500
In-Reply-To: <201101042357.08600.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, steiner@sgi.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On 01/04/2011 11:57 PM, Rafael J. Wysocki wrote:
> On Tuesday, January 04, 2011, Jiri Slaby wrote:
>> On 01/04/2011 02:40 PM, Jiri Slaby wrote:
>>> On 12/24/2010 01:58 AM, akpm@linux-foundation.org wrote:
>>>> The mm-of-the-moment snapshot 2010-12-23-16-58 has been uploaded to
>>>
>>> Hi, this kernel regresses with respect to suspend to ram in comparison
>>> with mmotm 2010-12-16-14-56.
>>>
>>> This is OK:
>>> echo devices > /sys/power/pm_test
>>> pm-suspend
>>> This hangs at suspend phase:
>>> echo platform > /sys/power/pm_test
>>> pm-suspend
> 
> Hmm.  So it looks like _PTS hangs?

No _PST here :).

>>> Note that this kernel is based on next-20101221. Should I try newer (and
>>> clean) -next?
>>
>> Ok, bisected down to:
>> 16dc39c98a6ca56a27f22f7ac6731d8223237a2e is first bad commit
>> commit 16dc39c98a6ca56a27f22f7ac6731d8223237a2e
...
>> Revert of that patch fixes the problem.
> 
> Can you send a dmesg output and acpidump output from the failing system, please?

Here they are:
http://www.fi.muni.cz/~xslaby/sklad/panics/dmesg-no-susp.txt
http://www.fi.muni.cz/~xslaby/sklad/adump.txt

They are captured from the mmotm minus 16dc39c98a6ca56 if that's OK?
Ignore the BUG there, it's caused by qemu and fixed in later -next.

regards,
-- 
js
