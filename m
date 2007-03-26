From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI/sound issue with my Toshiba laptop (P100-473)...
Date: Sun, 25 Mar 2007 23:54:36 -0400
Message-ID: <200703252354.36510.lenb@kernel.org>
References: <4606BF08.5070706@gmail.com> <46070F06.4070309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47535 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932570AbXCZDzx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Mar 2007 23:55:53 -0400
In-Reply-To: <46070F06.4070309@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fred <fredmfp@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sunday 25 March 2007 20:08, fred wrote:
> Ok, I have fixed it, following 
> http://forums.gentoo.org/viewtopic-t-444743-highlight-sndhdaintel.html
> 
> Sorry for the noise.

Thanks for the pointer - no, your post is not noise.

Was changing "PNP0C14" to "PNP0C14" in the DSDT sufficient to fix the issue?
It may be that we have a simple "Microsoft Bug Compatibility" issue here.

Linux's goal should be for machines that run Windows to also run Linux,
without the need for users to hack their DSDT...

> By the way, as the toshiba p100-473 is not present in your repository,
> should I post mine ?

Can't hurt, but getting Linux to work properly w/o needing a DSDT
hack is much more important.

So it may be even more useful to open a bug report here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
(sub-category BIOS)
and attach the complete output from acpidump, along with the minimum
change you needed to make to your DSDT to get sound to work.

thanks,
-Len
