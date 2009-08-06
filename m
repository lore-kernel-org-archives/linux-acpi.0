From: Greg KH <greg@kroah.com>
Subject: Re: [RFC PATCH V2 2/2] introduce ACPI ALS device driver
Date: Thu, 6 Aug 2009 11:52:35 -0700
Message-ID: <20090806185235.GA28664@kroah.com>
References: <1249547500.2670.500.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756510AbZHFS6q@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1249547500.2670.500.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Matthew Wilcox <matthew@wil.cx>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 06, 2009 at 04:31:40PM +0800, Zhang Rui wrote:
> 
> ACPI spec defines ACPI Ambient Light Sensor device (hid ACPI0008),
> which provides a standard interface by which the OS may query properties
> of the ambient light environment the system is currently operating in,
> as well as the ability to detect meaningful changes in these values when the
> environment changes.

If you are adding new sysfs files, they need to be documented in
Documentation/ABI at the same time.  Please do that for these.

thanks,

greg k-h
