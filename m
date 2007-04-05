From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc5-git 0/3] x86_pc and ACPI support /sys/devices/.../wakeup
Date: Thu, 5 Apr 2007 16:20:59 -0700
Message-ID: <200704051620.59918.david-b@pacbell.net>
References: <200704051248.40745.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:36072 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1767256AbXDEXVG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Apr 2007 19:21:06 -0400
In-Reply-To: <200704051248.40745.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org

On Thursday 05 April 2007 12:48 pm, David Brownell wrote:
> 
> Now, I've not yet made time to test whether the results _work_ but they
> do look like they do the right thing.  (So far I've had lousy luck seeing
> ACPI recover from wake events...) 

Positive results to report here!  Some of the changes in 2.6.21 really
seem to have made a difference (my guess still being the ACPI IDE stuff).

I did a basic test with ohci-hcd loaded, plugging a device into the root
port when a system entered S1 ... it woke correctly and enumerated the
device, exactly as it should have done.  (But never did before!!)

Same thing with S3 ... except in that case the display was trashed; I
was able to ssh in, and switch the vt from raw console to X using the
PS2 keyboard, but that's about it.

I think it's fair to assume that other bugs would just be internal to
the USB stack -- e.g. remote wakeup, ehci-hcd, etc -- so this looks
fairly good to me now.

- Dave
