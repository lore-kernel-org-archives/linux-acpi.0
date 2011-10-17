From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] x86/PCI: fix boot-time memory leak
Date: Mon, 17 Oct 2011 12:46:52 -0700
Message-ID: <20111017194652.GA22656@kroah.com>
References: <20111017194037.7778.11572.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111017194037.7778.11572.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Simon Kirby <sim@hostway.ca>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 17, 2011 at 01:40:37PM -0600, Bjorn Helgaas wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> If we're not using _CRS, the host bridge's bus name and resource structures
> were allocated but never freed.  This patch fixes that.
> 
> Reported-by: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
> Reported-by: Simon Kirby <sim@hostway.ca>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Is this something for the 3.0-stable tree as well?

greg k-h
