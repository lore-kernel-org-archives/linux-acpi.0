From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: Regression in 3.1 causes Xen to use wrong idle routine
Date: Wed, 26 Oct 2011 09:48:43 -0400
Message-ID: <20111026134843.GA31609@phenom.dumpdata.com>
References: <4EA7DFD1.9060608@canonical.com>
 <20111026133003.GA6654@phenom.dumpdata.com>
 <4EA80CF2.5040309@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:44980 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932680Ab1JZNsz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2011 09:48:55 -0400
Content-Disposition: inline
In-Reply-To: <4EA80CF2.5040309@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: len.brown@intel.com, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> > What about using the cpuidle_disabled() functionality and adhere to that?
> > As so:
> > 
.. snip..
> 
> >From reading over it, this should work. Though I would be interested to hear
> from the linux-acpi folks. Also to double check that calling pm_idle when
> cpuidle.off was specified really is what is intended.

Oh yeah, definitly need the input from linux-acpi folks. And also to be actually
tested :-)
