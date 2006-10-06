From: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Fri, 6 Oct 2006 16:17:51 -0500
Message-ID: <20061006211751.GA31887@lists.us.dell.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061001171912.b7aac1d8.akpm@osdl.org> <20061002003908.GA18707@lists.us.dell.com> <20061005103657.GA4474@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:25872 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1422971AbWJFVS2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Oct 2006 17:18:28 -0400
Content-Disposition: inline
In-Reply-To: <20061005103657.GA4474@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

On Thu, Oct 05, 2006 at 10:36:57AM +0000, Pavel Machek wrote:
> Hi!
> 
> > > I assume that cute userspace applications for controlling backlight
> > > brightness via the generic backlight driver either exist or are in
> > > progress?  What is the status of that?
> > 
> > For Dell laptops, the dellLcdBrightness app is included in the
> > libsmbios-bin package (http://linux.dell.com/libsmbios/main/ and
> > http://linux.dell.com/libsmbios/main/yum.html for the yum repo).  It's
> > entirely userspace.
> 
> Please move it into the kernel where it belongs, and use lcd
> brightness subsystem like everyone else.

We've been through this before.
http://marc.theaimsgroup.com/?l=linux-kernel&m=114067198323596&w=2

In addition, the SMI call used to change the backlight level *may*
require (if configured by the sysadmin in BIOS), a password be
entered.

This begs for a common userspace app that can grok libsmbios and
kernel interfaces both, and use the appropriate method on each, rather
than just putting it all in the kernel.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
