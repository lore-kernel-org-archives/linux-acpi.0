From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 14/16] ACPICA: Add several repairs for _CST predefined name
Date: Thu, 20 Jun 2013 01:57:08 +0200
Message-ID: <1379958.zfU0EJYY3C@vostro.rjw.lan>
References: <cover.1369274558.git.lv.zheng@intel.com> <4747911.BQxTeXVdnl@vostro.rjw.lan> <94F2FBAB4432B54E8AACC7DFDE6C92E36FE8877F@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43449 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934170Ab3FSXrq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jun 2013 19:47:46 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE8877F@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>

On Wednesday, June 19, 2013 12:52:23 AM Moore, Robert wrote:
> Fixes these possible problems. I think we've actually seen at least one of these, not sure where/when:
> 
>  * DESCRIPTION: Repair for the _CST object:
>  *              1. Sort the list ascending by C state type
>  *              2. Ensure type cannot be zero
>  *              3. A sub-package count of zero means _CST is meaningless
>  *              4. Count must match the number of C state sub-packages

Queued up for 3.11 with the above information added to the changelog.

Thanks Bob!

Rafael

