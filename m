From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 1/2] ACPI: activate&export acpi_os_get_physical_address
Date: Fri, 01 May 2015 03:32:29 +0200
Message-ID: <4189370.scsJsnLdx0@vostro.rjw.lan>
References: <cover.1429653764.git.kastbernd@gmx.de> <f14ffb9df15cdf617bb4ccae575a9787866675c8.1429653764.git.kastbernd@gmx.de> <20150430181025.GC40200@fury.dvhart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20150430181025.GC40200@fury.dvhart.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Kast Bernd <kastbernd@gmx.de>, corentin.chary@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, April 30, 2015 11:10:25 AM Darren Hart wrote:
> On Wed, Apr 22, 2015 at 04:12:24PM +0200, Kast Bernd wrote:
> > acpi_os_get_physical_address will be needed by an acpi driver (asus-wmi.c).
> > Additionally it could  be used by dell-laptop.c instead of directly calling virt_to_phys.
> > 
> > acpi_os_get_physical_address gets exported and ACPI_FUTURE_USAGE is removed
> > 
> 
> Hrm, well... this doesn't get rid of virt_to_phys, it just wraps it really. I'm
> not sure that makes this any more acceptable than the original from Felipe - but
> that's not my call.

Use virt_to_phys() if you need to.

This one is in case ACPICA needs to get the virtual-to-physical mapping (hence
ACPI_FUTURE_USAGE).

Rafael
