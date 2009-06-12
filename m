From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM updates for 2.6.31
Date: Fri, 12 Jun 2009 22:02:06 +0200
Message-ID: <200906122202.08345.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59557 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbZFLUBc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Jun 2009 16:01:32 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Cornelia Huck <cornelia.huck@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinder@kernel.org>, Lauro Salmito <laurosalmito@gmail.com>, Magnus Damm <damm@igel.co.jp>, Wu Fengguang <fengguang.wu@intel.com>, Sergio Luis <sergio@larces.uece.br>

Hi Linus,

Please pull power management updates for 2.6.31 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

They are cleanups and code rearrangements mostly, in particular:

* arch/x86/power/cpu_(32|64) unification from Sergio Luis (Ingo saw
  these patches and his opinion was that they should better go
  through the suspend tree)

* Removal of some unused files and PM callbacks, function renames
  from Magnus Damm and Alan Stern

* Rearrangements of the code under kernel/power from me and
  Cornelia Huck

* Two patches related to the memory shrinking (for the record, Pavel
  doesn't like the "PM/Suspend: Do not shrink memory before suspend"
  patch, so please let me know if I should drop it)

* A couple of bug fixes


 Documentation/power/devices.txt  |   34 +--
 arch/alpha/include/asm/suspend.h |    6 -
 arch/arm/include/asm/suspend.h   |    4 -
 arch/ia64/include/asm/suspend.h  |    1 -
 arch/m68k/include/asm/suspend.h  |    6 -
 arch/mips/include/asm/suspend.h  |    6 -
 arch/s390/include/asm/suspend.h  |    5 -
 arch/um/include/asm/suspend.h    |    4 -
 arch/x86/kernel/acpi/sleep.c     |    2 +-
 arch/x86/kernel/apm_32.c         |   14 +-
 arch/x86/power/Makefile          |    2 +-
 arch/x86/power/cpu.c             |  259 +++++++++++
 arch/x86/power/cpu_32.c          |  148 ------
 arch/x86/power/cpu_64.c          |  174 -------
 drivers/base/platform.c          |   36 +-
 drivers/base/power/main.c        |   94 ++---
 drivers/base/sys.c               |   16 +
 drivers/xen/manage.c             |   16 +-
 include/linux/device.h           |    5 -
 include/linux/interrupt.h        |    6 +
 include/linux/pm.h               |   11 +-
 include/linux/suspend.h          |   18 +-
 kernel/kexec.c                   |   14 +-
 kernel/power/Kconfig             |    4 +
 kernel/power/Makefile            |    5 +-
 kernel/power/disk.c              |  955 --------------------------------------
 kernel/power/hibernate.c         |  955 ++++++++++++++++++++++++++++++++++++++
 kernel/power/hibernate_nvs.c     |  135 ++++++
 kernel/power/main.c              |  521 ---------------------
 kernel/power/power.h             |   25 +-
 kernel/power/snapshot.c          |   80 +++-
 kernel/power/suspend.c           |  300 ++++++++++++
 kernel/power/suspend_test.c      |  187 ++++++++
 kernel/power/swsusp.c            |  198 --------
 mm/vmscan.c                      |    4 +-
 35 files changed, 2056 insertions(+), 2194 deletions(-)

---------------

Alan Stern (1):
      PM core: rename suspend and resume functions

Cornelia Huck (1):
      PM/Hibernate: Move NVS routines into a seperate file (v2).

Heiko Carstens (1):
      PM: Add empty suspend/resume device irq functions

Jaswinder Singh Rajput (1):
      PM/ACPI/x86: Fix sparse warning in arch/x86/kernel/acpi/sleep.c

Magnus Damm (5):
      PM: Remove unused asm/suspend.h
      PM: Rename device_power_down/up()
      PM: Remove bus_type suspend_late()/resume_early() V2
      PM: Remove device_type suspend()/resume()
      Driver Core: Rework platform suspend/resume, print warning

Rafael J. Wysocki (5):
      PM: Warn if interrupts are enabled during suspend-resume of sysdevs
      PM/Suspend: Do not shrink memory before suspend
      PM/Hibernate: Move memory shrinking to snapshot.c (rev. 2)
      PM: Separate suspend to RAM functionality from core
      PM/Hibernate: Rename disk.c to hibernate.c

Sergio Luis (6):
      x86: unify power/cpu_(32|64) headers
      x86: unify power/cpu_(32|64) global variables
      x86: unify power/cpu_(32|64) regarding saving processor state
      x86: unify power/cpu_(32|64) regarding restoring processor state
      x86: unify power/cpu_(32|64) copyright notes
      x86: unify power/cpu_(32|64).c

