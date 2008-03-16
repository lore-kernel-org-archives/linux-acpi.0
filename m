From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/3] PM: Rework suspend and hibernation code for devices
Date: Mon, 17 Mar 2008 00:20:54 +0100
Message-ID: <200803170020.55473.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754796AbYCPX0X@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-acpi@vger.kernel.org

Hi,

The following three patches are intended to start the redesign of the suspend
and hibernation framework for devices.

The first patch defines the new framework.  Specifically, it introduces the
structure 'struct pm_ops' containing a set of hibernation and suspend
callbacks to be defined by bus types, device types, device classes and,
finally, by device drivers (the role of each callback is described in the
comment in pm.h; the documentation will be updated later).  It also modifies
the code in drivers/base/power/main.c to use the new framework, if available,
and fall back to the old one otherwise (no visible functional changes should be
added).

The other two patches implement the new suspend and hibernation callbacks
for the platform and PCI bus types.

Please review and tell me what you think.

Thanks,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
