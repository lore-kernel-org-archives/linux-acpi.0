From: Jiri Slaby <jirislaby@gmail.com>
Subject: Fan runs full speed after S3 sometimes (regression)
Date: Tue, 10 Aug 2010 13:20:57 +0200
Message-ID: <4C613619.30309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55462 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab0HJLVB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Aug 2010 07:21:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

Hi,

till I was running on 2.6.34-rc5-mm1 (mmotm) and earlier everything was
fine. Now, I'm running 2.6.35-rc6-mm1 (.35-rc5-mm1 was the same) and
sometimes when the computer (desktop) returns from S3, the CPU fan is
running at full speed making a big noise.

I don't know how to debug that. Bisection is out of question -- it
happens once in 10 or 20 cases. There are no fan entries in /sys.

The load is as follows:
$ while :; do cat /proc/loadavg; sleep 3; done
0.37 0.33 0.32 1/325 21358
0.42 0.34 0.32 1/325 21362
0.42 0.34 0.32 1/326 21366
0.38 0.33 0.32 1/330 21386
0.38 0.33 0.32 1/331 21391
0.35 0.33 0.32 1/331 21394
0.32 0.32 0.32 1/331 21397
0.32 0.32 0.32 1/331 21400
0.30 0.32 0.32 1/331 21403
...

I can boot into 34-rc5 to compare that if this is of relevance.

290 kB kernel log since boot over several S3 sleep till now where the
fan is noisy:
http://www.fi.muni.cz/~xslaby/sklad/panics/boot.msg-fan_fullspeed

Should you need DSDT, it's there too:
http://www.fi.muni.cz/~xslaby/sklad/panics/DSDT

Any ideas what could have caused this?

thanks,
-- 
js
