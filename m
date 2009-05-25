From: Chris Howie <cdhowie@gmail.com>
Subject: Re: Boot problems with 2.6.29.1 - cannot smoothly boot on battery
Date: Sun, 24 May 2009 21:53:32 -0400
Message-ID: <3d2f29dc0905241853h594aa2a9ta21dee45979c567e@mail.gmail.com>
References: <3d2f29dc0905180125x5e7ef51dqf10955a3d44336e2@mail.gmail.com>
	 <200905242236.22715.rjw@sisk.pl> <4A19BA09.4050502@zytor.com>
	 <20090525011819.GA9805@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:6891 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbZEYBxb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 May 2009 21:53:31 -0400
In-Reply-To: <20090525011819.GA9805@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>

On Sun, May 24, 2009 at 9:18 PM, Shaohua Li <shaohua.li@intel.com> wrote:
> if this is a AMD CPU, please check http://bugzilla.kernel.org/show_bug.cgi?id=13233

Ahh, that sounds like it.  I first noticed the problem in 2.6.28 after
switching from 2.6.26 (but never tried 2.6.27).  So the information
about versions is indeed consistent.  I'm on an amd64 cpu.

Thanks everyone for the suggestions, I will try to take a look within
the next couple of days and report my findings.

-- 
Chris Howie
http://www.chrishowie.com
http://en.wikipedia.org/wiki/User:Crazycomputers
