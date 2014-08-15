From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/2] USB: Use ACPI device information
Date: Fri, 15 Aug 2014 02:03 +0200
Message-ID: <2900724.9cEGLmq8Xk@vostro.rjw.lan>
References: <1407950132-15863-1-git-send-email-sameo@linux.intel.com> <2225297.jp5n9UkMJt@vostro.rjw.lan> <20140814004532.GA26547@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60980 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754446AbaHNXoI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Aug 2014 19:44:08 -0400
In-Reply-To: <20140814004532.GA26547@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-acpi@vger.kernel.org, Faouaz TENOUTIT <faouaz.tenoutit@intel.com>

On Thursday, August 14, 2014 08:45:32 AM Greg Kroah-Hartman wrote:
> On Thu, Aug 14, 2014 at 02:17:59AM +0200, Rafael J. Wysocki wrote:
> > On Thursday, August 14, 2014 06:03:09 AM Greg Kroah-Hartman wrote:
> > > On Wed, Aug 13, 2014 at 07:15:31PM +0200, Samuel Ortiz wrote:
> > > > From: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
> > > > 
> > > > Use ACPI device pld information instead of calling
> > > > acpi_get_physical_device_location.
> > > 
> > > Why?  What does this do "better" than the existing code?
> > 
> > Well, you've acked this patch before. :-)
> 
> I can't remember what I ate for Lunch yesterday, let alone previous
> patches I've acked :)
> 
> > It just doesn't execute AML from within the USB core.  I thought that would
> > be a sufficient reason, wouldn't it?
> 
> Yes, that's fine, but a little more description of "why" would have been
> helpful here...

Since we are going to export _PLD output via sysfs ([PATCH 2/2]) and it's
guaranteed to return the same data every time it is evaluated, it simply
makes more sense to evaluate it once and cache the data for when it's
needed.  This particular one makes USB use the cached data.

Rafael

