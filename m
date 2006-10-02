From: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Sun, 1 Oct 2006 19:39:08 -0500
Message-ID: <20061002003908.GA18707@lists.us.dell.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061001171912.b7aac1d8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:55876 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932536AbWJBAjF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Oct 2006 20:39:05 -0400
Content-Disposition: inline
In-Reply-To: <20061001171912.b7aac1d8.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

On Sun, Oct 01, 2006 at 05:19:12PM -0700, Andrew Morton wrote:
> On Sat, 30 Sep 2006 19:08:10 +0200
> Alessandro Guido <alessandro.guido@gmail.com> wrote:
> 
> > Make the sony_acpi use the backlight subsystem to adjust brightness value
> > instead of using the /proc/sony/brightness file.
> > (Other settings will still have a /proc/sony/... entry)
> 
> umm, OK, but now how do I adjust my screen brightness? ;)
> 
> I assume that cute userspace applications for controlling backlight
> brightness via the generic backlight driver either exist or are in
> progress?  What is the status of that?

For Dell laptops, the dellLcdBrightness app is included in the
libsmbios-bin package (http://linux.dell.com/libsmbios/main/ and
http://linux.dell.com/libsmbios/main/yum.html for the yum repo).  It's
entirely userspace.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
