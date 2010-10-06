From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/5] ACPI: Allow handlers to be installed at the same
	time as methods
Date: Wed, 6 Oct 2010 20:32:28 +0100
Message-ID: <20101006193228.GA3030@srcf.ucam.org>
References: <1286216549-5438-1-git-send-email-mjg@redhat.com> <4911F71203A09E4D9981D27F9D830858B4893B89@orsmsx503.amr.corp.intel.com> <20101006161854.GA30584@srcf.ucam.org> <201010062130.27564.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201010062130.27564.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 06, 2010 at 09:30:27PM +0200, Rafael J. Wysocki wrote:

> So, as I said, we can modify acpi_gpe_can_wake() to pass a device object to
> ACPICA.  Then, the device object will be added to the list of devices to Notify()
> if the GPE is signaled.  Plain and simple.

Yeah, that does seem to be the simplest solution.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
