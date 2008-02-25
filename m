From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: new regression in 2.6.25-rc3: no keyboard/lid acpi events on
 thinkpad T61p
Date: Mon, 25 Feb 2008 22:42:22 +0300
Message-ID: <47C31A1E.7080305@suse.de>
References: <8f53421d0802251119q470a79c1p31048ef136271f84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:44699 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755387AbYBYTmw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Feb 2008 14:42:52 -0500
In-Reply-To: <8f53421d0802251119q470a79c1p31048ef136271f84@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

Michael S. Tsirkin wrote:
> On my T61p, 2.6.25-rc2 seems to get acpi events from keypresses
> such as Fn-F4 and lid open/close, prints them in /var/log/acpid
> and reacts accordingly (my acpi scripts suspend on lid close and Fn-F4).
> 
> This no longer happens in 2.6.25-rc3: I see nothing in /var/log/acpid
> after power on:
> [Mon Feb 25 20:47:28 2008] completed event "button/power PWRF 00000080 00000001"
> [Mon Feb 25 20:48:44 2008] starting up
> [Mon Feb 25 20:48:44 2008] 57 rules loaded
> [Mon Feb 25 20:48:48 2008] client connected from 5927[0:0]
> [Mon Feb 25 20:48:48 2008] 1 client rule loaded
> 
> and pressing buttons or closing lid produces no output in
> /var/log/acpid and seems to have no effect.
> 
> git bisect pointed at commit 208c70a45624400fafd7511b96bc426bf01f8f5e :
> ACPI: EC: Use proper handle for boot EC
> 
> If I do git revert 208c70a45624400fafd7511b96bc426bf01f8f5e on top
> of 2.6.25-rc3, I start getting keyboard acpi events, again.
Could you please create a bug report and attach acpidump?

Thanks,
Alex.
> 
> 
> Thanks,
> MST
> 
> PS: I see a different problem on resume, it seems to be unrelated to ACPI
> and I will bisect and report separately.
> 
> PPS: Pls Cc me directly, I am not on the list.

