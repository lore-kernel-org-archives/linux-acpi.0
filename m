From: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2 00/24] Include linux ACPI docs into Sphinx TOC tree
Date: Thu, 11 Apr 2019 23:12:36 +0800
Message-ID: <20190411151234.fvowhdqbfmwc6icr@mail.google.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
 <CAJZ5v0gKX9E+U_9eKfTr7pWGH=jxMLz_Jr850-6BcbG3xBz5qg@mail.gmail.com>
 <CAJZ5v0jbCi3Jgn5YXPCP+zgs-O7z-9_3p3XZGvm40_6RDsJqkQ@mail.gmail.com>
 <20190403133613.13f3fd75@lwn.net>
 <CAJZ5v0gWmmNwiNW=5XgpO6EJw6cAXpwOOePOtuGmR_JzrC+64g@mail.gmail.com>
 <20190409152638.5b20c77f@lwn.net>
 <CAJZ5v0jgbvixMJTVPfEHMX0z-ssc9ZcMRCwS-QEyqtkFWcNh5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jgbvixMJTVPfEHMX0z-ssc9ZcMRCwS-QEyqtkFWcNh5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Changbin Du <changbin.du@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 09, 2019 at 11:44:11PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 9, 2019 at 11:26 PM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > On Tue, 9 Apr 2019 18:42:59 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > > Hardware guide
> > >
> > > This is more about documenting the expectations regarding the platform
> > > firmware, so what about firmware-guide instead?
> >
> > I had imagined a slightly wider focus, but this seems OK for now.  We can
> > always rename it later :)
> >
> > > So what about this:
> > >
> > > - Create a new firmware-guide under Documentation and add an acpi/
> > > directory to it for starters.  Put the following files into it:
> > >
> > >          acpi-lid
> > >          aml-debugger
> > >          debug (ditto)
> > >          DSD-properties-rules
> > >          gpio-properties
> > >          i2c-muxes
> > >
> > > - Add an acpi/ subdirectory to Documentation/admin-guide and put the
> > > following files into it:
> > >
> > >          cppc_sysfs
> > >          initrd_table_override
> > >          dsdt-override
> >
> > I do wonder if, rather than creating a new directory, we shouldn't just
> > make a single acpi.rst and put that information into it?
> >
> > > - Add an acpi/ subdirectory to Documentation/driver-api and put the
> > > following files into it:
> > >
> > >          enumeration
> > >          scan_handlers
> >
> > ...and something similar here?  I guess that would be my preference, but I
> > don't feel all that strongly about it if there's reasons to do otherwise.
> 
> The primary reason would be to retain the correspondence between the
> old and the new files.
> 
> I guess they could be combined, but that would be two sort of
> different changes in one go.
> 
> > In general the plan seems good.
> 
> OK, thanks!
> 
> Cheers,
> Rafael
Ok, if we have reached this greement, I probably do it this weekend. Thanks for your
comments.

-- 
Cheers,
Changbin Du
