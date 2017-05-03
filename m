From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] ACPI / EC: handle ECDT EC and DSDT EC simultaneously
Date: Wed, 3 May 2017 14:06:27 -0600
Message-ID: <CAD8Lp47r=ZKzF3HSWj4D-Pu=PppTK0-_3fTbWFjHXKLvEqr8dw@mail.gmail.com>
References: <20170420201219.21568-1-drake@endlessm.com> <CAD8Lp44nXRv0rpZgPw1f0LZ_bcn74fQFzG6HBxRcL1QAWxBHTQ@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CE9973E@SHSMSX101.ccr.corp.intel.com>
 <2213549.Q4Z823dSPo@aspire.rjw.lan> <CAD8Lp46+BQxcB9hgp0wXvWkA32XksYdG1h-vZOzQ5pT0P-0Ydg@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CE9A1C9@SHSMSX101.ccr.corp.intel.com> <CAD8Lp46nYiKuwc8i7K_uSKisH4q=wWs8tH7ktJCgoeMDBoU4wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33671 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757705AbdECUG3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 May 2017 16:06:29 -0400
Received: by mail-io0-f177.google.com with SMTP id p24so18426873ioi.0
        for <linux-acpi@vger.kernel.org>; Wed, 03 May 2017 13:06:29 -0700 (PDT)
In-Reply-To: <CAD8Lp46nYiKuwc8i7K_uSKisH4q=wWs8tH7ktJCgoeMDBoU4wg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "chiu@endlessm.com" <chiu@endlessm.com>, "linux@endlessm.com" <linux@endlessm.com>

Hi Lv,

On Fri, Apr 28, 2017 at 6:52 AM, Daniel Drake <drake@endlessm.com> wrote:
> In the DSDT you were looking at the H_EC device, but for whatever
> reason, there are two ECs in this DSDT and the one that Linux picks up
> is the 2nd one, \_SB_.PCI0.LPCB.EC0.
>
> This device has no _STA but does have valid _CRS, and the debug patch
> results agree:
>
>  ACPI : EC: acpi_ec_dsdt_probe: search for DSDT EC
>  ACPI : EC: ec_parse_device: _STA status 5 val 0
>  ACPI : EC: ec_parse_device: _CRS status 0 command 66 data 62
>  ACPI : EC: EC stopped
>  ACPI : EC: EC started
>  ACPI: \_SB_.PCI0.LPCB.EC0_: Used as first EC

How do we proceed here? Any other options we can try that don't
involve DMI quirking?

Thanks
Daniel
