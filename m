From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH update] ACPI / PM: Allow PCI root bridges to wake
	up the system
Date: Tue, 1 Sep 2009 14:25:47 +0100
Message-ID: <20090901132547.GA13084@srcf.ucam.org>
References: <200908300041.14541.rjw@sisk.pl> <200908312141.00737.rjw@sisk.pl> <200908312324.20850.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200908312324.20850.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Linux PCI <linux-pci@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 31, 2009 at 11:24:20PM +0200, Rafael J. Wysocki wrote:

> Updated patch is appended, but there's a problem with it.  Namely, when the
> root bridge GPE is shared with other devices, those devices are also enabled
> to wake up and they may be kind of "interesting" (on one of my test boxes they
> include the ethernet and audio adapters).  I'm not sure what to do about that.

Perhaps only enable it if a child device is enabled? This is difficult 
with the current code - the refcounted GPE stuff I'm working on ought to 
make it easier.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
