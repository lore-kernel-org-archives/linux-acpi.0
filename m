From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] toshiba-acpi: Add support for hotkey notifications
Date: Mon, 13 Apr 2009 15:50:15 +0100
Message-ID: <20090413145015.GA10976@srcf.ucam.org>
References: <20090331214501.GC29489@srcf.ucam.org> <200904112150.38010.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44213 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbZDMOuW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2009 10:50:22 -0400
Content-Disposition: inline
In-Reply-To: <200904112150.38010.elendil@planet.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-acpi@vger.kernel.org, dsilvers@simtec.co.uk, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org, lenb@intel.com

On Sat, Apr 11, 2009 at 09:50:35PM +0200, Frans Pop wrote:
> Matthew Garrett wrote:
> > Calling the ENAB method on Toshiba laptops results in notifications
> > being sent when laptop hotkeys are pressed. This patch simply calls that
> > method and sets up an input device if it's successful.
> 
> Hi Matthew,
> 
> On my Satellite A40-241 the patch works fine for the Fn keys, but it does 
> not work for the multimedia keys next to the power button. No event is 
> generated (I tested this by directly reading the /dev/input/eventX file).
> 
> Any chance those could be made to work too?

Can you send me the acpidump?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
