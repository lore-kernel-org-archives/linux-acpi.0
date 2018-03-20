From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 0/5] x86/cpu_hotplug: one bug fix and four cleanup
Date: Tue, 20 Mar 2018 19:04:27 +0800
Message-ID: <20180320110432.28127-1-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, hpa@zytor.com, peterz@infradead.org, Dou Liyang <douly.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

Recently, we hoped to make the possible CPU count more accurate for
Kernel. I stuck on the issue how do I run acpi_early_init() _before_ 
setup_percpu() is invoked. So send these insignificant patches first.

This patchset does this things:

  - two document-related work(the 1th and 2th patch),
  - two cleapup work (the 3th and 5th patch)
  - a bug fix for CPU hotplug(4th patch)

Dou Liyang (5):
  x86/smpboot: Add the missing description of possible_cpus
  x86/cpu_hotplug: Update the link of cpu_hotplug.rst
  x86/smpboot: Make the check code more clear in prefill_possible_map()
  acpi/processor: Fix the return value of acpi_processor_ids_walk()
  acpi/processor: Make the acpi_duplicate_processor_id() static

 Documentation/00-INDEX                          |  2 -
 Documentation/admin-guide/kernel-parameters.txt |  5 ++
 Documentation/cputopology.txt                   | 10 ++--
 Documentation/x86/x86_64/cpu-hotplug-spec       |  2 +-
 arch/x86/kernel/smpboot.c                       | 31 +++++++-----
 drivers/acpi/acpi_processor.c                   | 66 ++++++++++++-------------
 include/linux/acpi.h                            |  3 --
 7 files changed, 62 insertions(+), 57 deletions(-)

-- 
2.14.3
