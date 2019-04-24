From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx
 TOC tree
Date: Wed, 24 Apr 2019 14:48:30 -0300
Message-ID: <20190424144830.3fe92640@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <CAJZ5v0jPyaGQcDfpW5b7A-_3bvkfL78MxFmPtjwCGZ4-=KwUwg@mail.gmail.com>
        <20190423173644.GA14616@google.com>
        <20190424154617.kowr5aamjkeceltr@mail.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424154617.kowr5aamjkeceltr@mail.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PCI <linux-pci@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Wed, 24 Apr 2019 23:46:18 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> On Tue, Apr 23, 2019 at 12:36:44PM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 23, 2019 at 06:39:47PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Apr 23, 2019 at 6:30 PM Changbin Du <changbin.du@gmail.com> wrote:
> > > > Hi Corbet and All,
> > > > The kernel now uses Sphinx to generate intelligent and beautiful
> > > > documentation from reStructuredText files. I converted all of the Linux
> > > > ACPI/PCI/X86 docs to reST format in this serias.
> > > >
> > > > In this version I combined ACPI and PCI docs, and added new x86 docs
> > > > conversion.
> > > 
> > > I'm not sure if combining all three into one big patch series has been
> > > a good idea, honestly.
> > 
> > Yeah, if you post this again, I would find it easier to deal with if
> > linux-pci only got the PCI-related things.  63 patches is a little too
> > much for one series.
> >
> sure, so I will resend them respectively.

I reviewed up to patch 39. There are too many files on x86 that seems
to be mangled by some tab->whitespace conversion, with caused
very big diffs and lots of broken ascii artwork.

Please ensure that the diffs will contain the minimal amount of stuff
that would be required for them to be properly formatted as ReST
files there.

Ah, perhaps next time you could format the patches with a lower
merge similarity logic (using, for example, the parameter -M10).

Regards,
Mauro

> 
> > Bjorn
> 



Thanks,
Mauro
