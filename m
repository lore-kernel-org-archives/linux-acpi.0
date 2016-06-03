From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fixes for v4.7-rc2
Date: Fri, 3 Jun 2016 23:39:04 +0200
Message-ID: <CAJZ5v0jCH7akpQDmKrXmBSFZNsit1REA5XPcSm4bx6Q1aJxmiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.7-rc2

to receive power management fixes for v4.7-rc2 with top-most commit
8cd8cbd4906126951f1bd6ab8a28ee57f0dc1efc

 Merge branch 'pm-cpufreq-fixes'

on top of commit 1a695a905c18548062509178b98bc91e67510864

 Linux 4.7-rc1

Two fixes for problems introduced recently in the cpufreq core
and the intel_pstate driver.

Specifics:

 - Fix a silly mistake related to the clamp_val() usage in
   a function added by a recent commit (Rafael Wysocki).

 - Reduce the log level of an annoying message added to intel_pstate
   during the recent merge window (Srinivas Pandruvada).

Thanks!

---------------

Rafael J. Wysocki (1):
      cpufreq: Fix clamp_val() usage in cpufreq_driver_fast_switch()

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Downgrade print level for _PPC

---------------

 drivers/cpufreq/cpufreq.c      | 2 +-
 drivers/cpufreq/intel_pstate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
