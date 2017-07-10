From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] More power management updates for v4.13-rc1
Date: Tue, 11 Jul 2017 00:00:13 +0200
Message-ID: <CAJZ5v0gGfaqBnex1Hk3qpNugQv0_gs3Zz3=n=1z9Ti2d-eLgCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33660 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754041AbdGJWAP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Jul 2017 18:00:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-extra-4.13-rc1

with top-most commit 15d56b3921d2e52c7747af21fcdf04e940aeb09b

 Merge branches 'pm-domains', 'pm-sleep' and 'pm-cpufreq'

on top of commit 408c9861c6979db974455b9e7a9bcadd60e0934c

 Merge tag 'pm-4.13-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for v4.13-rc1.

These revert one recent change in the generic power domains
framework, fix a recently introduced build issue in there and
constify attribute_group structures in some places.

Specifics:

 - Revert a recent change in the generic power domains (genpd)
   framework that led to regressions and turned out the be misguided
   (Rafael Wysocki).

 - Fix a recently introduced build issue in the generic power domains
   (genpd) framework (Arnd Bergmann).

 - Constify attribute_group structures in the PM core, the cpufreq
   stats code and in intel_pstate (Arvind Yadav).

Thanks!


---------------

Arnd Bergmann (1):
      PM / Domains: provide pm_genpd_poweroff_noirq() stub

Arvind Yadav (3):
      PM / sleep: constify attribute_group structures
      cpufreq: cpufreq_stats: constify attribute_group structures
      cpufreq: intel_pstate: constify attribute_group structures

Rafael J. Wysocki (1):
      Revert "PM / Domains: Handle safely genpd_syscore_switch() call
on non-genpd device"

---------------

 drivers/base/power/domain.c     | 5 +++--
 drivers/cpufreq/cpufreq_stats.c | 2 +-
 drivers/cpufreq/intel_pstate.c  | 2 +-
 kernel/power/main.c             | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)
