From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv4 06/13] acpi/hmat: Register processor domain to its memory
Date: Thu, 17 Jan 2019 09:01:27 -0800
Message-ID: <CAPcyv4i9Doi_cE8KkB-PjzPyU2GoscvJbKTJzaX1esVQQ=dxMA@mail.gmail.com>
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-7-keith.busch@intel.com>
 <CAJZ5v0jg24sNVQiA1AvVwP-uCCq1Uo9rxkAERyb_zDL_W8AATA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jg24sNVQiA1AvVwP-uCCq1Uo9rxkAERyb_zDL_W8AATA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Hansen <dave.hansen@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 17, 2019 at 4:11 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>     On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > If the HMAT Subsystem Address Range provides a valid processor proximity
> > domain for a memory domain, or a processor domain with the highest
> > performing access exists, register the memory target with that initiator
> > so this relationship will be visible under the node's sysfs directory.
> >
> > Since HMAT requires valid address ranges have an equivalent SRAT entry,
> > verify each memory target satisfies this requirement.
>
> What exactly will happen after this patch?
>
> There will be some new directories under
> /sys/devices/system/node/nodeX/ if all goes well.  Anything else?

When / if the memory randomization series [1] makes its way upstream
there will be a follow-on patch to enable that randomization based on
the presence of a memory-side cache published in the HMAT.

[1]: https://lwn.net/Articles/767614/
