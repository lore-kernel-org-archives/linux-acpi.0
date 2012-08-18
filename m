From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management fixes for 3.6-rc3
Date: Sat, 18 Aug 2012 23:19:09 +0200
Message-ID: <201208182319.09540.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:46252 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344Ab2HRVNI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Aug 2012 17:13:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

Hi Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-for-3.6-rc3

to receive power management fixes for v3.6-rc3 with top-most commit
3735d524da64b70b41c764359da36f88aded3610

  intel_idle: Check cpu_idle_get_driver() for NULL before dereferencing it.

on top of commit d9875690d9b89a866022ff49e3fcea892345ad92

  Linux 3.6-rc2

Included are:

* Fixes for three obscure bugs in the runtime PM core code found recently.

* Two fixes for the new "coupled" cpuidle code from Colin Cross and Jon Medhurst.

* Fix for a potential NULL pointer dereference in intel_idle from
  Konrad Rzeszutek Wilk.

Thanks!


 drivers/base/power/runtime.c | 13 +++++--------
 drivers/cpuidle/coupled.c    | 14 +++++++++++++-
 drivers/idle/intel_idle.c    |  3 ++-
 3 files changed, 20 insertions(+), 10 deletions(-)

---------------

Colin Cross (1):
      cpuidle: coupled: fix sleeping while atomic in cpu notifier

Jon Medhurst (Tixy) (1):
      cpuidle: Prevent null pointer dereference in cpuidle_coupled_cpu_notify

Konrad Rzeszutek Wilk (1):
      intel_idle: Check cpu_idle_get_driver() for NULL before dereferencing it.

Rafael J. Wysocki (3):
      PM / Runtime: Fix rpm_resume() return value for power.no_callbacks set
      PM / Runtime: Clear power.deferred_resume on success in rpm_suspend()
      PM / Runtime: Check device PM QoS setting before "no callbacks" check

