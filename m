From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 21/63] Documentation: ACPI: move cppc_sysfs.txt to
 admin-guide/acpi and convert to reST
Date: Wed, 24 Apr 2019 15:04:28 -0300
Message-ID: <20190424150428.7eb70014@coco.lan>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190423162932.21428-22-changbin.du@gmail.com>
        <20190424114844.5de4cfa5@coco.lan>
        <20190424172232.qtzogm6sweaa4gva@mail.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424172232.qtzogm6sweaa4gva@mail.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changbin Du <changbin.du@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, fenghua.yu@intel.com, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Em Thu, 25 Apr 2019 01:22:34 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> On Wed, Apr 24, 2019 at 11:48:44AM -0300, Mauro Carvalho Chehab wrote:
> > Em Wed, 24 Apr 2019 00:28:50 +0800
> > Changbin Du <changbin.du@gmail.com> escreveu:
> >   
> > > This converts the plain text documentation to reStructuredText format and
> > > add it to Sphinx TOC tree. No essential content change.
> > > 
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > ---
> > >  .../acpi/cppc_sysfs.rst}                      | 71 ++++++++++---------
> > >  Documentation/admin-guide/acpi/index.rst      |  1 +
> > >  2 files changed, 40 insertions(+), 32 deletions(-)
> > >  rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
> > > 
> > > diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> > > similarity index 51%
> > > rename from Documentation/acpi/cppc_sysfs.txt
> > > rename to Documentation/admin-guide/acpi/cppc_sysfs.rst
> > > index f20fb445135d..a4b99afbe331 100644
> > > --- a/Documentation/acpi/cppc_sysfs.txt
> > > +++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> > > @@ -1,5 +1,11 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > >  
> > > -	Collaborative Processor Performance Control (CPPC)
> > > +==================================================
> > > +Collaborative Processor Performance Control (CPPC)
> > > +==================================================
> > > +
> > > +CPPC
> > > +====
> > >  
> > >  CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
> > >  performance of a logical processor on a contigious and abstract performance
> > > @@ -10,31 +16,28 @@ For more details on CPPC please refer to the ACPI specification at:
> > >  
> > >  http://uefi.org/specifications
> > >  
> > > -Some of the CPPC registers are exposed via sysfs under:
> > > -
> > > -/sys/devices/system/cpu/cpuX/acpi_cppc/
> > > -  
> > 
> >   
> > > -for each cpu X  
> > 
> > Hmm... removed by mistake?
> >  
> I comfirmed that no content removed.

At this patch, it looks that you removed the line: "for each cpu X"
(or am I reading it wrong?)

> 
> > > +Some of the CPPC registers are exposed via sysfs under::
> > >  
> > > ---------------------------------------------------------------------------------
> > > +  /sys/devices/system/cpu/cpuX/acpi_cppc/  
> > 
> > Did you parse this with Sphinx? It doesn't sound a valid ReST construction
> > to my eyes, as:
> > 
> > 1) I've seen some versions of Sphinx to abort with severe errors when 
> >    there's no blank line after the horizontal bar markup;
> > 
> > 2) It will very likely ignore the "::" (I didn't test it myself), as you're
> >    not indenting the horizontal bar. End of indentation will mean the end
> >    of an (empty) literal block.
> > 
> > So, I would stick with:
> > 
> > 
> > 	Some of the CPPC registers are exposed via sysfs under:
> > 
> > 	  /sys/devices/system/cpu/cpuX/acpi_cppc/
> > 
> > 	---------------------------------------------------------------------------------
> > 
> > 	for each cpu X::
> > 
> > 
> > or:
> > 
> > 	Some of the CPPC registers are exposed via sysfs under:
> > 
> > 		/sys/devices/system/cpu/cpuX/acpi_cppc/
> > 
> > 	for each cpu X
> > 
> > 	--------------------------------------------------------------------------------
> > 
> > 	::
> > 
> > (with is closer to the original author's intent)
> > 
> > Same applies to the other similar changes on this document.
> >  
> I didn't seen any warning here and the generated html is good. So I think it is
> ok.

Basically, what you're doing is:

<rst>

::

foo
   literal-block bar

</rst>

(where "foo" is the horizontal bar markup)

I would avoid such pattern for two reasons:

1) it sounds a violation of ReST syntax to format an in
   indented paragraph some non-blank lines after a non-indented
   line. As such, I won't doubt that different versions of Sphinx
   would handle it differently. I'm even tempted to open a BZ
   to Sphinx in order for them to provide a fix for that, if the
   latest version of Sphinx accepts such crazy markup.

2) It is very confusing for any human reading it.

Thanks,
Mauro
