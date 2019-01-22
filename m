From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
Date: Tue, 22 Jan 2019 09:36:50 -0700
Message-ID: <20190122163650.GD1477@localhost.localdomain>
References: <20190116175804.30196-1-keith.busch@intel.com>
 <20190116175804.30196-6-keith.busch@intel.com>
 <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
 <CAPcyv4gH0_e_NFJNOFH4XXarSs7+TOj4nT0r-D33ZGNCfqBdxg@mail.gmail.com>
 <20190119090129.GC10836@kroah.com>
 <CAJZ5v0jxuLPUvwr-hYstgC-7BKDwqkJpep94rnnUFvFhKG4W3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jxuLPUvwr-hYstgC-7BKDwqkJpep94rnnUFvFhKG4W3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 20, 2019 at 05:16:05PM +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 19, 2019 at 10:01 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > If you do a subdirectory "correctly" (i.e. a name for an attribute
> > group), that's fine.
> 
> Yes, that's what I was thinking about: along the lines of the "power"
> group under device kobjects.

We can't append symlinks to an attribute group, though. I'd need to create
a lot of struct devices just to get the desired directory hiearchy. And
then each of those "devices" will have their own "power" group, which
really doesn't make any sense for what we're trying to show. Is that
really the right way to do this, or something else I'm missing?
