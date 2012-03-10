From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH] cleanup: Replace tboot specific calls in ACPI with function call.
Date: Sat, 10 Mar 2012 13:52:04 -0500
Message-ID: <1331405526-25952-1-git-send-email-konrad.wilk@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-acpi@vger.kernel.org, lenb@kernel.org
Cc: rjw@sisk.pl, joseph.cihula@intel.com
List-Id: linux-acpi@vger.kernel.org

Please consider these two patches for v3.4. I've posted these in the past and
they don't differ any from the previous postings. The majority of changes
has been suggested by Rafael Wysocki and Joseph Cihula has ACK-ed the patches.

The net gain of these patches is to remove the 'tboot' call within the ACPI core
framwork and replace it with an function call where the platform drivers can
register if they choose to. This makes it possible for platforms such as ARM, IA64
to choose whether they want to make a call to something similar to tboot or not.
If nothing is registered the call ends up being a nop.


 arch/x86/kernel/tboot.c       |    9 ++++++---
 drivers/acpi/acpica/hwsleep.c |   10 +++++++---
 drivers/acpi/osl.c            |   24 ++++++++++++++++++++++++
 include/acpi/acexcep.h        |    1 +
 include/linux/acpi.h          |   10 ++++++++++
 include/linux/tboot.h         |    1 -
 6 files changed, 48 insertions(+), 7 deletions(-)


Konrad Rzeszutek Wilk (1):
      tboot: Add return values for tboot_sleep

Tang Liang (1):
      x86, acpi, tboot: Have a ACPI os prepare sleep instead of calling tboot_sleep.
