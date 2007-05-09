From: Len Brown <lenb@kernel.org>
Subject: Re: Laptop screen doesn't come on when lid is reopened
Date: Wed, 9 May 2007 11:48:20 -0400
Message-ID: <200705091148.21097.lenb@kernel.org>
References: <463E37EE.2060008@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48341 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754215AbXEIPtq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2007 11:49:46 -0400
In-Reply-To: <463E37EE.2060008@gentoo.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-acpi@vger.kernel.org, luming.yu@intel.com

On Sunday 06 May 2007 16:17, Daniel Drake wrote:
> Hi,
> 
> Like many Dell's, my Inspiron 640m turns off the LCD display when the 
> lid is closed, but doesn't power it back up when the lid is opened.
> 
> This has been discussed before, with the conclusion that it's a BIOS bug 
> which Linux can't fix (i.e. including a link in the kernel from ACPI to 
> video isn't practical). However I'd like to revisit this as I believe 
> I've found some information which wasn't discussed/observed before:
> 
> The lid notification method can be seen here: 
> http://bugzilla.kernel.org/show_bug.cgi?id=5155#c6
> 
> Of specific interest, the lid notification comes with video 
> notifications - the DSDT seems to be expecting the OS to do something 
> with the video hardware.
> 
> I dug further and found that the first Store in that method is what 
> turns the display off, and the following If always triggers (for both 
> open and close events) in my testing. Sidenote: this means that the DSDT 
> turns the display off both on close and on open.
> 
> I also found that no link to the video layer of the kernel would be 
> needed to restore the display here: the _DSS method of the LCD device 
> will happily turn the display back on.
> 
> I fixed my DSDT with this modification:
> 
>       Method (LIDE, 0, NotSerialized)
>       {
> +        // If lid open, enable video
> +        If (LNotEqual(\_SB.LID._LID(), 0)) {
> +            \_SB.PCI0.VID.LCD._DSS(0x80000001)
> +            Notify (\_SB.LID, 0x80)
> +            Return
> +        }
> +
> +        // If lid closed, continue
> +
> +        // The following Store turns the LCD off
>           Store (SMI (0x43, 0x00), Local0)
>           If (LAnd (LNotEqual (Local0, 0x00), LNotEqual (Local0, 0x0F)))
> 
> Works nicely, woohoo!
> 
> I'd now like to investigate moving this modification into the kernel so 
> that no DSDT changes are required. I'm running into some problems here:
> 
> If I create an acpi_driver alongside the button driver, the button 
> driver claims the lid and my driver doesn't. I presume this is by design 
> -- I was hoping that he subsystem would allow 2 drivers to work on the 
> same device.
> 
> I then tried creating a new module which would use acpi_get_handle() to 
> find the lid handle, and then acpi_install_notify_handler() to set up an 
> event handler. I was hoping that the subsystem would allow multiple 
> handlers on one event, but it appears I'm out of luck again: While the 
> button driver is loaded and subscribed to this event, my driver gets the 
> AE_ALREADY_EXISTS error code.
> 
> Are there other approaches I can take here? I'm hoping to create some 
> kind of "Dell extras" driver, which contains a list of buggy systems, 
> and listens for the lid events. When it detects a lid open event, it 
> will call _DSS on the LCD device.

First the generic acpi video driver needs to be enhanced
to support the ACPI display switching features.
Luming has posed patches along these lines already.

Then we should use that to discover if invoking _DSS
fixes more machines than this pair of Dell laptops,
and if it causes any others to break.

Assuming that it works on the Dells, hopefully more
than the Dells, and doesn't break any others...

Then the button driver should take the lid event and
cause the code in the video driver to be invoked.
I'm not sure what the best method for inter-driver
event like this, since both of them can be modules.

Finally, the video driver should have suspend/resume methods
that poke _DSS and that should fix the Dell video on S3.

-Len
