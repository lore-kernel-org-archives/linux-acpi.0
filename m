From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 5/7] ACPI / x86: introduce acpi_os_readable() support
Date: Tue, 10 Nov 2015 15:04:28 +0200
Message-ID: <CAHp75VdeXWqcvrfYszjLj63zmZffRLh8ytGzSO+6d31TgbBaNw@mail.gmail.com>
References: <cover.1446790780.git.lv.zheng@intel.com>
	<cover.1447143067.git.lv.zheng@intel.com>
	<c54877289d7742727b2395147167590ed2f24d8a.1447143067.git.lv.zheng@intel.com>
	<36DF59CE26D8EE47B0655C516E9CE6402867258C@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34334 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbbKJNE3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Nov 2015 08:04:29 -0500
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402867258C@shsmsx102.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>

On Tue, Nov 10, 2015 at 11:42 AM, Chen, Yu C <yu.c.chen@intel.com> wrote:
> Hi, Lv
> Sorry for my late feedback on the patch, one minor nit below:

>> +     start_pfn = page_to_pfn(virt_to_page(pointer));
>> +     end_pfn = page_to_pfn(virt_to_page(pointer + length));
> Convert pointer to char* first?
> end_pfn = page_to_pfn(virt_to_page((char*)pointer + length));

Why do you need that?
void * + size_t = char * + size_t

-- 
With Best Regards,
Andy Shevchenko
