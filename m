From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/2] x86/acpi: add retrieval function for rsdp address
Date: Thu, 1 Feb 2018 17:45:02 +0200
Message-ID: <CAHp75Ved4nO7ktQ=1O5oRx4mNyWcA6YN9fATgMGW1OR0UxCd4g@mail.gmail.com>
References: <20180125143639.9969-1-jgross@suse.com> <20180125143639.9969-2-jgross@suse.com>
 <CAHp75VdgdQXH-d9+Fo1DwGdfV1pB0jADMmwAK1BU7oN6dgQs8Q@mail.gmail.com>
 <a33e605a-73d7-83b7-4472-14f66b6738be@suse.com> <CAHp75VdUO2Rq7geYD9xxY3nnzGAhO46+w+rQx44=MgJ6obRcEA@mail.gmail.com>
 <CAJZ5v0gr7Jd-1dOD_DTRQDCX7ON68O1KJ9ioAJAnwBYm2cEdZg@mail.gmail.com>
 <CAHp75Vf7SRNGeU_To9WNmzECxaKjDbYeFspnJiwCGAhAwOTRyA@mail.gmail.com> <CAJZ5v0g3Ti4W8Z-ePVCO0RFs3qviJxhrh1___i6oiZKRsYzBng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:39798 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeBAPpD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Feb 2018 10:45:03 -0500
In-Reply-To: <CAJZ5v0g3Ti4W8Z-ePVCO0RFs3qviJxhrh1___i6oiZKRsYzBng@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ingo Molnar <mingo@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stable <stable@vger.kernel.org>

On Thu, Feb 1, 2018 at 9:57 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jan 31, 2018 at 4:43 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Mon, Jan 29, 2018 at 5:02 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Sun, Jan 28, 2018 at 4:04 PM, Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:

>> Instead of declaring function as __weak, establish a new struct for
>> ACPI related stubs and incorporate it into x86_init.
>>
>> That is my proposal. I think I would go this way in my case where I
>> need to treat differently ACPI HW reduced initialization of legacy
>> devices.
>
> IOW you'd like to have a set of ACPI init callbacks that could be
> defined by an arch, right?

Correct!

And since there is another potential user (Xen) for this approach I
consider it a good chance to be chosen.
Though I have no idea if Xen can do things differently.

-- 
With Best Regards,
Andy Shevchenko
