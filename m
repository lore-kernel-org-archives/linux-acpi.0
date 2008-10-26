From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] Hibernate: Handle ACPI NVS memory as required by the spec (rev. 2)
Date: Sun, 26 Oct 2008 20:48:22 +0100
Message-ID: <200810262048.23468.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55196 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbYJZTwZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Oct 2008 15:52:25 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <ncunningham@crca.org.au>, Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>

Hi,

This is my second version of the patchset making the Linux hibernation code
handle the ACPI NVS memory as required by the spec, based on the previous
Zhang Rui's patches.

Please queue in the 'suspend' branch as .29 material.

Thanks,
Rafael

