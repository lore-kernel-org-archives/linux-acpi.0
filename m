From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 0/6] ACPI: dock: code hygiene
Date: Wed, 07 Oct 2009 16:07:27 -0600
Message-ID: <20091007220509.15597.65501.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754714AbZJGWIG@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

While poking around in the dock driver debugging the NULL ptr that
Rafael fixed, I found the driver a little hard to read.

Here is a modest attempt to clean it up a little, and is intended as
2.6.33 material.

Compile-tested only. I have access to an HP nc6220 and nc6230, but neither
of them seem to provide the _DCK method, which is needed for the dock
driver.

Thanks.

/ac

---

Alex Chiang (6):
      ACPI: dock: clean up error handling paths in dock_add()
      ACPI: dock: rename local variable 'dock_station' in dock_add()
      ACPI: dock: clean up one more error path in dock_add()
      ACPI: dock: add struct dock_station * directly to platform device data
      ACPI: dock: combine add|alloc_dock_dependent_device
      ACPI: dock: minor whitespace and style cleanups


 drivers/acpi/dock.c |  259 ++++++++++++++++++++-------------------------------
 1 files changed, 104 insertions(+), 155 deletions(-)
