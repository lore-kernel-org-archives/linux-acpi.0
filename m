From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: Fix in ACPICA tools broke cross compilation of tools/power/acpi
Date: Tue, 15 Nov 2016 17:02:03 +0200
Message-ID: <CAHp75Vc3aSW09AXzWs5yY=iGSFPcz9zeB1F+dA=cNZTbPUG1Lg@mail.gmail.com>
References: <CAHp75VcyRzKPGQXB736EdvyXm9m3ShnLS3Xyrjnh7iRTE5M-uw@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25E72C@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Vfp3v-SUk=ot35g9VReexCgYFjr1i=fVwyq1_Xg37ub8g@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EA6F@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886A25EBA3@SHSMSX101.ccr.corp.intel.com>
 <CAHp75Veg7XehhF_GcwQC4XxrjJGj6gxqd-sw044vOhE+2aGGBA@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886A2618E2@SHSMSX101.ccr.corp.intel.com>
 <CAHp75VccqXjwXg0s-n7r5-MzhzxmYS9AKpphckn=ytZNSkdyRw@mail.gmail.com>
 <CAHp75VcA15mVwUYF75dWdSp=BZmf_KCsE+t5qBfsiXHPMdUJiw@mail.gmail.com> <CAHp75VdJ1Nb_qbRX9b=RfDX-8e2tOUvMcbgYx8aMr4COQN3p8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35217 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbcKOPCF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Nov 2016 10:02:05 -0500
Received: by mail-yw0-f170.google.com with SMTP id i145so98489752ywg.2
        for <linux-acpi@vger.kernel.org>; Tue, 15 Nov 2016 07:02:05 -0800 (PST)
In-Reply-To: <CAHp75VdJ1Nb_qbRX9b=RfDX-8e2tOUvMcbgYx8aMr4COQN3p8Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Nov 15, 2016 at 5:01 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> The below + several runs (need to serialize makefile, by default it
> races install vs. build)  helped eventually.

Isn't better just to revert patch I mention and continue from working case?

-- 
With Best Regards,
Andy Shevchenko
