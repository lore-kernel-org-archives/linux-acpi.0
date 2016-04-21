From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] ACPI 2.0 / ECDT: Enable ECDT support
Date: Thu, 21 Apr 2016 02:19:26 +0200
Message-ID: <2835417.3a4nlgVZ9C@vostro.rjw.lan>
References: <cover.1458786874.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61032 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751341AbcDUAQf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Apr 2016 20:16:35 -0400
In-Reply-To: <cover.1458786874.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thursday, March 24, 2016 10:42:38 AM Lv Zheng wrote:
> ECDT support in Linux is broken.
> 
> In fact, the original EC driver was correct, but devlopers started to use
> the namespace EC instead of ECDT just because several broken ECDT tables
> were reported on the bugzilla. They trusted the namespace EC settings
> rather than the ECDT ones, this led to the evaluation of _REG/_GPE/_CRS
> and namespace walk before executing the module level AML opcodes. And the
> fixes in fact finally disable early EC usages (used during table loading
> and early device enumeration processes).
> 
> Lv Zheng (4):
>   ACPI 2.0 / ECDT: Split EC_FLAGS_HANDLERS_INSTALLED
>   ACPI 2.0 / ECDT: Remove early namespace reference from EC
>   ACPI 2.0 / ECDT: Enable correct ECDT initialization order
>   ACPI 2.0 / AML: Improve module level execution by moving the
>     If/Else/While execution to per-table basis
> 
>  drivers/acpi/bus.c    |   39 +++++---
>  drivers/acpi/ec.c     |  241 ++++++++++++++++++++++---------------------------
>  include/acpi/acpixf.h |    2 +-
>  3 files changed, 135 insertions(+), 147 deletions(-)

All [1-4/4] applied, thanks!

