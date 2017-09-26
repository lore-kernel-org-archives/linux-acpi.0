From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [RFC 0/5] Align and document return values of phandle and
 reference parsing for OF and ACPI
Date: Tue, 26 Sep 2017 12:02:01 +0300
Message-ID: <20170926090201.wcpv4fty5yi5ea6z@valkosipuli.retiisi.org.uk>
References: <20170914122914.14122-1-sakari.ailus@linux.intel.com>
 <CAL_JsqKZVN+X0F3Z8s6Qv+ioh8LBDjNe277MAw30T3CXXTUV1Q@mail.gmail.com>
 <20170919230125.l7fexsdrzbmwd6yp@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:55902 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751840AbdIZJCF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Sep 2017 05:02:05 -0400
Content-Disposition: inline
In-Reply-To: <20170919230125.l7fexsdrzbmwd6yp@valkosipuli.retiisi.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, Frank Rowand <frowand.list@gmail.com>

On Wed, Sep 20, 2017 at 02:01:25AM +0300, Sakari Ailus wrote:
> Hi Rob,
> 
> Thanks for the review.
> 
> On Fri, Sep 15, 2017 at 02:57:35PM -0500, Rob Herring wrote:
> > On Thu, Sep 14, 2017 at 7:29 AM, Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > > Hi everyone,
> > >
> > > I recently came across a difference in behaviour of OF phandle parsing and
> > > ACPI reference parsing, both of which can soon be accessed using
> > > fwnode_property_get_reference_args.
> > >
> > > The main change in this proposal touches OF, and specifically the change
> > > is about using -ENODATA to tell that the phandle reference list entry that
> > > was accessed does not exist. -ENOENT was used previously, but the same
> > > error code was also used to tell that a phandle was empty, making it
> > > impossible for the caller to figure out which of the two was the case.
> > >
> > > I'm sending the set as RFC. In my limited testing I have found no ill
> > > effects.
> > >
> > > These patches are on top of linux-next.
> > >
> > > Comments on the approach and the changes themselves would be most welcome.
> > 
> > It's not really valid to both have a variable count (and hence need to
> > retrieve it) and use blank phandle entries. The whole point of blank
> > entries is to have a fixed length and know what each index corresponds
> > too. Do you have an example where we hit this?
> 
> Well, the above is true. I think I'd still use different error codes to
> tell about different situations.
> 
> The alternative is that the fwnode counterpart error codes are changed to
> to -ENOENT.

I'll post a patch implemeting switching the fwnode variant to use -ENOENT,
cc'ing you. I think the first patch of the set is still relevant, it's
rather a bugfix.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
