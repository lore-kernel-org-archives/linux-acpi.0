From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/2] USB: Use ACPI device information
Date: Thu, 14 Aug 2014 02:17:59 +0200
Message-ID: <2225297.jp5n9UkMJt@vostro.rjw.lan>
References: <1407950132-15863-1-git-send-email-sameo@linux.intel.com> <20140813220309.GE7908@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61689 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751984AbaHMX7H (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Aug 2014 19:59:07 -0400
In-Reply-To: <20140813220309.GE7908@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-acpi@vger.kernel.org, Faouaz TENOUTIT <faouaz.tenoutit@intel.com>

On Thursday, August 14, 2014 06:03:09 AM Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2014 at 07:15:31PM +0200, Samuel Ortiz wrote:
> > From: Faouaz TENOUTIT <faouaz.tenoutit@intel.com>
> > 
> > Use ACPI device pld information instead of calling
> > acpi_get_physical_device_location.
> 
> Why?  What does this do "better" than the existing code?

Well, you've acked this patch before. :-)

It just doesn't execute AML from within the USB core.  I thought that would
be a sufficient reason, wouldn't it?

Rafael

