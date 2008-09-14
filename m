From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 0/5] device wakeup event support v2
Date: Mon, 15 Sep 2008 01:50:00 +0200
Message-ID: <200809150150.01687.rjw@sisk.pl>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50851 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738AbYINXoy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Sep 2008 19:44:54 -0400
In-Reply-To: <20080911063037.698427944@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, david-b@pacbell.net

On Thursday, 11 of September 2008, Shaohua Li wrote:
> This series add device wakeup event detection support. This is the base to
> implement runtime device suspend/resume, though we don't support it now.
> But David said USB is approaching to this. See this bugzilla
> http://bugzilla.kernel.org/show_bug.cgi?id=6892 for detail.
> 
> changes v1 -> v2:
> 1. scan pci bridge for PME. Current implementation is just doing scan if target device is a bridge
> 2. move device_receive_wakeup_event() call to pci, and provide an API (pci_handle_wakeup_event()) for non-ACPI & non-PCIe platform
> 3. fixed a lot of coding style issues
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Thanks for posting the update.

Unfortunately, I won't be able to review the patches until after I get back
from the Kernel Summit.

Thanks,
Rafael



