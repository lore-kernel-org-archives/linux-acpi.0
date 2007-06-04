From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH]: ACPI: preserve the ebx value in acpi_copy_wakeup_routine
Date: Mon, 4 Jun 2007 12:37:06 +0200
Message-ID: <20070604103706.GA4405@elf.ucw.cz>
References: <20070601101707.GC31453@elf.ucw.cz> <823A93EED437D048963A3697DB0E35DE16B6CB@pdsmsx414.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40683 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752214AbXFDKhN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Jun 2007 06:37:13 -0400
Content-Disposition: inline
In-Reply-To: <823A93EED437D048963A3697DB0E35DE16B6CB@pdsmsx414.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>

Hi!

> According to the SYSTEM V APPLICATION BINARY INTERFACE,
> Intel386 Architecture:
> "ecx and edx: Scratch registers have no specified role in the standard calling
> sequence. Functions do not have to preserve their values for the
> caller."

Thanks for confirming.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
