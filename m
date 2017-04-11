From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: ACPICA: Cleanup drivers/acpi/acpica Makefile
Date: Tue, 11 Apr 2017 15:53:22 +0200
Message-ID: <CAJZ5v0hjA+VF3UG5+7Y+YpTMh48bXs6P6v0tnn9iRWBeKknHxw@mail.gmail.com>
References: <796420b4be45373de2e0c6148062fb8d8ddbbcb4.1490930522.git.lv.zheng@intel.com>
 <201704021640.4xwSssrU%fengguang.wu@intel.com> <1AE640813FDE7649BE1B193DEA596E886CE8DA28@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36092 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdDKNxX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Apr 2017 09:53:23 -0400
Received: by mail-oi0-f48.google.com with SMTP id r203so183553827oib.3
        for <linux-acpi@vger.kernel.org>; Tue, 11 Apr 2017 06:53:22 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE8DA28@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "kbuild-all@01.org" <kbuild-all@01.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, lkp <lkp@intel.com>

On Tue, Apr 11, 2017 at 9:19 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Rafael
>
> According to the test, PATCH 02 is not possible unless ACPICA debugging function stubs are correctly prepared for ACPI_DEBUG_OUTPUT=n.
> So please help to drop PATCH 02 and only PATCH 01 is useful for now.

OK

Can you please resend patch [1/2] separately, then, and let me know
what is superseded by it?

Thanks,
Rafael
