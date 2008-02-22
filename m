From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [Suspend-devel] 2.6.25-rc2 System no longer powers off aftersuspend-to-disk. Screen becomes green.
Date: Fri, 22 Feb 2008 08:20:30 +0800
Message-ID: <b6a2187b0802211620q47f6601fuf7e88395d89b90c8@mail.gmail.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	 <b6a2187b0802201002t315548b5uac623759723842d0@mail.gmail.com>
	 <1203623002.3420.6.camel@localhost>
	 <200802211302.27002.jesse.barnes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:25732 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbYBVAUb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 19:20:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so243178wah.23
        for <linux-acpi@vger.kernel.org>; Thu, 21 Feb 2008 16:20:31 -0800 (PST)
In-Reply-To: <200802211302.27002.jesse.barnes@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: Romano Giannetti <romano@dea.icai.upcomillas.es>, Linus Torvalds <torvalds@linux-foundation.org>, suspend-devel List <suspend-devel@lists.sourceforge.net>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

On Fri, Feb 22, 2008 at 5:02 AM, Jesse Barnes <jesse.barnes@intel.com> wrote:
> On Thursday, February 21, 2008 11:43 am Romano Giannetti wrote:
>  > > > Let's try to narrow it down to what the interaction is. Are you using
>  > > > something like acpi_sleep=s3_bios or similar?
>  > >
>  > > No. Not additional command line option except for resume=/dev/sda3
>  > > reboot=bios
>  >
>  > My laptop (a Toshiba satellite U305, intel 945GM chipset, used to need
>  > s2ram -f -p -m to STR correctly. In 2.6.25-rc2 I can simply STR with
>  > echo mem > /sys/power/state.
>
>  Cool, glad to hear at least one success report. :)

STR is always working on my X60s. No green screen, no hang. Both s2ram
and "echo mem > /sys/power/state". It's STD that's having problem.

But strange thing is I could even restore console after STD even
without agp and i915 module loaded, so I don't know how the console
vga got saved and restored.

Thanks,
Jeff.
