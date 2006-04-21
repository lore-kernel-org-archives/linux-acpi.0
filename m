From: Pavel Machek <pavel@suse.cz>
Subject: Re: acpi hotkey sysfs support
Date: Fri, 21 Apr 2006 21:16:32 +0200
Message-ID: <20060421191632.GF2078@elf.ucw.cz>
References: <20060419130719.GA2599@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12520 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932128AbWDUTRB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Apr 2006 15:17:01 -0400
Content-Disposition: inline
In-Reply-To: <20060419130719.GA2599@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: luming.yu@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> I have created a place under sysfs to have a unified place
> to gather user input for common hotkey features. 
> http://bugzilla.kernel.org/show_bug.cgi?id=5749#c10
> 
> All of you are owner of a specific acpi hotkey driver. 
> Would you like to use that sysfs support to reduce the
> unnecessary interface complexity.

Yep, patch looks okay. It would be nice to format it linux-like,
through. Space between if and (, and such stuff.

SHOUTING_TYPEDEFS look bad to me, too.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
