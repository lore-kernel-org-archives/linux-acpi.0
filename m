From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.22
Date: Tue, 1 May 2007 00:56:52 +0200
Message-ID: <200705010056.53517.rjw@sisk.pl>
References: <200704290102.33533.lenb@kernel.org> <200704302331.43934.rjw@sisk.pl> <20070430220736.GD11115@waste.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43416 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946871AbXD3Wwq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Apr 2007 18:52:46 -0400
In-Reply-To: <20070430220736.GD11115@waste.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Miles Lane <miles.lane@gmail.com>, lollul@wp.pl, Helge Hafting <helgehaf@aitel.hist.no>

On Tuesday, 1 May 2007 00:07, Matt Mackall wrote:
> On Mon, Apr 30, 2007 at 11:31:42PM +0200, Rafael J. Wysocki wrote:
> 
> > Can you please do 'echo shutdown > /sys/power/disk' before the hibernation
> > and see what happens?
> 
> Do I need to reboot for this test? Same behavior without a reboot.

You may try with a reboot, though I'm not sure if that will help.

The problem is certainly related to ACPI, probably to the EC, but I don't know
in which way.

Greetings,
Rafael
