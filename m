From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
Date: Fri, 5 Apr 2019 10:44:35 +0800
Message-ID: <20190405024350.rbwbiaxjybrmqea6@mail.google.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
 <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
 <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com>
 <20190403133613.13f3fd75@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403133613.13f3fd75@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Changbin Du <changbin.du@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

+ Bjorn

On Wed, Apr 03, 2019 at 01:36:13PM -0600, Jonathan Corbet wrote:
> On Tue, 2 Apr 2019 10:25:23 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> 
> > There are ACPI-related documents currently in Documentation/acpi/ that
> > don't clearly fall under either driver-api or admin-guide.  For
> > example, some of them describe various aspects of the ACPI support
> > subsystem operation and some document expectations with respect to the
> > ACPI tables provided by the firmware etc.
> > 
> > Where would you recommend to put them after converting to .rst?
> 
> OK, I've done some pondering on this.  Maybe what we need is a new
> top-level "hardware guide" book meant to hold information on how the
> hardware works and what the kernel's expectations are.  Architecture
> information could maybe go there too.  Would this make sense?
> 
> If so, I could see a division like this:
> 
> Hardware guide
> 	acpi-lid
> 	aml-debugger (or maybe driver api?)
> 	debug (ditto)
> 	DSD-properties-rules
> 	gpio-properties
> 	i2c-muxes
> 
> Admin guide
> 	cppc_sysfs
> 	initrd_table_override
> 
> Driver-API
> 	enumeration
> 	scan_handlers
> 
> other:
> 	dsdt-override: find another home for those five lines
>
Then, should we create dedicated sub-directories for these new charpters and
move documents to coresspoding one? Now we have 'admin-guide' and all admin-guid
docs are under it, otherwise we will have reference across different folders.
For example, the 'admin-guide/index.rst' will have:
    ...
    ../acpi/osi
    ...
Which seems not good.

> ...and so on.  I've probably gotten at least one of those wrong, but that's
> the idea.
> 
> Of course, then it would be nice to better integrate those documents so
> that they fit into a single coherent whole...a guy can dream...:)
>
I am not an adminstrator, so I don't know how adminstrators use this kernel
documentation. But as a kernel developer, I prefer all related documents
integrated into one charpter. Because I probably miss some useful sections
if the documents are distributed into several charpters. And this is usually
how a book is written (One charpter focus on one topic and has sub-sections
such as overview, backgroud knowledge, implemenation details..),
but a book mostly target on hypothetical readers...

> Thanks,
> 
> jon

-- 
Cheers,
Changbin Du
