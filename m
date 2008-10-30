From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH v2 0/3] ACPI: Fix for supporting > 256 processor declaration
	limit
Date: Thu, 30 Oct 2008 16:13:09 -0600
Message-ID: <20081030215410.30683.95368.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757637AbYJ3WN2@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: aystarik@gmail.com, yakui.zhao@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The following three item patch series fixes an issue with the introduction
of > 256 processor declaration support: "Allow processor to be declared with
the Device() instead of Processor()" (git SHA 11bf04c4).

This version, v2, has no functional changes from the original
(gmane.linux.acpi.devel/34815).  The changes, base on reviewer comments, are:
  . a change to the printk verbage,
  . some additional comments.

Please queue as .29 material.

Thanks,
Myron

---

Myron Stowe (3):
      ACPI: 80 column adherence and spelling fix (no functional change)
      ACPI: Behave uniquely based on processor declaration definition type
      ACPI: Disambiguate processor declaration type


 drivers/acpi/processor_core.c |   83 +++++++++++++++++++++++------------------
 drivers/acpi/scan.c           |    2 -
 include/acpi/acpi_drivers.h   |    1 
 3 files changed, 49 insertions(+), 37 deletions(-)
