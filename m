From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/2] x86/acpi: add retrieval function for rsdp address
Date: Sun, 28 Jan 2018 17:04:53 +0200
Message-ID: <CAHp75VdUO2Rq7geYD9xxY3nnzGAhO46+w+rQx44=MgJ6obRcEA@mail.gmail.com>
References: <20180125143639.9969-1-jgross@suse.com> <20180125143639.9969-2-jgross@suse.com>
 <CAHp75VdgdQXH-d9+Fo1DwGdfV1pB0jADMmwAK1BU7oN6dgQs8Q@mail.gmail.com> <a33e605a-73d7-83b7-4472-14f66b6738be@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <a33e605a-73d7-83b7-4472-14f66b6738be@suse.com>
Sender: stable-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ingo Molnar <mingo@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 26, 2018 at 8:21 PM, Juergen Gross <jgross@suse.com> wrote:
> On 26/01/18 19:08, Andy Shevchenko wrote:
>> On Thu, Jan 25, 2018 at 4:36 PM, Juergen Gross <jgross@suse.com> wrote:
>>> Add a function to get the address of the RSDP table. Per default use a
>>> __weak annotated function being a nop.
>>
>> The problem with weak functions that we can't have more than one
>> implementation per kernel while we would like to built several code
>> paths.
>>
>> I have stumbled on the similar stuff and realize that.
>>
>> Perhaps, one of the solution is to have an additional struct under
>> x86_init to alternate ACPI related stuff.
>
> I think we can go that route when another user of that interface is
> appearing.

Why not to establish the struct? At least this route I would like to
go with [1].

[1]: https://lkml.org/lkml/2018/1/17/834

-- 
With Best Regards,
Andy Shevchenko
