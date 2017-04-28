From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] ACPI / EC: handle ECDT EC and DSDT EC simultaneously
Date: Thu, 27 Apr 2017 18:44:02 -0600
Message-ID: <CAD8Lp46+BQxcB9hgp0wXvWkA32XksYdG1h-vZOzQ5pT0P-0Ydg@mail.gmail.com>
References: <20170420201219.21568-1-drake@endlessm.com> <CAD8Lp44nXRv0rpZgPw1f0LZ_bcn74fQFzG6HBxRcL1QAWxBHTQ@mail.gmail.com>
 <1AE640813FDE7649BE1B193DEA596E886CE9973E@SHSMSX101.ccr.corp.intel.com> <2213549.Q4Z823dSPo@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36698 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033863AbdD1AoE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Apr 2017 20:44:04 -0400
Received: by mail-io0-f173.google.com with SMTP id p80so42386641iop.3
        for <linux-acpi@vger.kernel.org>; Thu, 27 Apr 2017 17:44:03 -0700 (PDT)
In-Reply-To: <2213549.Q4Z823dSPo@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "chiu@endlessm.com" <chiu@endlessm.com>, "linux@endlessm.com" <linux@endlessm.com>

On Thu, Apr 27, 2017 at 6:33 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Can you suggest a patch, please?
>
> Ideally, something that can be tested?

I think I understand Lv's suggestions so we will now test the
following change in order to check if either or both of the added DSDT
EC checks can help us.

https://gist.github.com/dsd/f50a63c9f31779436bd280c76253e37c

Daniel
