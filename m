From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add intel drm blacklist to intel_opregion_present
	detect
Date: Mon, 12 Jul 2010 03:27:09 +0100
Message-ID: <20100712022709.GA2695@srcf.ucam.org>
References: <4C3B06C9020000230001CC2C@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36615 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203Ab0GLC1Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Jul 2010 22:27:16 -0400
Content-Disposition: inline
In-Reply-To: <4C3B06C9020000230001CC2C@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: linux-acpi@vger.kernel.org, Dennis.Jansen@web.de

On Sun, Jul 11, 2010 at 08:12:57PM -0600, Joey Lee wrote:

> He tested the drm blacklist patch can works fine on his computer, it's
> also works on VESA mode because the acpi _BCM, _BQC direct change
> brightness by opregion.
> 
> What can we do for this situtation? I mean if the BIOS have opregion
> implementation but there have no opensource drm driver or native video
> driver support opregion on Linux?

The cleanest way would be to implement a stub backlight control driver 
for the chip - there should be enough information in the source of the 
poulsbo drm to do that. The main problem with the blacklist approach is 
that there's no guarantee that all poulsbo systems will have a working 
acpi method, and I /think/ there's a couple more PCI IDs that ought to 
be covered in any case. On the other hand doing it properly does involve 
writing rather a lot more code, and the fact that Intel have shown 
absolutely no interest in making their hardware work means that the 
quick hack might be the most reasonable thing to do.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
