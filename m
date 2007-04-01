From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.21-rc5: Thinkpad X60 gets critical thermal shutdowns
Date: Sun, 1 Apr 2007 15:53:18 +0100
Message-ID: <20070401145317.GA17776@srcf.ucam.org>
References: <460E0158.7090705@goop.org> <8f8ff01d0703310033y74421cfcl747ece1be003471@mail.gmail.com> <460F511E.2090102@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:57213 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933089AbXDAOxd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Apr 2007 10:53:33 -0400
Content-Disposition: inline
In-Reply-To: <460F511E.2090102@goop.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Sat, Mar 31, 2007 at 11:28:46PM -0700, Jeremy Fitzhardinge wrote:

> That seems to have helped.  If I watch
> /proc/acpi/thermal_zone/THM?/temperature, it seems stable even under
> load.   I didn't try watching the thermal_zones when these options were
> enabled, but I presume the temperature was not controlled for it to hit
> 128 degC.
> 
> What's going on here?  Does reading an i2c sensor from the kernel
> prevent something else from doing it?

The i2c drivers access the same hardware as the ACPI methods, and 
there's no locking.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
