From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] acpi/hmat: Update acpi_hmat_type enum with ACPI_HMAT_TYPE_PROXIMITY
Date: Thu, 18 Apr 2019 17:07:12 +0200
Message-ID: <CAJZ5v0g1EZbzr6BJhVBVb8JZGnVQg2Sz8NHtz_0Ji9R_58wMbA@mail.gmail.com>
References: <20190417181310.27613-1-alison.schofield@intel.com> <20190418145640.GA7659@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418145640.GA7659@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 18, 2019 at 5:02 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Wed, Apr 17, 2019 at 11:13:10AM -0700, Alison Schofield wrote:
> > ACPI 6.3 changed the subtable "Memory Subsystem Address Range Structure"
> > to "Memory Proximity Domain Attributes Structure".
> >
> > Updating and renaming of the structure was included in commit:
> > ACPICA: ACPI 6.3: HMAT updates (9a8d961f1ef835b0d338fbe13da03cb424e87ae5)
>
> I was not really happy with that HMAT update. Platforms implementing
> 6.2's HMAT continue to exist even if 6.3 isn't backward compatible. We
> just lost the original subtable definition.

Well, that's true, sadly, but the question is what to do in the kernel.

Definitely, the 6.3 format needs to be supported, but if the 6.2 ships
anywhere in practice, that will need to be supported too.
