From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH 3/4] pinctrl: Add ACPI support
Date: Tue, 5 Apr 2016 10:49:15 +0300
Message-ID: <20160405074915.GD1727@lahna.fi.intel.com>
References: <1459424685-26965-1-git-send-email-irina.tirdea@intel.com>
 <1459424685-26965-4-git-send-email-irina.tirdea@intel.com>
 <20160404133713.GA1727@lahna.fi.intel.com>
 <1F3AC3675D538145B1661F571FE1805F2F22D806@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:65254 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754531AbcDEHtZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Apr 2016 03:49:25 -0400
Content-Disposition: inline
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F22D806@irsmsx105.ger.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "Ciocan, Cristina" <cristina.ciocan@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 04, 2016 at 02:01:13PM +0000, Tirdea, Irina wrote:
> > > +  {
> > > +      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > > +          Package()
> > > +          {
> > > +              Package (2) {"pins", Package () {pin1, pin2, ...}},
> > > +              Package (2) {configname1, configval1},
> > 
> > These should be enclosed in quotes, like "configname1" and so on.
> > 
> OK. Should all string properties be enclosed in quotes or only the property names
> (e.g. should I also change values like "configval1", "pin1", "statename1", etc.)?

I think all types should be documented using correct format. Strings
should have "" and so on.
