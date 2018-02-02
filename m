From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/2] x86/acpi: add retrieval function for rsdp address
Date: Fri, 2 Feb 2018 13:02:04 +0100
Message-ID: <CAJZ5v0jSUK7adqNuHRp4VYR2Nb2+Av0dqs-kL1AsEgWk3062eg@mail.gmail.com>
References: <20180125143639.9969-1-jgross@suse.com> <20180125143639.9969-2-jgross@suse.com>
 <CAHp75VdgdQXH-d9+Fo1DwGdfV1pB0jADMmwAK1BU7oN6dgQs8Q@mail.gmail.com>
 <a33e605a-73d7-83b7-4472-14f66b6738be@suse.com> <CAHp75VdUO2Rq7geYD9xxY3nnzGAhO46+w+rQx44=MgJ6obRcEA@mail.gmail.com>
 <CAJZ5v0gr7Jd-1dOD_DTRQDCX7ON68O1KJ9ioAJAnwBYm2cEdZg@mail.gmail.com>
 <CAHp75Vf7SRNGeU_To9WNmzECxaKjDbYeFspnJiwCGAhAwOTRyA@mail.gmail.com>
 <CAJZ5v0g3Ti4W8Z-ePVCO0RFs3qviJxhrh1___i6oiZKRsYzBng@mail.gmail.com> <CAHp75Ved4nO7ktQ=1O5oRx4mNyWcA6YN9fATgMGW1OR0UxCd4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAHp75Ved4nO7ktQ=1O5oRx4mNyWcA6YN9fATgMGW1OR0UxCd4g@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Juergen Gross <jgross@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, xen-devel@lists.xenproject.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ingo Molnar <mingo@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stable <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Feb 1, 2018 at 4:45 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Feb 1, 2018 at 9:57 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Wed, Jan 31, 2018 at 4:43 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Mon, Jan 29, 2018 at 5:02 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>> On Sun, Jan 28, 2018 at 4:04 PM, Andy Shevchenko
>>>> <andy.shevchenko@gmail.com> wrote:
>
>>> Instead of declaring function as __weak, establish a new struct for
>>> ACPI related stubs and incorporate it into x86_init.
>>>
>>> That is my proposal. I think I would go this way in my case where I
>>> need to treat differently ACPI HW reduced initialization of legacy
>>> devices.
>>
>> IOW you'd like to have a set of ACPI init callbacks that could be
>> defined by an arch, right?
>
> Correct!

OK
