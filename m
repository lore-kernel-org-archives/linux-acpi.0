From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [BUG] nvidia vga card is missed after S3
Date: Tue, 1 Apr 2008 22:24:18 +0200
Message-ID: <200804012224.19168.rjw@sisk.pl>
References: <1206691229.1362.5.camel@sli10-desk.sh.intel.com> <200804010102.59665.rjw@sisk.pl> <1207011521.25182.0.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48232 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758483AbYDAUYM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Apr 2008 16:24:12 -0400
In-Reply-To: <1207011521.25182.0.camel@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>

On Tuesday, 1 of April 2008, Shaohua Li wrote:
> 
> On Tue, 2008-04-01 at 01:02 +0200, Rafael J. Wysocki wrote:
> > On Friday, 28 of March 2008, Shaohua Li wrote:
> > > Still in ASUS A6VC laptop (linux is quite broken in the system). If
> > > 'pm_restore_console()' is called the video card (03:00.0, Nevidia Go
> > > 6200/6400, it hasn't a driver) pci config space read is messy (some are
> > > 0xffffffff, others are 0). If I comment pm_restore_console(), then
> > > everything is fine. Anything I can provide to debug the issue?
> > 
> > Hmm.  Do you suspend the box from under X or crom the console?
> from console.

Framebuffer or plain VGA?

Anyway, it looks like 's2ram -f -p' might help.

Thanks,
Rafael
