From: Patrick Mochel <mochel@linux.intel.com>
Subject: Re: PATCH [1/3]: Provide generic backlight support in Asus ACPI driver
Date: Wed, 19 Apr 2006 11:53:54 -0700
Message-ID: <20060419185354.GC15072@linux.intel.com>
References: <20060418082952.GA13811@srcf.ucam.org> <20060418161100.GA31763@linux.intel.com> <20060419184909.GB23513@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:23236 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751067AbWDSS5V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Apr 2006 14:57:21 -0400
Content-Disposition: inline
In-Reply-To: <20060419184909.GB23513@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Apr 19, 2006 at 07:49:09PM +0100, Matthew Garrett wrote:
> Here are some fixed-up versions of my patches to move acpi drivers 
> towards using the standard backlight interface. I've kept the dynamic 
> allocation of backlight_device for now, since changing that would also 
> mean changing the backlight core code and updating other drivers.

Nice, looks good to me. 

Thanks,


	Pat
