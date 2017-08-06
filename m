From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH 00/30] ACPI-processor: Fine-tuning for several function
 implementations
Date: Sun, 6 Aug 2017 12:05:15 +0200
Message-ID: <cec1be25-0853-8a16-e13d-90a2541969e3@users.sourceforge.net>
References: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:59732 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751262AbdHFKFX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 6 Aug 2017 06:05:23 -0400
In-Reply-To: <f9e5eb7c-54df-931c-e419-f9253e2abf20@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

> Date: Tue, 9 Sep 2016 20:15:05 +0200
> 
> Several update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (30):
>   Use kmalloc_array() in acpi_processor_get_performance_states()
>   Improve two size determinations in acpi_processor_get_performance_states()
>   Rename jump labels in acpi_processor_get_performance_states()
>   Delete two unnecessary initialisations in acpi_processor_get_performance_states()
>   Rename jump labels in acpi_processor_preregister_performance()
>   Move a success indication in acpi_processor_preregister_performance()
>   Rename jump labels in acpi_processor_get_psd()
>   Delete two unnecessary initialisations in acpi_processor_get_psd()
>   Improve a size determination in acpi_processor_get_psd()
>   Rename jump labels in acpi_processor_get_performance_control()
>   Delete two unnecessary initialisations in acpi_processor_get_performance_control()
>   Rename jump labels in acpi_processor_ppc_notifier()
>   Delete an unnecessary initialisation in acpi_processor_ppc_notifier()
>   Delete an unnecessary initialisation in acpi_processor_get_performance_info()
>   Delete an unnecessary initialisation in acpi_processor_get_platform_limit()
>   Use kmalloc_array() in acpi_processor_get_throttling_states()
>   Improve another size determination in acpi_processor_get_throttling_states()
>   Rename jump labels in acpi_processor_get_throttling_states()
>   Delete two unnecessary initialisations in acpi_processor_get_throttling_states()
>   Fix jump targets in acpi_processor_get_throttling_info()
>   Rename jump labels in acpi_processor_get_tsd()
>   Delete two unnecessary initialisations in acpi_processor_get_tsd()
>   Improve a size determination in acpi_processor_get_tsd()
>   Rename jump labels in acpi_processor_get_throttling_control()
>   Delete two unnecessary initialisations in acpi_processor_get_throttling_control()
>   Fix jump targets in acpi_processor_reevaluate_tstate()
>   Delete an unnecessary initialisation in acpi_processor_reevaluate_tstate()
>   Rename a jump label in acpi_processor_get_platform_limit()
>   Delete an unnecessary initialisation in acpi_processor_get_platform_limit()
>   Improve jump targets in acpi_processor_update_tsd_coord()
> 
>  drivers/acpi/processor_perflib.c    |  87 +++++++++++++--------------
>  drivers/acpi/processor_throttling.c | 116 ++++++++++++++++--------------------
>  2 files changed, 93 insertions(+), 110 deletions(-)

How do you think about to take another look at change possibilities
for these source files?

Regards,
Markus
