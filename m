From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: 2.6.25-rc2 System no longer powers off after suspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 02:02:25 +0800
Message-ID: <b6a2187b0802201002t315548b5uac623759723842d0@mail.gmail.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	 <alpine.LFD.1.00.0802200922590.7833@woody.linux-foundation.org>
	 <b6a2187b0802200937q3ff8f470k235b5d1e00eab59e@mail.gmail.com>
	 <alpine.LFD.1.00.0802200945591.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:55723 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbYBTSC1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Feb 2008 13:02:27 -0500
Received: by el-out-1112.google.com with SMTP id v27so1303407ele.23
        for <linux-acpi@vger.kernel.org>; Wed, 20 Feb 2008 10:02:26 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802200945591.7833@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jesse Barnes <jesse.barnes@intel.com>, lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, suspend-devel List <suspend-devel@lists.sourceforge.net>, Greg KH <gregkh@suse.de>

On Feb 21, 2008 1:52 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Ahh. You're using the BIOS to re-initialize your video, aren't you?

I don't know. Just pure simple "s2ram" without any options.


> Let's try to narrow it down to what the interaction is. Are you using
> something like acpi_sleep=s3_bios or similar?

No. Not additional command line option except for resume=/dev/sda3 reboot=bios


> That's what the kernel support is supposed to make unnecessary in the long run,

Ok, understand now.

Jeff.
