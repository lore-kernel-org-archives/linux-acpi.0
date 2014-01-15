From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 0/3] ACPI: Integrate tools/power/acpi Makefile into tools
 Makefile.
Date: Wed, 15 Jan 2014 10:04:41 -0700
Message-ID: <52D6BFA9.80609@redhat.com>
References: <cover.1376378577.git.lv.zheng@intel.com> <cover.1389676901.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28824 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbaAOREp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jan 2014 12:04:45 -0500
In-Reply-To: <cover.1389676901.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On 01/14/2014 09:03 PM, Lv Zheng wrote:
> This patchset updates tools/power/acpi folder to integrate its Makefiles
> with other tools.
>
> Lv Zheng (3):
>    ACPICA: acpidump: Cleanup tools/power/acpi makefiles.
>    ACPICA: acpidump: Enable tools Makefile to include acpi tools.
>    ACPICA: acpidump: Update MAINTAINERS file to include tools folder for
>      ACPI/ACPICA.
>
>   MAINTAINERS                                      |    2 +
>   tools/Makefile                                   |   16 ++-
>   tools/power/acpi/Makefile                        |  149 ++++++++++++++++++++--
>   tools/power/acpi/{ => man}/acpidump.8            |    0
>   tools/power/acpi/{ => tools/acpidump}/acpidump.c |    0
>   5 files changed, 152 insertions(+), 15 deletions(-)
>   rename tools/power/acpi/{ => man}/acpidump.8 (100%)
>   rename tools/power/acpi/{ => tools/acpidump}/acpidump.c (100%)
>

Is there any work going on to reconcile (or merge or ...) this
version of acpidump with the version in upstream ACPICA?  The
sources are very different yet they seem to me to provide more
or less the same functionality.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
