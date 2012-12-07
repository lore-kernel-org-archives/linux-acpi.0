From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI: add Haswell LPSS devices to
 acpi_platform_device_ids list
Date: Fri, 7 Dec 2012 13:14:15 +0200
Message-ID: <20121207111415.GH23611@intel.com>
References: <1354874882-1162-1-git-send-email-mika.westerberg@linux.intel.com>
 <20121207110126.53cd97e7@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121207110126.53cd97e7@pyramind.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 07, 2012 at 11:01:26AM +0000, Alan Cox wrote:
> On Fri,  7 Dec 2012 12:08:02 +0200
> Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
> > All devices behind Haswell LPSS (Low Power Subsystem) should be represented
> > as platform devices 
> 
> What about the bus heirarchy ? What about making sure they appear in the
> PCI resource heirarchy so we don't mash them up if we reassign or
> allocate other resources on the bus ?

I'm not sure if I understand what you mean here.

We put them in hierarchy if the parent ACPI node has also a physical device
bound to it (like PCIe root port).
