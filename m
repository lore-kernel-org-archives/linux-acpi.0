From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: ACPI module for Asus Eee PC
Date: Sun, 27 Jan 2008 20:26:42 +0000
Message-ID: <200801272026.43183.carlos@strangeworlds.co.uk>
References: <20080126144824.GD16281@stratocaster.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from host-240-152.cust.aaawireless.net ([216.23.240.152]:60731 "EHLO
	mail.slackadelic.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbYA0Uhj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Jan 2008 15:37:39 -0500
In-Reply-To: <20080126144824.GD16281@stratocaster.home>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Cooper <ecc@cmu.edu>
Cc: linux-acpi@vger.kernel.org

On Saturday 26 January 2008 14:48:24 Eric Cooper wrote:
> I happened to look at the patched asus_acpi.c module that was posted
> by Asus for the Eee PC and noticed that it's 75% dead code -- the Eee
> PC support is just stuck on at the end.  And of course it conflicts
> with the real asus_acpi.ko in any kernel package.
>
> So I cleaned it up, renamed it eeepc_acpi, and packaged it as a
> separate out-of-kernel Debian package that can be built with
> module-assistant.

To submit a driver, it needs to be as a patch against the ACPI Git tree 'test' 
branch.

New laptop drivers should:

1) Be in drivers/misc (asus_acpi is the only leftover in drivers/acpi - 
everything else has already been moved, and no new laptop drivers will be 
accepted in drivers/acpi)

2) proc is deprecated for new drivers - you should be using sysfs

3) #if LINUX_KERNEL_VERSION is an absolute no-no in upstream kernel code. Any 
such instances should be stripped out of the code.

4) Patches should be run through scripts/checkpatch.pl, and new drivers 
especially should be checkpatch clean - you will find it flags up quite a few 
style problems with the code.

If you can address these and then resubmit a proper patch, then you will stand 
a chance of getting this reviewed and accepted into the mainline kernel.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
