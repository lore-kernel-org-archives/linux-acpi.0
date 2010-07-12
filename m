From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add intel drm blacklist to intel_opregion_present
	detect
Date: Mon, 12 Jul 2010 16:19:36 +0100
Message-ID: <20100712151936.GA13235@srcf.ucam.org>
References: <4C3BBD6D020000230001CD30@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33390 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600Ab0GLPTq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jul 2010 11:19:46 -0400
Content-Disposition: inline
In-Reply-To: <4C3BBD6D020000230001CD30@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: dri-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis.Jansen@web.de

On Mon, Jul 12, 2010 at 09:12:13AM -0600, Joey Lee wrote:

> M... Follow your suggestion, I am tracing the i915 drm driver and
> Poulsbo drm driver from here:
> 
> http://sourceforge.net/mailarchive/message.php?msg_name=49C2ADA8.2090405%40shipmail.org
> 
> I am not sure fully understood your suggestion... Did you mean we can
> extract some parts from Poulsbo drm driver and put it to a stub
> backlight control driver for Poulsbo? Where can we put the stub driver?
> Do we still put it in i915 drm? 

Pretty much, yeah. You'd need the interrupt handler and the backlight 
control and pretty much nothing else. It should be a separate driver 
under drivers/gpu and ideally the opregion code would be sufficiently 
abstracted to work with it.

> On the other hand, the Poulsbo is a old and stop ship chip, do we still
> want to add a special driver for it?

Yeah, that's my concern. There's millions of things in the wild and 
Intel continue to refuse to take responsibility for them, so it's not 
clear to me that it's worth putting the effort into writing a "correct" 
driver.

> Thank's for your remind, I fully agreed cann't guarantee all poulsbo
> systems have working acpi method. But, I am sure the MSI U110/U115 have
> workable acpi backlight method.
> Do you think it's good to put the special DMI detection in msi-laptop
> driver to enable the the acpi backlight control by call
> acpi_video_register in acpi video? But will cause msi-laptop driver
> dependency to acpi video driver.

Mm. Well, we *know* that opregion won't work on Poulsbo as is (even 
Intel's driver doesn't implement it), so there's no way this patch can 
make things any worse. On the other hand, if anyone ships an OS with 
this hack *and* a native psb driver, I'm going to look sad for some 
time.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
