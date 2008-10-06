From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC 0/5] device wakeup event support v2
Date: Mon, 06 Oct 2008 09:57:27 +0800
Message-ID: <1223258247.7550.0.camel@sli10-desk.sh.intel.com>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
	 <200809150150.01687.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41640 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835AbYJFB53 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Oct 2008 21:57:29 -0400
In-Reply-To: <200809150150.01687.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "david-b@pacbell.net" <david-b@pacbell.net>

On Mon, 2008-09-15 at 07:50 +0800, Rafael J. Wysocki wrote:
> On Thursday, 11 of September 2008, Shaohua Li wrote:
> > This series add device wakeup event detection support. This is the base to
> > implement runtime device suspend/resume, though we don't support it now.
> > But David said USB is approaching to this. See this bugzilla
> > http://bugzilla.kernel.org/show_bug.cgi?id=6892 for detail.
> >
> > changes v1 -> v2:
> > 1. scan pci bridge for PME. Current implementation is just doing scan if target device is a bridge
> > 2. move device_receive_wakeup_event() call to pci, and provide an API (pci_handle_wakeup_event()) for non-ACPI & non-PCIe platform
> > 3. fixed a lot of coding style issues
> >
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> Thanks for posting the update.
> 
> Unfortunately, I won't be able to review the patches until after I get back
> from the Kernel Summit.
Any update on this?

Thanks,
Shaohua

