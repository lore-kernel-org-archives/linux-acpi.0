From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 1/2] x86/acpi: add retrieval function for rsdp address
Date: Fri, 26 Jan 2018 19:21:13 +0100
Message-ID: <a33e605a-73d7-83b7-4472-14f66b6738be@suse.com>
References: <20180125143639.9969-1-jgross@suse.com>
 <20180125143639.9969-2-jgross@suse.com>
 <CAHp75VdgdQXH-d9+Fo1DwGdfV1pB0jADMmwAK1BU7oN6dgQs8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdgdQXH-d9+Fo1DwGdfV1pB0jADMmwAK1BU7oN6dgQs8Q@mail.gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ingo Molnar <mingo@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 26/01/18 19:08, Andy Shevchenko wrote:
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

I think we can go that route when another user of that interface is
appearing.


Juergen
