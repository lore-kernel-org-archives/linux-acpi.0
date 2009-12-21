From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [linux-pm] [RFC] Asynchronous suspend/resume - test results
Date: Sun, 20 Dec 2009 23:35:55 -0800
Message-ID: <20091221073555.GB3234@core.coreip.homeip.net>
References: <200912210140.19713.rjw@sisk.pl> <4B2F22EF.6040500@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:64791 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbZLUHgP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2009 02:36:15 -0500
Content-Disposition: inline
In-Reply-To: <4B2F22EF.6040500@crca.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

Hi Nigel,

On Mon, Dec 21, 2009 at 06:25:35PM +1100, Nigel Cunningham wrote:
> Hi.
> 
> Rafael J. Wysocki wrote:
> > I'm not sure what the next step should be at this point.  To me, the picture is
> > quite clear now, but perhaps we ought to run more tests on some other machines
> > or something.  Please let me know what you think.
> 
> Looks great. If you do decide you want other machines tested, I'll
> happily try the machines around here:
> 
> - Dell M1530
> - Omnibook XE3-GF.
> - Via LN10000 based Mythtv Box
> - Desktop machine - Some Intel-based mobo I've forgotten the name of.
> 

Would you mind also testing patch that I just posted that changes full
PS/2 keyboard and mouse resets to more lightweight versions?

Thanks!

-- 
Dmitry
