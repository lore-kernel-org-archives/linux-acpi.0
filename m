From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 00/30] ACPI-processor: Fine-tuning for several function
 implementations
Date: Sat, 10 Sep 2016 11:30:08 +0200
Message-ID: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 9 Sep 2016 20:15:05 +0200

Several update suggestions were taken into account
from static source code analysis.

Markus Elfring (30):
  Use kmalloc_array() in acpi_processor_get_performance_states()
  Improve two size determinations in acpi_processor_get_performance_states()
  Rename jump labels in acpi_processor_get_performance_states()
  Delete two unnecessary initialisations in acpi_processor_get_performance_states()
  Rename jump labels in acpi_processor_preregister_performance()
  Move a success indication in acpi_processor_preregister_performance()
  Rename jump labels in acpi_processor_get_psd()
  Delete two unnecessary initialisations in acpi_processor_get_psd()
  Improve a size determination in acpi_processor_get_psd()
  Rename jump labels in acpi_processor_get_performance_control()
  Delete two unnecessary initialisations in acpi_processor_get_performance_control()
  Rename jump labels in acpi_processor_ppc_notifier()
  Delete an unnecessary initialisation in acpi_processor_ppc_notifier()
  Delete an unnecessary initialisation in acpi_processor_get_performance_info()
  Delete an unnecessary initialisation in acpi_processor_get_platform_limit()
  Use kmalloc_array() in acpi_processor_get_throttling_states()
  Improve another size determination in acpi_processor_get_throttling_states()
  Rename jump labels in acpi_processor_get_throttling_states()
  Delete two unnecessary initialisations in acpi_processor_get_throttling_states()
  Fix jump targets in acpi_processor_get_throttling_info()
  Rename jump labels in acpi_processor_get_tsd()
  Delete two unnecessary initialisations in acpi_processor_get_tsd()
  Improve a size determination in acpi_processor_get_tsd()
  Rename jump labels in acpi_processor_get_throttling_control()
  Delete two unnecessary initialisations in acpi_processor_get_throttling_control()
  Fix jump targets in acpi_processor_reevaluate_tstate()
  Delete an unnecessary initialisation in acpi_processor_reevaluate_tstate()
  Rename a jump label in acpi_processor_get_platform_limit()
  Delete an unnecessary initialisation in acpi_processor_get_platform_limit()
  Improve jump targets in acpi_processor_update_tsd_coord()

 drivers/acpi/processor_perflib.c    |  87 +++++++++++++--------------
 drivers/acpi/processor_throttling.c | 116 ++++++++++++++++--------------------
 2 files changed, 93 insertions(+), 110 deletions(-)

-- 
2.10.0

