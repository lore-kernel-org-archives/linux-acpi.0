From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/5][RFC] Use per cpuidle_device states
Date: Wed, 25 Jul 2012 12:45:57 +0200
Message-ID: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Since commit 46bcfad7a819bd17ac4e831b04405152d59784ab,
        cpuidle: Single/Global registration of idle states

we have a single registration for the cpuidle states which makes
sense. But now two new architectures are coming: tegra3 and big.LITTLE.

These architectures have different cpus with different caracteristics
for power saving. High load => powerfull processors, idle => small processors.

That implies different cpu latencies.

This patchset present a simple way to keep the current behavior as introduced
by Deepthi without breaking the drivers and add the possibility to specify a
per cpu states.

Daniel Lezcano (5):
  acpi : move the acpi_idle_driver variable declaration
  acpi : move cpuidle_device field out of the acpi_processor_power
    structure
  cpuidle : add a pointer for cpuidle_state in the cpuidle_device
  cpuidle : use per cpuidle device cpu states
  cpuidle : add cpuidle_register_states function

 drivers/acpi/processor_driver.c    |    2 +-
 drivers/acpi/processor_idle.c      |   25 ++++++++++++++++++-------
 drivers/cpuidle/cpuidle.c          |   24 +++++++++++++++++++++---
 drivers/cpuidle/governors/ladder.c |   18 +++++++++---------
 drivers/cpuidle/governors/menu.c   |    8 ++++----
 drivers/cpuidle/sysfs.c            |    3 +--
 include/acpi/processor.h           |    3 ---
 include/linux/cpuidle.h            |   11 ++++++++---
 8 files changed, 62 insertions(+), 32 deletions(-)

-- 
1.7.5.4
