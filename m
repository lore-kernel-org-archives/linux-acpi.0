From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] clean up some ACPI IRQ conversions
Date: Wed, 10 Mar 2004 09:41:21 -0700
Sender: linux-ia64-owner@vger.kernel.org
Message-ID: <200403100941.21934.bjorn.helgaas@hp.com>
References: <200403091619.04333.bjorn.helgaas@hp.com> <20040309235428.GA25936@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20040309235428.GA25936@wotan.suse.de>
Content-Disposition: inline
Cc: acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org, Andi Kleen <ak@suse.de>, "Nakajima, Jun" <jun.nakajima@intel.com>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 09 March 2004 4:54 pm, Andi Kleen wrote:
> > These changes (all together, not individually) have been built and
> > booted on ia64 and built for i386.
> 
> The x86-64 changes look fine to me. I suppose you will submit them directly?
> Before you do that I would appreciate it if you could at least compile
> check x86-64 and fix any compile errors that may have been introduced.

"make defconfig" compiles and links OK with the x86-64 cross compiler.

I couldn't see a way to turn on CONFIG_PCI_USE_VECTOR.

