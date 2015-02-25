From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [RFC PATCH] gpio: support for GPIO forwarding
Date: Wed, 25 Feb 2015 10:34:45 +0900
Message-ID: <CAAVeFuKhD2VBf3EOCjHqJK5CLx4qC8Quire2My9nMqboZzSNZQ@mail.gmail.com>
References: <1418890998-23811-1-git-send-email-heikki.krogerus@linux.intel.com>
 <CAAVeFuJUxad0dJ9vK1DaDJPDLM+rc5b77=PgcJT5+Bv1=iWGxg@mail.gmail.com>
 <CACRpkdZzCX0O1wX=W5RbjLcqOF_R3HMTT1w59oFu=JfPauLNuw@mail.gmail.com>
 <4078818.ecVtLF3hjd@vostro.rjw.lan> <CAAVeFuJjMDfz7TZexkYnYrCGkAmRwubs32UhSPO-4qZWbMJjuQ@mail.gmail.com>
 <20150224203459.GC13094@psi-dev26.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224203459.GC13094@psi-dev26.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Darren Hart <dvhart@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 25, 2015 at 5:34 AM, David Cohen
<david.a.cohen@linux.intel.com> wrote:
> Hi,
>
>> If we decide to go ahead with the solution proposed by this patch for
>> practical reasons (which are good reasons indeed), I still have one
>> problem with its current form.
>>
>> As the discussion highlighted, this is an ACPI problem, so I'd very
>> much like it to be confined to the ACPI GPIO code, to be enabled only
>> when ACPI is, and to use function names that start with acpi_gpio. The
>> current implementation leverages platform lookup, making said lookup
>> less efficient in the process and bringing confusion about its
>> purpose. Although the two processes are indeed similar, they are
>> separate things: one is a legitimate way to map GPIOs, the other is a
>> fixup for broken firmware.
>>
>> I suppose we all agree this is a hackish fix, so let's confine it as
>> much as we can.
>
> Are we considering MFD cases hackish as well?
> i.e. if we have a driver that needs to register children devices and this
> driver needs to pass GPIO to a child.

In that case wouldn't the GPIO be best defined in the child node
itself, for the child device's driver to directly probe?
