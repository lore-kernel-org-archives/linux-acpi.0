From: Len Brown <lenb@kernel.org>
Subject: Re: Documentation - How to debug ACPI Problems
Date: Mon, 18 Jun 2007 00:12:05 -0400
Message-ID: <200706180012.05665.lenb@kernel.org>
References: <1181140008.28514.259.camel@queen.suse.de> <9a8748490706060759s5d8c43bdoc34334fcf56ee96@mail.gmail.com> <1181579321.28514.304.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44295 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbXFREMR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Jun 2007 00:12:17 -0400
In-Reply-To: <1181579321.28514.304.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "Brown, Len" <len.brown@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Jesper Juhl <jesper.juhl@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Alexey Starikovskiy <aystarik@gmail.com>


> +2. Overriding DSDT
> +------------------
> +
> +The DSDT (there is a patch also for SSDTs) can be overridden by the user.
> +The tables get copied to RAM when booting and the kernel can override them with
> +alternative tables at early boot time.
> +
> +Historically people used to override their DSDT to workaround BIOS or even
> +kernel bugs. This is a bad idea, the override functionality is for short
> +term workarounds and mainly for debugging! Please always report such bugs to
> +bugzilla.kernel.org or post to linux-acpi@vger.kernel.org if unsure.
> +
> +There are two possibilities to override the DSDT:
> +
> +  - via CONFIG_ACPI_CUSTOM_DSDT (and _FILE) compile option(s)
> +  - via adding a customized DSDT into initramfs
> +
> +The second approach does not need kernel recompilation and some distributions
> +provide the patch, which is not included in mainline, in their kernels.
> +
> +The patch and more information can be found here (many thanks to Markus
> +Gaugusch and Eric Piel):
> +http://gaugusch.at/kernel.shtml
> +

how to override the DSDT by re-compiling the upstream kernel
is already documented here:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.ACPI

It seems inconsistent to refer to the initrd patch from the in-tree Documentation,
since that patch will always be out-of-tree.

I would think that the in-tree Documentation would refer to specifics relating
to the kernel that is actually checked into the tree with the Documentation.
This assumption can probably clear up some of the wording relating to the
debug flags -- we don't have to describe the old ones -- if somebody is
reading this documentation, they already have the new ones:-)

Asside from those specific things that describe the kernel in the tree,
I'm thinking that acpi.sourceforge.net documentation would be a better
place for a general HOWTO on debugging ACPI issues in general.

-Len
