From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
Date: Tue, 9 Apr 2019 18:42:59 +0200
Message-ID: <CAJZ5v0gWmmNwiNW=5XgpO6EJw6cAXpwOOePOtuGmR_JzrC+64g@mail.gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com> <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
 <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com> <20190403133613.13f3fd75@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403133613.13f3fd75@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Changbin Du <changbin.du@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 3, 2019 at 9:36 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
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

This is more about documenting the expectations regarding the platform
firmware, so what about firmware-guide instead?

>         acpi-lid
>         aml-debugger (or maybe driver api?)
>         debug (ditto)
>         DSD-properties-rules
>         gpio-properties
>         i2c-muxes
>
> Admin guide
>         cppc_sysfs
>         initrd_table_override

And I would add dsdt-override here.

>
> Driver-API
>         enumeration
>         scan_handlers
>

So what about this:

- Create a new firmware-guide under Documentation and add an acpi/
directory to it for starters.  Put the following files into it:

         acpi-lid
         aml-debugger
         debug (ditto)
         DSD-properties-rules
         gpio-properties
         i2c-muxes

- Add an acpi/ subdirectory to Documentation/admin-guide and put the
following files into it:

         cppc_sysfs
         initrd_table_override
         dsdt-override

- Add an acpi/ subdirectory to Documentation/driver-api and put the
following files into it:

         enumeration
         scan_handlers
