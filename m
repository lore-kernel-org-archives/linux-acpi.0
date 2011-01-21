From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Occasional (too common) suspend problem
Date: Thu, 20 Jan 2011 20:50:36 -0800
Message-ID: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34359 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751827Ab1AUEvc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Jan 2011 23:51:32 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0L4ovUE015480
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Thu, 20 Jan 2011 20:50:57 -0800
Received: by iyj18 with SMTP id 18so1308114iyj.19
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jan 2011 20:50:56 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>Linux-pm mailing list <linu>

So I have one remaining problem on my nasty EeePC problem child
computer, and this one I cannot bisect simply because it's so flaky.

The exact same kernel may suspend and resume many many times in a row,
and then I reboot it, and it hangs on the first suspend. Very
occasionally the machine comes back when I press a key, and resumes
ok. Most of the time it does not - it's just dead to the world, and
there are no logs to go by. I even tried pm_trace, and that didn't get
me anywhere, although I once got a hash match:

  hash matches drivers/base/power/main.c:555

which is the last part of a deivice_resume(), but none of the devices
matched, so that didn't really give any information at all.

So I have very little to go on.

However, at least one time when it failed and came back (remember:
very rare), I did get that suspend sequence printouts logged. Here's a
_good_ suspend:

  ...
  [   79.596367] PM: Saving platform NVS memory
  [   79.596378] Disabling non-boot CPUs ...
  [   79.700053] CPU 1 is now offline
  [   79.700565] PM: Restoring platform NVS memory
  [   79.700565] Enabling non-boot CPUs ...
  [   79.700565] Booting Node 0 Processor 1 APIC 0x1
  [   79.597894] Initializing CPU#1
  ...

and here's the one that failed and then ended up coming back on a keypress:

  ...
  [   54.628375] PM: Saving platform NVS memory
  [   54.628387] Disabling non-boot CPUs ...
  [   63.554966] ACPI Exception: AE_BAD_PARAMETER, Returned by Handler
for [EmbeddedControl] (20110112/evregion-474)
  [   63.554992] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.SBRG.EC0_.RCTP] (Node f5c2dea0), AE_BAD_PARAMETER
(20110112/psparse-536)
  [   63.555022] ACPI Error: Method parse/execution failed
[\_TZ_.RTMP] (Node f5c32fa8), AE_BAD_PARAMETER (20110112/psparse-536)
  [   63.555047] ACPI Error: Method parse/execution failed
[\_TZ_.TZ00._TMP] (Node f5c34018), AE_BAD_PARAMETER
(20110112/psparse-536)
  [   63.555079] Thermal: failed to read out thermal zone 0
  [   63.556361] CPU 1 is now offline
  [   63.556944] PM: Restoring platform NVS memory
  [   63.556944] Enabling non-boot CPUs ...
  [   63.556944] Booting Node 0 Processor 1 APIC 0x1
  [   63.556279] Initializing CPU#1
  ...

which really doesn't tell me much, except that clearly something in
ACPI-land is unhappy, and it looks thermal-related (that last error
message comes from thermal_zone_device_update()).

Any ideas?

                    Linus
