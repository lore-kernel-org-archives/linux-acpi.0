From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/2] x86/acpi: add retrieval function for rsdp address
Date: Wed, 31 Jan 2018 17:41:27 +0200
Message-ID: <CAHp75VcuUTgVzT0ZTWfQDZOhdjVg8wp5UZC8UY0-eOvy0JVqNw@mail.gmail.com>
References: <20180125143639.9969-1-jgross@suse.com> <20180125143639.9969-2-jgross@suse.com>
 <CAHp75VdgdQXH-d9+Fo1DwGdfV1pB0jADMmwAK1BU7oN6dgQs8Q@mail.gmail.com> <CAJZ5v0gN-w6MJFOuTsircR5kBHz_U38NB7wErREYL=w_tj-hQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:45673 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932066AbeAaPl2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Jan 2018 10:41:28 -0500
In-Reply-To: <CAJZ5v0gN-w6MJFOuTsircR5kBHz_U38NB7wErREYL=w_tj-hQQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ingo Molnar <mingo@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stable <stable@vger.kernel.org>

On Mon, Jan 29, 2018 at 5:01 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Jan 26, 2018 at 7:08 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

>> I have stumbled on the similar stuff and realize that.
>>
>> Perhaps, one of the solution is to have an additional struct under
>> x86_init to alternate ACPI related stuff.
>
> I'm not sure if that really is a problem in this particular case.
>
> Why would you want to use different RSDP retrieval functions for one arch?

I was not clear. I'm talking about approach struct x86_init vs. __weak function.
In my case it has nothing to do with RDSP, but with ACPI stubs.

-- 
With Best Regards,
Andy Shevchenko
