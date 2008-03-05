From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 0/3, v8] PCI, ACPI: Physical PCI slot objects
Date: Tue, 4 Mar 2008 17:42:52 -0700
Message-ID: <20080305004252.GJ3694@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:30981 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbYCEAox (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 19:44:53 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Matthew Wilcox <matthew@wil.cx>, Gary Hade <garyhade@us.ibm.com>, kaneshige.kenji@jp.fujitsu.com, warthog19@eaglescrag.net, kristen.c.accardi@intel.com, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Hi Greg, all,

This is v8 of my "introduce pci_slot" series, to be considered for
inclusion in linux-next to get more test exposure and shake out
the bugs.

The major change in this revision is removing an earlier patch
which removed the 'path' sysfs attribute on SGI machines. After
review from Jesse Barnes and Prarit Bhargava, they kindly
informed me that 'path' is actually an SGI physical path, and not
a PCI address. My patch would have definitely broken userspace on
SGI machines, so I eliminated it, and 'path' remains on SGI boxes.

This brings the patch series down to a total of 3 patches:

	0001-Construct-one-fakephp-slot-per-pci-slot.patch
	0002-Introduce-pci_slot.patch
	0003-ACPI-PCI-slot-detection-driver.patch

Thanks for all the code reviews from various people.

I'm now just looking for some people to beat on this code and let
me know where I screwed up. :)

Thanks.

/ac

