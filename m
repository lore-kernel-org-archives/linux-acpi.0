From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Driver for handling SCI interrupt.
Date: Thu, 9 Feb 2012 12:36:02 +0000
Message-ID: <20120209123601.GA27943@srcf.ucam.org>
References: <CADVYk4RTY3=Xiw5JsiDssN9i3yo+jQw1p_i42tKrMDVH5=_ykQ@mail.gmail.com>
 <20120206145759.GA29805@srcf.ucam.org>
 <CADVYk4T3wAjE3qFFynbmnceLeNFSRb+M+Lq6qw2c9ncGJS6V9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57186 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab2BIMgG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2012 07:36:06 -0500
Content-Disposition: inline
In-Reply-To: <CADVYk4T3wAjE3qFFynbmnceLeNFSRb+M+Lq6qw2c9ncGJS6V9g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Toussaint <daniel@dmhome.net>
Cc: linux-acpi@vger.kernel.org

On Thu, Feb 09, 2012 at 01:24:02PM +0800, Daniel Toussaint wrote:
> Thanks very much for the very helpful info.
> I have added the GPE to my DSDT and now I can see the GPE counter in
> /sys/firmware/acpi/interrupts increasing whenever I send an SCI.
> Further more, I  found the function acpi_install_gpe_handler in the
> kernel, and used it successfully to install a handler in a temporary
> driver I created.
> My custom device is an I2C device that I will read input from ,
> whenever my gpe event occurs. Now my question is : this seems to work
> without declaring a new device in the DSDT , with an HID - as you
> mentioned - so can I get away with doing things this way , or would it
> be bad practice ?

Well, if it works, you can obviously do it without any further 
modification :) It would arguably be more "correct" to define it as a 
full ACPI device - that way you can have module autoloading and 
automatic resource discovery. But if you're happy with a static 
configuration then just go with what you have now.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
