From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/5] ACPI: Allow handlers to be installed at the same
	time as methods
Date: Wed, 6 Oct 2010 17:18:54 +0100
Message-ID: <20101006161854.GA30584@srcf.ucam.org>
References: <1286216549-5438-1-git-send-email-mjg@redhat.com> <1286216549-5438-2-git-send-email-mjg@redhat.com> <201010060118.50875.rjw@sisk.pl> <4911F71203A09E4D9981D27F9D830858B4893B89@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4911F71203A09E4D9981D27F9D830858B4893B89@orsmsx503.amr.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 06, 2010 at 09:14:07AM -0700, Moore, Robert wrote:

> Although there exists a single Windows document mentions this behavior as a windows "feature", I'm not 100% convinced that this is actually true. AFAIK, we've never seen a machine that depends on an "implicit notify" on a device when a wake GPE happens.

Such behaviour would be irrelevant for system sleep/wake - the only 
requirement is in runtime power management.

> It appears to me that the biggest issue right now is the fact that a Notify() must be performed on a Device object, and the problem is how to associate the GPE with the device object.

The other important aspect of this is that a single GPE may correspond 
to multiple devices. The methods will generally cope with this by either 
sending multiple notifies, executing some SMM code to identify the 
relevant device or reading PCI configuration registers to identify the 
source of the wakeup. We need to handle that case as well.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
