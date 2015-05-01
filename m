From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC 1/2] ACPI: activate&export acpi_os_get_physical_address
Date: Fri, 1 May 2015 05:56:19 +0100
Message-ID: <20150501045618.GA22054@srcf.ucam.org>
References: <cover.1429653764.git.kastbernd@gmx.de>
 <20150430181025.GC40200@fury.dvhart.com>
 <4189370.scsJsnLdx0@vostro.rjw.lan>
 <2766179.6BuP3vhKAH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50855 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbbEAE42 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 May 2015 00:56:28 -0400
Content-Disposition: inline
In-Reply-To: <2766179.6BuP3vhKAH@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Darren Hart <dvhart@infradead.org>, Kast Bernd <kastbernd@gmx.de>, corentin.chary@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Fri, May 01, 2015 at 03:45:52AM +0200, Rafael J. Wysocki wrote:

> And I don't really understand the Matthew's comment regarding limiting
> operation regions to system memory.  This is about a specific operation
> region (which BTW only seems to be used as a means to access system memory
> at the location pointed to by the arg) in that particular method.

My feeling was that it really ought to have been the ACPI code dealing 
with this in some way, but having looked at it again I accept that this 
is really something that's limited by the vendor implementation. 
virt_to_phys() isn't the worst thing to do here.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
