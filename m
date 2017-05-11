From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / GED: use late init to allow other drivers init
Date: Thu, 11 May 2017 16:52:23 +0200
Message-ID: <7848366.O4PImzsRl1@aspire.rjw.lan>
References: <1492813704-32280-1-git-send-email-okaya@codeaurora.org> <1874042.5bWzSJ73x0@aspire.rjw.lan> <0a368676-d01a-5ac8-179d-b6e7507fd500@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0a368676-d01a-5ac8-179d-b6e7507fd500@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Lukas Wunner <lukas@wunner.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Abdulhamid, Harb" <harba@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, May 11, 2017 09:43:14 AM Sinan Kaya wrote:
> Hi Rafael,
> 
> On 5/10/2017 8:46 PM, Rafael J. Wysocki wrote:
> >> My proposal was to require platform AML code to indicate the dependencies
> >> between GED and drivers on the right side of the picture via _DEP as this
> >> cannot be done via normal kernel mechanisms.
> > Something like _DEP would be needed.
> > 
> > However, _DEP as specified is only about operation region dependencies, which
> > doesn't seem to be applicable here.
> > 
> > That said, _DEP is used for general dependecies by firmware already, but it
> > would at least be good to send a proposal for a spec update regarding that
> > before mandating using _DEP for GED.
> 
> OK. I'll reach out to Harb and let's see where the proposal goes. 

It looks like this is about operation regions after all, however, so _DEP as is
should be sufficient here.

There is some limited _DEP support in the ACPI layer, but we were missing
a way to represent those dependencies in the driver core.

That can be done through device_link objects now, so we may be able to support
_DEP in a more meaningful way, but the cases when _DEP is used for something
different from operation regions in practice need to be treated with caution.


> > 
> >> This approach might work in general. However, it also has its own caveats.
> >>
> >> All of these drivers on the right side are unrelated to each other. Some
> >> operating system can implement a subset of these drivers.
> >>
> >> If I include the dependencies, GED will never load for partial driver situations.
> >> This is also a deal breaker. 
> > _DEP doesn't mean a hard dependency AFAICS.  It is about ordering, not about
> > presence, at least as specified currently.
> > 
> >> Why would you break some other feature if your OS doesn't support RAS as an
> >> example?
> >>
> >> Given all these lose bindings and no driver association, where do we go
> >> from here?
> >>
> >> I consider GED as a light version of Embedded controller (EC) implementation. 
> > No, it is not.
> 
> Thanks for correction. Let me repeat with the correct terminology this time. 
> 
> Don't we have the same problem on GPE/SCI mechanism?

Yes, in theory.

> An event that SCI is delivering may not be handled because the handler of the
> event is not present during OS boot?

It would be a problem if something like _Lxx or _Exx referred to an operation
region without a handler, but these usually refer to operation regions in
memory or in the PCI config space and there are default operation region
handlers for those address spaces.

Of course, if they referred to operation regions on an I2C bus, for example,
the problem might very well occur in there too.

> The SCI relationship would be:
> 
> | SCI | <--->  | Platform specific ACPI AML (_AEI) | <----> Vendor XYZ driver
>                                               	     <----> Vendor I2C
>                                                      <----> ACPI GHES
> 

This would not be the SCI AFAICS, because _AEI is specific to GPIO interrupts
and it only says which interrupts should be handled by the ACPI layer.  There
needs to be _EVT for handling them just like in the GED case (or the other
way around, actuallly), so this is just analogous to GED.

Thanks,
Rafael
