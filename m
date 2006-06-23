From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] who I do know if a interrupt is ioapic_edge_type or ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:	2.6.17-rc6-mm2 - USB issues]]
Date: Fri, 23 Jun 2006 08:31:04 -0700
Message-ID: <200606230831.05832.david-b@pacbell.net>
References: <44953B4B.9040108@agotnes.com> <4499245C.8040207@agotnes.com> <1150936606.2855.21.camel@localhost.portugal>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:13237 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751465AbWFWPjF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Jun 2006 11:39:05 -0400
In-Reply-To: <1150936606.2855.21.camel@localhost.portugal>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-usb-devel@lists.sourceforge.net, sergio@sergiomb.no-ip.org
Cc: Johny <kernel@agotnes.com>, Andrew Morton <akpm@osdl.org>, vsu@altlinux.ru, Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu

This isn't quite the same as "how to handle the VIA quirks correctly",
but it does seem like the IRQ API should probably have a call to get
the IRQ trigger mode, just like it has ways to set it.  I've seen
drivers that need to try multiple trigger modes before they find one
that will work on the target platform.

The actual details of _how_ that trigger mode is set -- APIC, PIC and
so on for x86; or other IRQ controllers on other hardware -- should
not matter to drivers, since they're platform-specific.  The quirk
handling code is platform-specific though, and might care.

- Dave
