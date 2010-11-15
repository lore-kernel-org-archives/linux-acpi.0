From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI_VIDEO and BACKLIGHT_CLASS_DEVICE
Date: Mon, 15 Nov 2010 08:33:43 +0800
Message-ID: <1289781223.8148.1805.camel@rui>
References: <20101112034614.GB7407@srcf.ucam.org>
	 <Pine.LNX.4.44L0.1011121624440.21040-100000@netrider.rowland.org>
	 <20101112213601.GA19996@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13903 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755171Ab0KOAcM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 14 Nov 2010 19:32:12 -0500
In-Reply-To: <20101112213601.GA19996@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sat, 2010-11-13 at 05:36 +0800, Matthew Garrett wrote:
> On Fri, Nov 12, 2010 at 04:26:15PM -0500, Alan Stern wrote:
> 
> > Thanks for the information.  Why does the help text for ACPI_VIDEO 
> > mention defining the POST device or setting up a video output if the 
> > driver doesn't do these things?
> 
> The help text is documenting what the spec was intended to allow, rather 
> than what it tends to in the real world...
> 
At least the video driver is trying to do so right now, e.g. create
proc/sysfs I/F for output device switching, although they doesn't work
actually.
And I was preparing a patch to removing this stuff, together with an
update of the ACPI_VIDEO help text.

thanks,
rui


