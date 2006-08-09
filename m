From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Date: Wed, 9 Aug 2006 22:04:13 +0200
Message-ID: <200608092204.13711.rjw@sisk.pl>
References: <200608091426.31762.rjw@sisk.pl> <1155145440.5418.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58595 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751341AbWHIUEt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2006 16:04:49 -0400
In-Reply-To: <1155145440.5418.21.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>

On Wednesday 09 August 2006 19:44, john stultz wrote:
> On Wed, 2006-08-09 at 14:26 +0200, Rafael J. Wysocki wrote:
> > It looks like the CMOS clock gets corrupted during the suspend to disk
> > on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
> > AMD64-based and the x86_64 kernel doesn't have this problem on it.
> > 
> > Also, I've done some tests that indicate the corruption doesn't occur before
> > saving the suspend image.  It rather happens when the box is powered off
> > or rebooted (tested both cases).
> 
> Hmmm. Could you better describe the corruption you're seeing? 

After I do "echo disk > /sys/power/state" and the system suspends, the
CMOS clock settings, as visible via the BIOS setup, are more or less random.

Rafael
