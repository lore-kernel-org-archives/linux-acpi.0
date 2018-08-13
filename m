From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 05/11] ACPICA: AML Parser: skip opcodes that open a scope
 upon parse failure
Date: Mon, 13 Aug 2018 20:51:24 +0200
Message-ID: <20180813185124.GA5606@kroah.com>
References: <20180810214304.13475-1-erik.schmauss@intel.com>
 <20180810214304.13475-6-erik.schmauss@intel.com>
 <CAJZ5v0j1TSF39Y5xt4T3OsTfOFjafUiXvQOAjedxV8sA0Mn6-w@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53BB67573@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53BB67573@ORSMSX110.amr.corp.intel.com>
Sender: stable-owner@vger.kernel.org
To: "Schmauss, Erik" <erik.schmauss@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, stable <stable@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 13, 2018 at 05:52:49PM +0000, Schmauss, Erik wrote:
> 
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rafael@kernel.org]
> > Sent: Sunday, August 12, 2018 2:47 AM
> > To: Schmauss, Erik <erik.schmauss@intel.com>
> > Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Rafael J. Wysocki
> > <rjw@rjwysocki.net>
> > Subject: Re: [PATCH 05/11] ACPICA: AML Parser: skip opcodes that open a scope
> > upon parse failure
> > 
> > On Fri, Aug 10, 2018 at 11:45 PM Erik Schmauss <erik.schmauss@intel.com>
> > wrote:
> > >
> > > This change skips the entire length of opcodes that open a scope
> > > (Device, Scope, Processor, etc) if the creation of the op fails. The
> > > failure could be caused by various errors including AE_ALREADY_EXISTS
> > > and AE_NOT_FOUND.
> > >
> > > Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> > > Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> > 
> > I think that we should propagate this fix to the "stable" kernel series, at least
> > 4.17.y and newer.  Do you agree?
> 
> Yes, I agree.
> 
> Hi Greg, please add this to the stable kernel

What commit id should I add to the stable kernel?

thanks,

greg k-h
