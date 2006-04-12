From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 0/3] Redesigned Dock Patches
Date: Wed, 12 Apr 2006 15:18:38 -0700
Message-ID: <1144880318.11215.42.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9364 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932332AbWDLWKL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Apr 2006 18:10:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, greg@kroah.com
Cc: linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, mochel@linux.intel.com, arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz, temnota@kmv.ru

After getting more laptop/dock combos tested, it's apparent to me that
I need to redesign the dock patches to not exclusively use acpiphp to
handle dock events.  This is because there are dock stations with no
pci on them at all, and it doesn't make sense for the apci pci hotplug
driver to handle the dock event in this case.  So, I moved the dock
event handling to the acpi directory, in a separate driver called "dock".
The acpiphp driver will still handle hotplugging any new pci devices
(including dock bridges) that will be need to be inserted after a dock
event.

To use these driver, you will need to select CONFIG_ACPI_DOCK in the
.config file, and make sure if you are using an IBM laptop that you have
NOT selected the option to allow ibm_acpi to handle the docking events.  Then,
you modprobe dock as well as acpiphp.

Please take a look at these patches and test them if you can.  Every time
another person tests the dock patches I find another combination I didn't
think of :).  Thanks for your feedback, and thanks to all the testers who
are helping make the dock patches work for as many systems as we can.

Kristen

--
