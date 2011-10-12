From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFH] Power Management mini-summit during the Kernel Summit 2011
Date: Wed, 12 Oct 2011 22:11:21 +0200
Message-ID: <201110122211.21638.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36614 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167Ab1JLUJB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Oct 2011 16:09:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, mark gross <markgross@thegnar.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "Len Brown (Intel)" <len.brown@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Arjan van de Ven <arjan@infradead.org>, Tejun Heo <tj@kernel.org>, jean.pihet@newoldbits.com, Kevin Hilman <khilman@ti.com>, Daniel Drake <dsd@laptop.org>, ming.lei@canonical.com, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@sirena.org.uk>, John Stultz <john.stultz@linaro.org>

Hi All,

There was a plan to organize a PM mini-summit during the KS 2011 in Prague,
but then I didn't follow up (which obviously is my fault) and lost track of
things when kernel.org and the KS servers went offline.  So, apparently,
the KS organizers concluded that the PM mini-summit wasn't going to happen
after all and didn't add it to the schedule.

Still, it appears to be possible to arrange a room for a PM meeting on
Sunday, Oct 23, if there are people wanting to attend.  So, if you'd like
to take part in such a meeting, please let me know ASAP.

The topics I, personally, would like to discuss include:
- Per-device PM QoS
- Propagation of wakeup events to user space vs system suspend
- Possibility of representing dependencies between devices through
  "device links" (i.e. objects representing master-slave links between
  devices)
- Idea of common "platform" bus type that may cover ACPI devices (like
  battery, fans etc.), PNP devices and current platform devices in a
  consistent way
- Freezer improvements

Thanks,
Rafael
