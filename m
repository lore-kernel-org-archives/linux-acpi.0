From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 00/23] Include linux ACPI docs into Sphinx TOC tree
Date: Wed, 01 May 2019 12:15:07 +0200
Message-ID: <3825811.MXkekUSqSZ@kreacher>
References: <20190424175306.25880-1-changbin.du@gmail.com> <CAJZ5v0i3iEyn1vBjPkA0X=8h_UrSeTNV_JduJq9qfYpgCOAPjQ@mail.gmail.com> <20190425152034.u4q6wjhm3yfhbnzp@mail.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425152034.u4q6wjhm3yfhbnzp@mail.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-gpio@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, April 25, 2019 5:20:35 PM CEST Changbin Du wrote:
> On Thu, Apr 25, 2019 at 10:44:14AM +0200, Rafael J. Wysocki wrote:
> > .On Wed, Apr 24, 2019 at 7:54 PM Changbin Du <changbin.du@gmail.com> wrote:
> > >
> > > Hi All,
> > > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > > from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> > > reST format in this serias.
> > >
> > > The hieararchy of ACPI docs are based on Corbet's suggestion:
> > > https://lkml.org/lkml/2019/4/3/1047
> > > I did some adjustment according to the content and finally they are placed as:
> > > Documentation/firmware-guide/acpi/
> > 
> > I'd like to queue up this series, but it is missing a patch to create
> > Documentation/firmware-guide/acpi/index.rst.
> > 
> > Care to provide one?
> oops, the first patch is missed. Let me add it next.

I've picked up the first patch from the v6 and applied this series on top of it.

 Thanks!
