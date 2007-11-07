From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v5] ACPI: WMI: Add WMI-ACPI mapper driver
Date: Wed, 7 Nov 2007 04:54:22 +0000
Message-ID: <20071107045421.GA8294@srcf.ucam.org>
References: <200711030217.40814.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:57914 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbXKGEyf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Nov 2007 23:54:35 -0500
Content-Disposition: inline
In-Reply-To: <200711030217.40814.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, "Nashif, Anas" <anas.nashif@intel.com>

On Sat, Nov 03, 2007 at 02:17:39AM +0000, Carlos Corbacho wrote:

> Handle a MOF[1] - the WMI mapper just exports methods, data and events to
> userspace. MOF handling is down to userspace.


How does userspace obtain the MOF from the ACPI tables?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
