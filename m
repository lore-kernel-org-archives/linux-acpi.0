From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] tools/power/acpi: Fix ACPI tools build issues.
Date: Thu, 06 Aug 2015 02:13:50 +0200
Message-ID: <4195867.x7koTejHCv@vostro.rjw.lan>
References: <cover.1438060971.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61222 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753104AbbHEXqo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Aug 2015 19:46:44 -0400
In-Reply-To: <cover.1438060971.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday, July 28, 2015 01:25:12 PM Lv Zheng wrote:
> Currently tools/power/acpi is broken:
> 1. acpidump build is broken because utnonansi.o is not linked.
> 2. ec build is broken because descend build is not supported.
> This patch fixes the above issues.
> 
> Lv Zheng (2):
>   tools/power/acpi: Add descend support in ACPI tools Makefile.
>   tools/power/acpi: Enable build for EC userspace tool.
> 
>  tools/power/acpi/Makefile                |  168 +++---------------------------
>  tools/power/acpi/Makefile.config         |   92 ++++++++++++++++
>  tools/power/acpi/Makefile.rules          |   37 +++++++
>  tools/power/acpi/tools/acpidump/Makefile |   53 ++++++++++
>  tools/power/acpi/tools/ec/Makefile       |   33 +++---
>  5 files changed, 213 insertions(+), 170 deletions(-)
>  create mode 100644 tools/power/acpi/Makefile.config
>  create mode 100644 tools/power/acpi/Makefile.rules
>  create mode 100644 tools/power/acpi/tools/acpidump/Makefile

Both queued up for 4.3, thanks!

Rafael

