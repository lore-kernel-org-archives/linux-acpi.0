From: Marc MERLIN <marc@merlins.org>
Subject: Re: How to detect reason for ACPI wakeup?
Date: Mon, 23 Apr 2012 13:24:50 -0700
Message-ID: <20120423202450.GD11480@merlins.org>
References: <20120417171709.GC5632@merlins.org> <CAErSpo7fOL_JD8eTJSESfJ5BnXvE5BZWkv02mJQmozj0ngu1LA@mail.gmail.com> <CAMLZHHRmRWUdFxPdhQ3ZE==NXFEMTRG2UKK1=aTPbqa6YMLoKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:48843 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab2DWUYx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Apr 2012 16:24:53 -0400
Content-Disposition: inline
In-Reply-To: <CAMLZHHRmRWUdFxPdhQ3ZE==NXFEMTRG2UKK1=aTPbqa6YMLoKg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

On Mon, Apr 23, 2012 at 02:07:28PM -0600, Daniel Drake wrote:
> On Mon, Apr 23, 2012 at 2:03 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> My HTPC goes to sleep (S3) and resumes just fine (via RTC or WOL).
> >>
> >> My problem is that I need to know whether it woke up from RTC or WOL and I
> >> find nothing in dmesg that gives me a clue for the wakeup reason.
> >>
> >> Is it something that I can get from somewhere?
> >
> > http://marc.info/?l=linux-acpi&m=133478932527097&w=2 is a similar sort
> > of request; maybe something similar could be done.
> 
> Here's how you can detect RTC wakeup:
> http://patchwork.ozlabs.org/patch/153612/

Thanks for the patches.

Do you know if either is likely to ever make it to mainline?

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
