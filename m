From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc5-git 0/3] x86_pc and ACPI support /sys/devices/.../wakeup
Date: Thu, 5 Apr 2007 16:48:55 -0700
Message-ID: <200704051648.56288.david-b@pacbell.net>
References: <200704051248.40745.david-b@pacbell.net> <200704051620.59918.david-b@pacbell.net> <20070405233024.GA12641@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:23236 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1767441AbXDEXs6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Apr 2007 19:48:58 -0400
In-Reply-To: <20070405233024.GA12641@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org

On Thursday 05 April 2007 4:30 pm, Matthew Garrett wrote:
> On Thu, Apr 05, 2007 at 04:20:59PM -0700, David Brownell wrote:
> 
> > Same thing with S3 ... except in that case the display was trashed; I
> > was able to ssh in, and switch the vt from raw console to X using the
> > PS2 keyboard, but that's about it.
> 
> Excellent news. Regarding the display, you may want to give vbetool a go 
> - there's nothing in Linux to reinitialise the display hardware on most 
> machines, and nothing in the ACPI spec that requires the firmware to.

That system happens to be 32 bits, but a similar one is 64 bits ...
has vbetool been made to work on x86_64 yet?

- Dave
