From: Roman Zippel <zippel@linux-m68k.org>
Subject: RE: [patch 5/9] ACPI should depend on, not select PCI
Date: Thu, 1 Dec 2005 11:00:41 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0512011058220.1610@scrub.home>
References: <F7DC2337C7631D4386A2DF6E8FB22B300549CF57@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751675AbVLAKEV@vger.kernel.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300549CF57@hdsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: akpm@osdl.org, bunk@stusta.de, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi

On Wed, 30 Nov 2005, Brown, Len wrote:

> No, I can't apply this -- it allows
> Kconfig to create IA64 configs without PCI,
> which do not build.

Why? Simply enable the PCI in IA64 like everyone else, what's the problem?

> > config ACPI
> > 	bool "ACPI Support"
> > 	depends on IA64 || X86
> >+	depends on PCI
> > 	select PM
> >-	select PCI
> > 
> > 	default y

This default should also go.

bye, Roman
