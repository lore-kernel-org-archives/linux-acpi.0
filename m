From: Darren Hart <dvhart@infradead.org>
Subject: Re: [RFC 1/2] ACPI: activate&export acpi_os_get_physical_address
Date: Sun, 3 May 2015 10:57:04 -0700
Message-ID: <20150503175704.GA16105@fury.dvhart.com>
References: <cover.1429653764.git.kastbernd@gmx.de>
 <20150430181025.GC40200@fury.dvhart.com>
 <4189370.scsJsnLdx0@vostro.rjw.lan>
 <2766179.6BuP3vhKAH@vostro.rjw.lan>
 <20150501045618.GA22054@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150501045618.GA22054@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kast Bernd <kastbernd@gmx.de>, corentin.chary@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 01, 2015 at 05:56:19AM +0100, Matthew Garrett wrote:
> On Fri, May 01, 2015 at 03:45:52AM +0200, Rafael J. Wysocki wrote:
> 
> > And I don't really understand the Matthew's comment regarding limiting
> > operation regions to system memory.  This is about a specific operation
> > region (which BTW only seems to be used as a means to access system memory
> > at the location pointed to by the arg) in that particular method.
> 
> My feeling was that it really ought to have been the ACPI code dealing 
> with this in some way, but having looked at it again I accept that this 
> is really something that's limited by the vendor implementation. 
> virt_to_phys() isn't the worst thing to do here.

Thank you both for the follow-up here.

Kast,

You have some feedback from Corentin and myself on the basic driver, mostly
around cleanups for legibility and future maintainability. You also have
agreement to move forward with virt_to_phys() in the driver due to limitations
imposed by the vendor AML.

Please incorporate these changes in a v2 and resubmit the patch. Please keep all
those who have provided feedback on Cc, and include them in the Cc lines of the
patch itself (below your Signed-off-by).

Thanks,

-- 
Darren Hart
Intel Open Source Technology Center
