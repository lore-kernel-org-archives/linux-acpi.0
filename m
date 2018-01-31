From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [Patch v1 3/8] ACPI / LPIT: Export lpit_read_residency_count_address()
Date: Wed, 31 Jan 2018 18:47:28 +0200
Message-ID: <CAHp75Vc6S__Ovhka5DNUhVEiybDewqM9hvnhZw_1j9VTfq3kxw@mail.gmail.com>
References: <1516352307-20123-1-git-send-email-rajneesh.bhardwaj@intel.com>
 <1516352307-20123-4-git-send-email-rajneesh.bhardwaj@intel.com>
 <CAHp75VezHm3h5WRsm8ep=179qwCz=gep0hbUAcT3+qbH=_8dXQ@mail.gmail.com> <CAJZ5v0hfRKxQLzyCtUdHyRECBFmj0Gho_Jc7mrY0fC+v8t0uhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hfRKxQLzyCtUdHyRECBFmj0Gho_Jc7mrY0fC+v8t0uhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vishwanath Somayaji <vishwanath.somayaji@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 29, 2018 at 5:09 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Jan 26, 2018 at 10:48 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Fri, Jan 19, 2018 at 10:58 AM, Rajneesh Bhardwaj
>> <rajneesh.bhardwaj@intel.com> wrote:
>>> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>>
>>> Export lpit_read_residency_count_address(), so that it can be used from
>>> drivers built as module. With the recent changes, the builtin_pci
>>> functionality of the intel_pmc_core driver is removed and now it can be
>>> built as a module to read this exported interface to calculate the PMC base
>>> address.
>>>
>>
>> This needs Ack from ACPI maintainer(s).
>>
>> Rafael, are you OK with exporting this method?
>
> I have no particular objection at this point.

I took it as an ACK.
Tell me if I'm wrong.

-- 
With Best Regards,
Andy Shevchenko
