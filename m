From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 0/3] Rework GPE handling
Date: Wed, 2 Sep 2009 19:10:14 +0100
Message-ID: <20090902181014.GA10917@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753286AbZIBSK2@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: robert.moore@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The current GPE code attempts to define GPEs as either runtime (the 
default), wake or run/wake. These states are orthogonal to whether or 
not a GPE is actually enabled or not. Further, various additional flags 
are defined and set, but never used.

This architecture is additionally complicated by changing the type of a 
GPE causing it to be disabled, resulting in complex functions that then 
have to conditionally re-enable a GPE. It also makes it impossible to 
determine how many consumers a given GPE has, preventing us from 
being able to implement runtime power management for devices requiring 
GPEs for wakeup notification.

This patchset adds a new, simpler API and transitions the existing users 
over to it. It then removes the old code.

 drivers/acpi/acpica/acevents.h |    6 -
 drivers/acpi/acpica/aclocal.h  |    2 
 drivers/acpi/acpica/evgpe.c    |  150 ++++---------------------------------
 drivers/acpi/acpica/evgpeblk.c |  164 +----------------------------------------
 drivers/acpi/acpica/evxface.c  |   14 ---
 drivers/acpi/acpica/evxfevnt.c |  139 ++++++++++++++++++++++++++++++++--
 drivers/acpi/button.c          |   18 +++-
 drivers/acpi/ec.c              |    5 -
 drivers/acpi/wakeup.c          |   57 +++-----------
 include/acpi/acpixf.h          |    8 ++
 include/acpi/actypes.h         |   32 ++------
 11 files changed, 197 insertions(+), 398 deletions(-)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
