From: "Kay Sievers" <kay.sievers@vrfy.org>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while suspended (rev. 2)
Date: Wed, 2 Jan 2008 15:55:00 +0100
Message-ID: <3ae72650801020655h6ec31ce8n5cd9014c00c9f6ad@mail.gmail.com>
References: <200801020032.45529.rjw@sisk.pl> <20080102105217.GA14731@elte.hu>
	 <200801021356.59865.rjw@sisk.pl> <20080102131529.GA32160@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:13276 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbYABOzD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 09:55:03 -0500
Received: by wa-out-1112.google.com with SMTP id v27so9128971wah.23
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jan 2008 06:55:00 -0800 (PST)
In-Reply-To: <20080102131529.GA32160@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Greg KH <gregkh@suse.de>, David Brownell <david-b@pacbell.net>

On Jan 2, 2008 2:15 PM, Ingo Molnar <mingo@elte.hu> wrote:
> A stupid question. The old RTC driver is in
> drivers/char/rtc.c, and maps to:
>
>   crw-r--r-- 1 root root  10, 135 Oct 25 18:02 /dev/rtc
>
> the new driver is in drivers/rtc/*, and maps to:
>
>   crw-r--r-- 1 root root 254,   0 Dec 12 02:30 /dev/rtc0
>
> but all the x86 distro boxes i have access to make use of /dev/rtc.
> There's no symlink set up from /dev/rtc to /dev/rtc0 either. So it
> appears to me that the new RTC driver isnt actually utilized on most
> distributions.
>
> shouldnt we provide a Kconfig way of replacing dev 10:135 with the new
> driver's 254:0 device? (while keeping all the current modes of operation
> as well, of course.) It's all supposed to be 100% ioctl ABI compatible
> with the old driver, right?

It's not compatible enough to "fake" only the old major/minor. Userspace
must be fixed not to depend on stuff like:  /proc/sys/dev/rtc/max-user-freq:
  http://lkml.org/lkml/2007/8/4/183

> That way distros could start migrating to it
> as well, without depending on any udev hackery.

It's in the default udev setup:
  KERNEL=="rtc|rtc0",             MODE="0644"
  KERNEL=="rtc0",                 SYMLINK+="rtc"

Kay
