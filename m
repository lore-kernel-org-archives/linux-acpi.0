From: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>
Subject: new regression in 2.6.25-rc3: no keyboard/lid acpi events on thinkpad T61p
Date: Mon, 25 Feb 2008 21:19:24 +0200
Message-ID: <8f53421d0802251119q470a79c1p31048ef136271f84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:4106 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbYBYTTZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Feb 2008 14:19:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so923709ugc.16
        for <linux-acpi@vger.kernel.org>; Mon, 25 Feb 2008 11:19:24 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.b>

On my T61p, 2.6.25-rc2 seems to get acpi events from keypresses
such as Fn-F4 and lid open/close, prints them in /var/log/acpid
and reacts accordingly (my acpi scripts suspend on lid close and Fn-F4).

This no longer happens in 2.6.25-rc3: I see nothing in /var/log/acpid
after power on:
[Mon Feb 25 20:47:28 2008] completed event "button/power PWRF 00000080 00000001"
[Mon Feb 25 20:48:44 2008] starting up
[Mon Feb 25 20:48:44 2008] 57 rules loaded
[Mon Feb 25 20:48:48 2008] client connected from 5927[0:0]
[Mon Feb 25 20:48:48 2008] 1 client rule loaded

and pressing buttons or closing lid produces no output in
/var/log/acpid and seems to have no effect.

git bisect pointed at commit 208c70a45624400fafd7511b96bc426bf01f8f5e :
ACPI: EC: Use proper handle for boot EC

If I do git revert 208c70a45624400fafd7511b96bc426bf01f8f5e on top
of 2.6.25-rc3, I start getting keyboard acpi events, again.


Thanks,
MST

PS: I see a different problem on resume, it seems to be unrelated to ACPI
and I will bisect and report separately.

PPS: Pls Cc me directly, I am not on the list.
