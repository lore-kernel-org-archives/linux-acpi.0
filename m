From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] ACPI: Reorder IPMI driver before any other ACPI
 drivers
Date: Fri, 21 Sep 2012 02:26:25 +0100
Message-ID: <20120921012625.GA13396@srcf.ucam.org>
References: <1348177573-7537-1-git-send-email-mjg@redhat.com>
 <505BC0B4.4010306@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40847 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab2IUB0c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Sep 2012 21:26:32 -0400
Content-Disposition: inline
In-Reply-To: <505BC0B4.4010306@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <cminyard@mvista.com>
Cc: yakui.zhao@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 20, 2012 at 08:19:48PM -0500, Corey Minyard wrote:
> On 09/20/2012 04:46 PM, Matthew Garrett wrote:
> >Drivers may make calls that require the ACPI IPMI driver to have been
> >initialised already, so make sure that it appears earlier in the build
> >order.
> 
> The IPMI driver uses the ACPI namespace as an option to know the
> address and characteristics of the device.  Does that still work?

Yes, the ACPI interpreter is initialised earlier than the IPMI driver 
discovery.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
