From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv3 03/13] acpi/hmat: Parse and report heterogeneous memory
Date: Tue, 15 Jan 2019 10:07:42 -0700
Message-ID: <20190115170741.GB27730@localhost.localdomain>
References: <20190109174341.19818-1-keith.busch@intel.com>
 <20190109174341.19818-4-keith.busch@intel.com>
 <CAJZ5v0jk7ML21zxGwf9GaGNK8tP1LAs6Rd9NTK5O9HbzYeyPLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jk7ML21zxGwf9GaGNK8tP1LAs6Rd9NTK5O9HbzYeyPLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Hansen, Dave" <dave.hansen@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 10, 2019 at 07:42:46AM -0800, Rafael J. Wysocki wrote:
> On Wed, Jan 9, 2019 at 6:47 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > Systems may provide different memory types and export this information
> > in the ACPI Heterogeneous Memory Attribute Table (HMAT). Parse these
> > tables provided by the platform and report the memory access and caching
> > attributes.
> >
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> 
> While this is generally fine by me, it's another piece of code going
> under drivers/acpi/ just because it happens to use ACPI to extract
> some information from the platform firmware.
> 
> Isn't there any better place for it?

I've tried to abstract the user visible parts outside any particular
firmware implementation, but HMAT parsing is an ACPI specific feature,
so I thought ACPI was a good home for this part. I'm open to suggestions
if there's a better place. Either under in another existing subsystem,
or create a new one under drivers/hmat/?
