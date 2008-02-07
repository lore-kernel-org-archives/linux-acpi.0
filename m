From: Len Brown <lenb@kernel.org>
Subject: Re: Exposing WMI on Linux
Date: Wed, 6 Feb 2008 23:36:17 -0500
Message-ID: <200802062336.17586.lenb@kernel.org>
References: <7905FFCA2E893B41B7697977B01334D4029723ED@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37971 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755525AbYBGEhV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Feb 2008 23:37:21 -0500
In-Reply-To: <7905FFCA2E893B41B7697977B01334D4029723ED@hdsmsx411.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Nashif, Anas" <anas.nashif@intel.com>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Wednesday 30 May 2007 16:12, you wrote:
> 
> Here are some pointers as promised:
> 
> http://developer.novell.com/wiki/index.php/OMC
> 
> This is a Novell project with many providers dealing will many aspects
> of the OS. They also provide RPMs for OpenSUSE and is the main source
> for the OpenWBEM CIMOM binaries for SUSE.
> 
> http://sblim.wiki.sourceforge.net/
> 
> Is the IBM project dealing with instrumentation and home of the SFCB
> CIMOM targeting embedded environments and only supports CMPI providers.
> 
> http://sblim.wiki.sourceforge.net/ProviderCmpiSysfs is a sysfs provider.
> Seems to be old but is a good example.
> 
> http://openpegasus.org/
> 
> This is the home of the OpenPeagsus CIMOM, supported by multiple
> vendors.
> 
> http://www.dmtf.org/standards/wbem/ is about the WBEM protocol. Also the
> tutorial is good: http://www.wbemsolutions.com/tutorials/CIM/wbem.html
> 
> http://cimple.org/ tries to make writing providers easy.
> 

Anas,
We could use some help on how to expose WMI to user-space in Linux.
(Then we could use some help on user-space using that interface:-)

Carlos has cooked up an ACPI-WMI mapping driver for Linux,
and has two in-kernel platform specific drivers that want
to talk to it (acer-laptop and HP Compaq TC1100 Tablets),
and Matthew has been poking at an HP driver to use WMI
to access some laptop functionas as well.

But nobody is thinking about how to hook this up
to the user-space management infrastructure in Linux,
and what the kernel/user interface to to best do
that would be.

Carlos prototyped a sysfs I/F, but that doesn't seem to fit
the WMI transaction model, so he's wondering if an ioctl
I/F would be more appropriate where transaction consistency
can be enforced by the driver, perhaps with a library
on top of it.

Please advise.

thanks,
-Len
