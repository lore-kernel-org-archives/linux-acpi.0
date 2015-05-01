From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 1/2] ACPI: activate&export acpi_os_get_physical_address
Date: Fri, 01 May 2015 03:45:52 +0200
Message-ID: <2766179.6BuP3vhKAH@vostro.rjw.lan>
References: <cover.1429653764.git.kastbernd@gmx.de> <20150430181025.GC40200@fury.dvhart.com> <4189370.scsJsnLdx0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54820 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753179AbbEABU6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2015 21:20:58 -0400
In-Reply-To: <4189370.scsJsnLdx0@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kast Bernd <kastbernd@gmx.de>, corentin.chary@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Friday, May 01, 2015 03:32:29 AM Rafael J. Wysocki wrote:
> On Thursday, April 30, 2015 11:10:25 AM Darren Hart wrote:
> > On Wed, Apr 22, 2015 at 04:12:24PM +0200, Kast Bernd wrote:
> > > acpi_os_get_physical_address will be needed by an acpi driver (asus-wmi.c).
> > > Additionally it could  be used by dell-laptop.c instead of directly calling virt_to_phys.
> > > 
> > > acpi_os_get_physical_address gets exported and ACPI_FUTURE_USAGE is removed
> > > 
> > 
> > Hrm, well... this doesn't get rid of virt_to_phys, it just wraps it really. I'm
> > not sure that makes this any more acceptable than the original from Felipe - but
> > that's not my call.
> 
> Use virt_to_phys() if you need to.
> 
> This one is in case ACPICA needs to get the virtual-to-physical mapping (hence
> ACPI_FUTURE_USAGE).

More to the point, the reason why virt_to_phys() needs to be used in patch [2/2]
seems to be a nasty hack in the ASUS AML that pretty much expects us to provide
the physical address as an argument.

And I don't really understand the Matthew's comment regarding limiting
operation regions to system memory.  This is about a specific operation
region (which BTW only seems to be used as a means to access system memory
at the location pointed to by the arg) in that particular method.

Matthew?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
