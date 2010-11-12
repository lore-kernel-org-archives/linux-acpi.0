From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI_VIDEO and BACKLIGHT_CLASS_DEVICE
Date: Fri, 12 Nov 2010 21:36:01 +0000
Message-ID: <20101112213601.GA19996@srcf.ucam.org>
References: <20101112034614.GB7407@srcf.ucam.org> <Pine.LNX.4.44L0.1011121624440.21040-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55482 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267Ab0KLVgI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Nov 2010 16:36:08 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1011121624440.21040-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Nov 12, 2010 at 04:26:15PM -0500, Alan Stern wrote:

> Thanks for the information.  Why does the help text for ACPI_VIDEO 
> mention defining the POST device or setting up a video output if the 
> driver doesn't do these things?

The help text is documenting what the spec was intended to allow, rather 
than what it tends to in the real world...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
