From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] x86/acpi: add retrieval function for rsdp address
Date: Mon, 29 Jan 2018 04:01:45 +0100
Message-ID: <CAJZ5v0gN-w6MJFOuTsircR5kBHz_U38NB7wErREYL=w_tj-hQQ@mail.gmail.com>
References: <20180125143639.9969-1-jgross@suse.com> <20180125143639.9969-2-jgross@suse.com>
 <CAHp75VdgdQXH-d9+Fo1DwGdfV1pB0jADMmwAK1BU7oN6dgQs8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36235 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeA2DBq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Jan 2018 22:01:46 -0500
In-Reply-To: <CAHp75VdgdQXH-d9+Fo1DwGdfV1pB0jADMmwAK1BU7oN6dgQs8Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ingo Molnar <mingo@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stable <stable@vger.kernel.org>

On Fri, Jan 26, 2018 at 7:08 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jan 25, 2018 at 4:36 PM, Juergen Gross <jgross@suse.com> wrote:
>> Add a function to get the address of the RSDP table. Per default use a
>> __weak annotated function being a nop.
>
> The problem with weak functions that we can't have more than one
> implementation per kernel while we would like to built several code
> paths.
>
> I have stumbled on the similar stuff and realize that.
>
> Perhaps, one of the solution is to have an additional struct under
> x86_init to alternate ACPI related stuff.

I'm not sure if that really is a problem in this particular case.

Why would you want to use different RSDP retrieval functions for one arch?

Thanks,
Rafael
