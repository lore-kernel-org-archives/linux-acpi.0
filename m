From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] ACPI / EC: handle ECDT EC and DSDT EC simultaneously
Date: Fri, 28 Apr 2017 06:52:29 -0600
Message-ID: <CAD8Lp46nYiKuwc8i7K_uSKisH4q=wWs8tH7ktJCgoeMDBoU4wg@mail.gmail.com>
References: <20170420201219.21568-1-drake@endlessm.com> <CAD8Lp44nXRv0rpZgPw1f0LZ_bcn74fQFzG6HBxRcL1QAWxBHTQ@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CE9973E@SHSMSX101.ccr.corp.intel.com>
 <2213549.Q4Z823dSPo@aspire.rjw.lan> <CAD8Lp46+BQxcB9hgp0wXvWkA32XksYdG1h-vZOzQ5pT0P-0Ydg@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CE9A1C9@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36366 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034971AbdD1Mwb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Apr 2017 08:52:31 -0400
Received: by mail-wr0-f170.google.com with SMTP id l50so33169638wrc.3
        for <linux-acpi@vger.kernel.org>; Fri, 28 Apr 2017 05:52:30 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE9A1C9@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "chiu@endlessm.com" <chiu@endlessm.com>, "linux@endlessm.com" <linux@endlessm.com>

Hi,

On Fri, Apr 28, 2017 at 12:33 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> However in the above debugging commit, I'm sure we shouldn't invoke _STA in ec_parse_device().
> As the reasons below.
>
> In theory, using DSDT EC as boot EC is not spec compliant.
> It's just a workaround in Linux for not knowing the Windows device enumeration orders.
> Especially, the order of executing the control method execution that may contain hardware initialization code.
> Such control methods are mostly _STA/_INI.
> While for _HID/_CRS/_GPE/_BBN, it is unlikely to trigger order issues and it might be safe to invoke them such early.
>
> If you executes _STA here, you might bring EC._STA execution prior than other _INI/_STA and may break some other platforms.
> So for now, I think you should only add simple sanity checks for ioports.
> And since you have the direct accesses to these affected platforms, you can help to provide such working sanity check improvements for us.

In the DSDT you were looking at the H_EC device, but for whatever
reason, there are two ECs in this DSDT and the one that Linux picks up
is the 2nd one, \_SB_.PCI0.LPCB.EC0.

This device has no _STA but does have valid _CRS, and the debug patch
results agree:

 ACPI : EC: acpi_ec_dsdt_probe: search for DSDT EC
 ACPI : EC: ec_parse_device: _STA status 5 val 0
 ACPI : EC: ec_parse_device: _CRS status 0 command 66 data 62
 ACPI : EC: EC stopped
 ACPI : EC: EC started
 ACPI: \_SB_.PCI0.LPCB.EC0_: Used as first EC

acpidump output is at
https://www.dropbox.com/s/d3w2xrmrz1oklnw/x580vd_acpi.tgz?dl=0

Daniel
