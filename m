From: Len Brown <lenb@kernel.org>
Subject: Re: MAcBook Pro DMI info
Date: Tue, 5 Feb 2008 13:22:31 -0500
Message-ID: <200802051322.31624.lenb@kernel.org>
References: <20080131081821.89030@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48642 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759419AbYBESWx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Feb 2008 13:22:53 -0500
In-Reply-To: <20080131081821.89030@gmx.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: der flooh <derflooh@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Thursday 31 January 2008 03:18, der flooh wrote:
> Jan 31 08:40:41 elm ACPI: DMI System Vendor: Apple Inc.

Thanks for the dmidecode.
Looks like we should just match on the string "Apple",
since they seem to have cut over from "Apple Computer, Inc."
to "Apple Inc."

btw. if you can send me the output from acpidump, I'd
like to look it over, since I've not see the MacBookPro3,1
version yet.

thanks,
-Len

> Jan 31 08:40:41 elm ACPI: DMI Product Name: MacBookPro3,1
> Jan 31 08:40:41 elm ACPI: DMI Product Version: 1.0
> Jan 31 08:40:41 elm ACPI: DMI Board Name: Mac-F4238BC8
> Jan 31 08:40:41 elm ACPI: DMI BIOS Vendor: Apple Inc.
> Jan 31 08:40:41 elm ACPI: DMI BIOS Date: 09/26/07
> 
