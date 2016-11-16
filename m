From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH] acpi: Use NULL from <linux/stddef.h>
Date: Wed, 16 Nov 2016 09:15:13 -0800
Message-ID: <c272e98e-c4f7-3cfc-c8ef-6a0dd2511837@sandisk.com>
References: <4f698429-49cf-689a-9eb5-978b182bb4bb@sandisk.com>
 <CAJZ5v0jof4-JV+Fm_bBa+Fzxe2dLZ5KfoPNhZ_KfxvWX_NHDdg@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E523C92@ORSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-sn1nam02on0061.outbound.protection.outlook.com ([104.47.36.61]:19520
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932995AbcKPRaJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Nov 2016 12:30:09 -0500
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E523C92@ORSMSX108.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 11/16/2016 09:08 AM, Moore, Robert wrote:
> What is the point of these changes?

What's the point of redefining NULL? What's the point of casting a void 
pointer to void *?

Bart.

