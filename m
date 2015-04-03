From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3][RFD] device property: Implement fallback to built-in properties
Date: Fri, 03 Apr 2015 15:59:39 +0200
Message-ID: <6006085.9igFVRhWlG@vostro.rjw.lan>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com> <5634167.lftqZnjhIC@vostro.rjw.lan> <20150402143506.GA2057@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59402 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751433AbbDCNfX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2015 09:35:23 -0400
In-Reply-To: <20150402143506.GA2057@kuha.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>

On Thursday, April 02, 2015 05:35:06 PM Heikki Krogerus wrote:
> 
> --AqsLC8rIMeq19msA
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> Hi,
> 
> On Sat, Mar 28, 2015 at 02:26:35AM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Modify the fwnode_property_* accessors so as to make them fall back
> > to using "built-in" device properties from a property_set structure
> > associated with the given device (as the secondary firmware node)
> > if the property in question cannot be retrieved from the primary
> > firmware node (DT or ACPI).  That will make the device_properties_*
> > functions do the same thing as they use fwnode_property_* internally.
> > 
> > That should make it easier to provide default values for device
> > properties used by device drivers to be used in case the properties
> > in question are not provided by the platform firmare at all or
> > they cannot be retireved from the platform firmware due to errors.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> FWIW for the whole series:
> 
> Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> I'm attaching the little patch I used to test this with Synopsys
> Designware USB Device Controller. Everything worked nicely.

Thanks a lot for testing this!

> > First of all, this should show why I thought it would be better to use
> > the primary/secondary scheme for firmware nodes instead of just having a
> > list of them with the head pointed to by the struct device's fwnode field.
> > Namely, within the primary/secondary scheme the ordering of property lookup
> > is always well defined and there's no overhead when, for example, somebody
> > specifically wants to access the ACPI companion firmware node etc.
> > 
> > Second, as I said in the intro message, this is not for immediate application
> > (apart from any review comments on [1-2/3]), because it would introduce an
> > artificial difference between DT and ACPI that I'd prefer to avoid.
> > 
> > Namely, dev_fwnode() (introduced by one of the patches in linux-next) returns
> > the address of the dev->of_node's fwnode field if dev->of_node is present and
> > that would not have the secondary pointer set.  On the other hand, since ACPI
> > is now using set_primary_fwnode() to add its firmware node companions to
> > devices, the secondary pointer in its firmware node handle will be set if the
> > "built-in" properties are present.  So, effectively, with this patch applied
> > ACPI would always fall back to the "built-in" properties (if present), while
> > DT would not do that (unless the DT node is missing entirely).
> > 
> > That difference could be worked around, though, if dev->fwnode is always set
> > whenever dev->of_node is set in essentially this way:
> > 
> > 	dev->of_node = dn;
> > 	set_primary_fwnode(dev, &dn->fwnode);
> > 
> > (that, of course, can be defined as a macro or static inline).  Now, I'm not
> > sure about that, but my somewhat educated guess is that while dev->of_node is
> > read in many many places, the number of places in which it is set is actually
> > much smaller and making this change in one go should be a workable thing.
> > 
> > Please let me know what you think.
> 
> To me falling back to the "built-in" device properties is the most
> interesting thing. I have already a set of mfd and probing drivers,
> such as dwc3-pci.c in my example, in my mind, where I have the ACPI
> companion but could still really use the build-in properties.

Yes, this is the most interesting part to me too, but as I said, I wouldn't like
to introduce functional differences between DT and ACPI due to this and we need
response from the DT party to make changes along the lines of patch [3/3].

For now, let me resend patches [1-2/3] with your Tested-by: tag. :-)

Rafael

