From: Pavel Machek <pavel@ucw.cz>
Subject: Re: acpi hotkey sysfs support
Date: Fri, 21 Apr 2006 21:20:40 +0200
Message-ID: <20060421192040.GA3161@elf.ucw.cz>
References: <20060419130719.GA2599@ucw.cz> <20060421191632.GF2078@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13800 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932145AbWDUTVJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Apr 2006 15:21:09 -0400
Content-Disposition: inline
In-Reply-To: <20060421191632.GF2078@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: luming.yu@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

HI!

> > I have created a place under sysfs to have a unified place
> > to gather user input for common hotkey features. 
> > http://bugzilla.kernel.org/show_bug.cgi?id=5749#c10
> > 
> > All of you are owner of a specific acpi hotkey driver. 
> > Would you like to use that sysfs support to reduce the
> > unnecessary interface complexity.
> 
> Yep, patch looks okay. It would be nice to format it linux-like,
> through. Space between if and (, and such stuff.
> 
> SHOUTING_TYPEDEFS look bad to me, too.

One more thing... can we use input api for these events? Routing
buttons through /proc/acpi/event was mistake from day 0 :-(.

							Pavel

-- 
Thanks for all the (sleeping) penguins.
