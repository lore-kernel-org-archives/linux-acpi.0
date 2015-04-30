From: Darren Hart <dvhart@infradead.org>
Subject: Re: [RFC 1/2] ACPI: activate&export acpi_os_get_physical_address
Date: Thu, 30 Apr 2015 11:10:25 -0700
Message-ID: <20150430181025.GC40200@fury.dvhart.com>
References: <cover.1429653764.git.kastbernd@gmx.de>
 <f14ffb9df15cdf617bb4ccae575a9787866675c8.1429653764.git.kastbernd@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f14ffb9df15cdf617bb4ccae575a9787866675c8.1429653764.git.kastbernd@gmx.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Kast Bernd <kastbernd@gmx.de>
Cc: corentin.chary@gmail.com, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 22, 2015 at 04:12:24PM +0200, Kast Bernd wrote:
> acpi_os_get_physical_address will be needed by an acpi driver (asus-wmi.c).
> Additionally it could  be used by dell-laptop.c instead of directly calling virt_to_phys.
> 
> acpi_os_get_physical_address gets exported and ACPI_FUTURE_USAGE is removed
> 

Hrm, well... this doesn't get rid of virt_to_phys, it just wraps it really. I'm
not sure that makes this any more acceptable than the original from Felipe - but
that's not my call.

Rafael?
Len?

-- 
Darren Hart
Intel Open Source Technology Center
