From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCHv3 03/13] acpi/hmat: Parse and report heterogeneous memory
Date: Tue, 15 Jan 2019 19:36:03 +0100
Message-ID: <CAJZ5v0iZ_i9vOPJgn69T=f8KE=fFm1vQt2AuEaNDGpn3E_cL3g@mail.gmail.com>
References: <20190109174341.19818-1-keith.busch@intel.com> <20190109174341.19818-4-keith.busch@intel.com>
 <CAJZ5v0jk7ML21zxGwf9GaGNK8tP1LAs6Rd9NTK5O9HbzYeyPLA@mail.gmail.com> <20190115170741.GB27730@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115170741.GB27730@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Hansen, Dave" <dave.hansen@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 15, 2019 at 6:09 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Thu, Jan 10, 2019 at 07:42:46AM -0800, Rafael J. Wysocki wrote:
> > On Wed, Jan 9, 2019 at 6:47 PM Keith Busch <keith.busch@intel.com> wrote:
> > >
> > > Systems may provide different memory types and export this information
> > > in the ACPI Heterogeneous Memory Attribute Table (HMAT). Parse these
> > > tables provided by the platform and report the memory access and caching
> > > attributes.
> > >
> > > Signed-off-by: Keith Busch <keith.busch@intel.com>
> >
> > While this is generally fine by me, it's another piece of code going
> > under drivers/acpi/ just because it happens to use ACPI to extract
> > some information from the platform firmware.
> >
> > Isn't there any better place for it?
>
> I've tried to abstract the user visible parts outside any particular
> firmware implementation, but HMAT parsing is an ACPI specific feature,
> so I thought ACPI was a good home for this part. I'm open to suggestions
> if there's a better place. Either under in another existing subsystem,
> or create a new one under drivers/hmat/?

Well, there is drivers/acpi/nfit for the NVDIMM-related things, so
maybe there could be drivers/acpi/mm/ containing nfit/ and hmat.c (and
maybe some other mm-related things)?
