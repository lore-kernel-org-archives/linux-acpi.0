From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] ACPI: Integrate tools/power/acpi Makefile into tools Makefile.
Date: Thu, 16 Jan 2014 02:10:22 +0100
Message-ID: <4000586.0EcRlCdl8J@vostro.rjw.lan>
References: <cover.1376378577.git.lv.zheng@intel.com> <cover.1389676901.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63679 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752147AbaAPA4W (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jan 2014 19:56:22 -0500
In-Reply-To: <cover.1389676901.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Wednesday, January 15, 2014 12:03:10 PM Lv Zheng wrote:
> This patchset updates tools/power/acpi folder to integrate its Makefiles
> with other tools.
> 
> Lv Zheng (3):
>   ACPICA: acpidump: Cleanup tools/power/acpi makefiles.
>   ACPICA: acpidump: Enable tools Makefile to include acpi tools.
>   ACPICA: acpidump: Update MAINTAINERS file to include tools folder for
>     ACPI/ACPICA.
> 
>  MAINTAINERS                                      |    2 +
>  tools/Makefile                                   |   16 ++-
>  tools/power/acpi/Makefile                        |  149 ++++++++++++++++++++--
>  tools/power/acpi/{ => man}/acpidump.8            |    0
>  tools/power/acpi/{ => tools/acpidump}/acpidump.c |    0
>  5 files changed, 152 insertions(+), 15 deletions(-)
>  rename tools/power/acpi/{ => man}/acpidump.8 (100%)
>  rename tools/power/acpi/{ => tools/acpidump}/acpidump.c (100%)

Queued up for 3.14, thanks Lv!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
