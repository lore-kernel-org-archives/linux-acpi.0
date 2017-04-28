From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] dynamic_hex_dump cleanup
Date: Fri, 28 Apr 2017 14:52:18 -0700
Message-ID: <CAPcyv4iJvjJTd7M5_5saopTvKPStC=sYqq++FbE_qFJwpqmASw@mail.gmail.com>
References: <149341493336.35578.13631055553267152302.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1493416143.1873.13.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33973 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033373AbdD1VwT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Apr 2017 17:52:19 -0400
Received: by mail-oi0-f45.google.com with SMTP id x184so41728654oia.1
        for <linux-acpi@vger.kernel.org>; Fri, 28 Apr 2017 14:52:19 -0700 (PDT)
In-Reply-To: <1493416143.1873.13.camel@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Jason Baron <jbaron@akamai.com>

On Fri, Apr 28, 2017 at 2:49 PM, Joe Perches <joe@perches.com> wrote:
> On Fri, 2017-04-28 at 14:28 -0700, Dan Williams wrote:
>> More than one driver has worked around the fact that
>> print_hex_dump_debug() requires CONFIG_DYNAMIC_DEBUG=y to build.
>
> No it doesn't.  builds work fine.  Output is restricted.
>
>> Provide a dynamic_hex_dump() so that drivers that want the extra debugging to be
>> turned off in the CONFIG_DYNAMIC_DEBUG=n can use dynamic_hex_dump()
>> directly.
>
> I think the concept is unnecessary
> .
> Just use print_hex_dump with KERN_DEBUG.

No, we don't want any possibility of output in the
CONFIG_DYNAMIC_DEBUG=n case. This is extra debug that only makes sense
in the CONFIG_DYNAMIC_DEBUG case.
