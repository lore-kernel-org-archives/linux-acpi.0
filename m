From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 2/4] Remove /proc/acpi/sony interface and implement platform_device.
Date: Sat, 10 Feb 2007 13:49:40 +0100
Message-ID: <20070210124940.GB6964@inferi.kami.home>
References: <11708749163025-git-send-email-malattia@linux.it> <11708749161009-git-send-email-malattia@linux.it> <11708749161045-git-send-email-malattia@linux.it> <20070210024719.37413cfc@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:55941 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbXBJMu7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Feb 2007 07:50:59 -0500
Content-Disposition: inline
In-Reply-To: <20070210024719.37413cfc@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Guido <alessandro.guido@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Sat, Feb 10, 2007 at 02:47:19AM +0100, Alessandro Guido wrote:
> Thanks for doing this! I hope this will be merged soon in mainline :)
> I'm testing it on my VGN-FS215S and so far I haven't noticed any
> problem.
> 
> Just a thing:
> 
> brightness_default uses values starting from 1. In my opinion, it should
> be changed to use values starting from 0 to have some consistency or,
> better, have an entry itself in the backlight interface.

I don't think the latter is possible, at least not without patching the
backlight class framework but I don't know if this has ever been
discussed with backlight subsytem maintainers.

While I thought about the former suggestion too. It needs some work to
keep the generalized sysfs_{show,store} functions but it's definitely
worth implementing.

Thanks for the feedback :)
-- 
mattia
:wq!
