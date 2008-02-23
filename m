From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: i915 hibernation patch (was: Re: [Suspend-devel] 2.6.25-rc2 System no longer powers off aftersuspend-to-disk. Screen becomes green.)
Date: Sat, 23 Feb 2008 12:36:48 +0800
Message-ID: <b6a2187b0802222036i33d5bcc2n4e3bafd6d846cc09@mail.gmail.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	 <200802230031.20292.rjw@sisk.pl>
	 <alpine.LFD.1.00.0802221653000.21332@woody.linux-foundation.org>
	 <200802230255.54510.rjw@sisk.pl>
	 <alpine.LFD.1.00.0802221805540.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:8661 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbYBWEgt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Feb 2008 23:36:49 -0500
Received: by wa-out-1112.google.com with SMTP id v27so732276wah.23
        for <linux-acpi@vger.kernel.org>; Fri, 22 Feb 2008 20:36:48 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802221805540.21332@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jesse Barnes <jesse.barnes@intel.com>, Romano Giannetti <romano@dea.icai.upcomillas.es>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Alexey Starikovskiy <astarikovskiy@suse.de>, pm list <linux-pm@lists.linux-foundation.org>

On Sat, Feb 23, 2008 at 10:07 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

>  On Sat, 23 Feb 2008, Rafael J. Wysocki wrote:
>  > OK, please have a look at the modified patch below.
>
>  All right, I'm fine with it. Now we just need to confirm that it works for
>  people..

Looks good. Applied Rafael patch on top of your latest git tree that
has Jesse's i915 fix.

No green screen. Tested with STD (platform), STR, and plain echo mem >
/sys/power/state.

Thanks,
Jeff.
