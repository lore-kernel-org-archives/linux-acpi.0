From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v5] ACPI: WMI: Add WMI-ACPI mapper driver
Date: Wed, 7 Nov 2007 17:55:08 +0000
Message-ID: <20071107175507.GA18433@srcf.ucam.org>
References: <200711030217.40814.carlos@strangeworlds.co.uk> <20071107045421.GA8294@srcf.ucam.org> <200711071151.00852.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:42827 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757491AbXKGRzV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Nov 2007 12:55:21 -0500
Content-Disposition: inline
In-Reply-To: <200711071151.00852.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Nashif, Anas" <anas.nashif@intel.com>

On Wed, Nov 07, 2007 at 11:51:00AM +0000, Carlos Corbacho wrote:
> On Wednesday 07 November 2007 04:54:22 Matthew Garrett wrote:

> 1) A method in the WMI-ACPI implementation - _some_ (very few) implementations 
> have a method in WMI-ACPI that will return a binary MOF (since the MS spec 
> suggests this is just one _possible_ way to provide the MOF, but that it is 
> not required).

Ah, sorry, I'd misread the spec - I thought the MOF was at a defined 
name rather than just being returned via a normal WMI method. The 
functionality in this version looks fine, so I'll try to find time to 
test it this week.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
