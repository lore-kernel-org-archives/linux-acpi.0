From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Why ACPI is in the kernel, notes from 2001
Date: Fri, 29 Oct 2004 08:16:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200410290816.06324.oliver@neukum.org>
References: <37F890616C995246BE76B3E6B2DBE05502764E54@orsmsx403.amr.corp.intel.com> <4181C1AA.7050004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263106AbUJ2GRK@vger.kernel.org>
In-Reply-To: <4181C1AA.7050004@pobox.com>
Content-Disposition: inline
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Theodore Ts'o <tytso@mit.edu>, "Brown, Len" <len.brown@intel.com>, "Grover, Andrew" <andrew.grover@intel.com>, "Therien, Guy" <guy.therien@intel.com>, "Yu, Luming" <luming.yu@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Alex Williamson <alex.williamson@hp.com>, linux-kernel <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Am Freitag, 29. Oktober 2004 06:06 schrieb Jeff Garzik:
> None of this implies that the interpreter cannot be in initramfs-like 
> userspace, which neither requires a device driver nor will ever be paged 
> out.

Suspend/resume. User space is halted first.

	Regards
		Oliver
