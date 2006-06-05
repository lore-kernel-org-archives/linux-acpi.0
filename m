From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: 2.6.17-rc5-mm3 -- ACPI errors (are these ones that are significant?)
Date: Mon, 5 Jun 2006 20:58:14 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD11206F1@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751086AbWFEM6V@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


>On Mon, 5 Jun 2006 01:24:27 -0700
>"Miles Lane" <miles.lane@gmail.com> wrote:
>
>> During boot:
>> 
>> acpi_processor-0731 [00] processor_preregister_: Error while parsing
>> _PSD domain information. Assuming no coordination
>> 
>> During resume and after the "BUG: sleeping function called from
>> invalid context at include/asm/semaphore.h:99 in_atomic():0,
>> irqs_disabled():1" that I reported earlier:
>> 
>> PM: Finishing wakeup.
>>  acpi: resuming
>> ACPI: read EC, IB not empty
>> ACPI: read EC, OB not full
>> ACPI Exception (evregion-0412): AE_TIME, Returned by Handler for
>> [EmbeddedControl] [20060310]
>> ACPI Exception (dswexec-0459): AE_TIME, While resolving operands for
>> [Store] [20060310]
>> ACPI Error (psparse-0522): Method parse/execution failed
>> [\_TZ_.THRM._TMP] (Node c189ec44), AE_TIME
>> agpgart-intel 0000:00:00.0: resuming
>
>Please copy linux-acpi on acpi-related problems.

Please try boot option: ec_intr=0.
Also, please file a bug report on bugzilla.kernel.org

Thanks,
Luming
