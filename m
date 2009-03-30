From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 00/10] ACPI: add device .notify methods
Date: Mon, 30 Mar 2009 11:48:08 -0600
Message-ID: <20090330174646.20905.18465.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:19586 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbZC3RsN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2009 13:48:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

I'm trying to simplify ACPI drivers by reducing their dependence
on internal ACPI CA details.  One possibility seems to be moving
notify handler management from individual drivers into the
Linux/ACPI driver registration code.

These patches add support for an ACPI driver .notify() method.
If one is present, the Linux/ACPI code installs a generic notify
handler when the driver binds to a device.  The generic handler
passes the event on to the driver's .notify() method.  The
advantage is that the driver need not install or remove the
notify handler, and the .notify() method works in terms of a
struct acpi_device rather than an acpi_handle.

Note that these patches only affect device notifications, not
system notifications.  System notifications are primarily
bus-related events for things like hot-plug and wakeup.  The
device notifications are generally driver-specific things like
"device status changed," "button pressed," or "some method
needs to be re-evaluated."

Comments welcome.

Bjorn

---

Bjorn Helgaas (10):
      ACPI: WMI: use .notify method instead of installing handler directly
      sony-laptop: use .notify method instead of installing handler directly
      panasonic-laptop: use .notify method instead of installing handler directly
      fujitsu-laptop: use .notify method instead of installing hotkey handler directly
      fujitsu-laptop: use .notify method instead of installing handler directly
      ACPI: video: use .notify method instead of installing handler directly
      ACPI: thermal: use .notify method instead of installing handler directly
      ACPI: processor: use .notify method instead of installing handler directly
      ACPI: button: use .notify method instead of installing handler directly
      ACPI: support acpi_device_ops .notify methods


 drivers/acpi/button.c                   |   77 +++----------------------------
 drivers/acpi/processor_core.c           |   19 ++------
 drivers/acpi/scan.c                     |   71 +++++++++++++++++++++++++++++
 drivers/acpi/thermal.c                  |   27 ++---------
 drivers/acpi/video.c                    |   30 ++----------
 drivers/platform/x86/fujitsu-laptop.c   |   60 ++++--------------------
 drivers/platform/x86/panasonic-laptop.c |   26 ++--------
 drivers/platform/x86/sony-laptop.c      |   32 ++-----------
 drivers/platform/x86/wmi.c              |   15 +-----
 include/acpi/acpi_bus.h                 |    2 +
 include/acpi/acpi_drivers.h             |   10 ++++
 11 files changed, 126 insertions(+), 243 deletions(-)
