From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] ACPI / EC: handle ECDT EC and DSDT EC simultaneously
Date: Wed, 26 Apr 2017 07:11:09 -0600
Message-ID: <CAD8Lp44nXRv0rpZgPw1f0LZ_bcn74fQFzG6HBxRcL1QAWxBHTQ@mail.gmail.com>
References: <20170420201219.21568-1-drake@endlessm.com> <1AE640813FDE7649BE1B193DEA596E886CE96843@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36854 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1035837AbdDZNLU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Apr 2017 09:11:20 -0400
Received: by mail-oi0-f47.google.com with SMTP id w12so95851885oiw.3
        for <linux-acpi@vger.kernel.org>; Wed, 26 Apr 2017 06:11:20 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CE96843@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "chiu@endlessm.com" <chiu@endlessm.com>, "linux@endlessm.com" <linux@endlessm.com>

Hi Lv,

Thanks for the detailed response. In trying to decode the tricky code
flow and seeing all this first_ec / boot_ec / DSDT EC / ECDT EC stuff,
I seem to have made the wrong interpretation about how this is
designed.

On Sun, Apr 23, 2017 at 10:43 PM, Zheng, Lv <lv.zheng@intel.com> wrote:
> The entire problem looks to me is:
> When GPE setting differs between ECDT and DSDT, which one should be
> trusted by OS?

This case suggests that Windows uses the ECDT setting, right?

> The current code chose to always trust DSDT GPE settings as in theory it
> doesn't make sense to trust the ECDT GPE setting in most of the cases,
> ECDT GPE is not meant to be used during runtime. So why don't we just add
> a quirk to favor GPE setting from ECDT rather than the GPE setting from
> DSDT for these platforms?

Do you mean a DMI quirk? We have found those to be quite impractical
in the past, it is too hard to get 100% coverage of all machines
affected by the bug, and usually we would only be able to quirk it
late in the process (after the machine has already shipped to users).
In a recent case we had an Asus DMI quirks list that grew slowly to
over 30 entries over a year, before we found a generic solution.

In this case we have asked Asus BIOS engineers to not repeat this
issue on future products, but even if they follow our advice there, we
can expect a decent number of models affected by this issue.

And we just found a 2nd model with the same issue. Here is the
"acpidump -b" output:
https://www.dropbox.com/s/d3w2xrmrz1oklnw/x580vd_acpi.tgz?dl=0

To see the windows device tree using Microsoft Windows Internals, are
you referring to the paperback book? Which of the 2 parts would we
have to purchase? Does it come with a binary on CD or would we have to
figure out how to compile the tool?

Thanks,
Daniel
