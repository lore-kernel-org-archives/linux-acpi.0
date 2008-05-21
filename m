From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Suspend and hibernation patchset for 2.6.26-rc3
Date: Wed, 21 May 2008 23:29:57 +0200
Message-ID: <200805212329.59539.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S937120AbYEUV3m@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Jesse Barnes <jbarnes@virtuousgeek.org>, Shaohua Li <shaohua.li@intel.com>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-acpi@vger.kernel.org

Hi,

For everyone interested, I have put together a patchset containing some "fresh"
patches related to suspend and hibernation, on top of 2.6.26-rc3, located at:

http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.26-rc3/patches/

Patches 01-06 and 11 have been sent to Len as 2.6.27 material.  They have
been tested by me for some time (except for the most recent changes in patches
01 and 11) and have not lead to any problems so far.

Patches 07-10 are in the Jesse's PCI tree, targeted at 2.6.27.

Thanks,
Rafael
