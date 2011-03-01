From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] pnpacpi: Better format error message
Date: Tue, 1 Mar 2011 22:08:13 +0100
Message-ID: <201103012208.14190.trenn@suse.de>
References: <201103011513.40235.trenn@suse.de> <201103011743.33975.trenn@suse.de> <4911F71203A09E4D9981D27F9D830858CA9C0F46@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53774 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055Ab1CAWHo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Mar 2011 17:07:44 -0500
In-Reply-To: <4911F71203A09E4D9981D27F9D830858CA9C0F46@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Bjorn Helgaas <bjorn@helgaas.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday 01 March 2011 18:03:23 Moore, Robert wrote:
> - there seem to be another problem in the acpica resource handling
> depths if _CRS functions do not return anything.
> 
> 
> Strictly speaking it's illegal for _CRS to not return anything.
> Practically, perhaps we should repair this case to a "NULL" resource
> descriptor which perhaps could be defined as a resource descriptor
> with a single End Tag descriptor.
Be aware that this was an early BIOS.
I am fine if there is an error message if this is not allowed.
It's the first time I saw such a message and an empty resource func.


    Thomas
