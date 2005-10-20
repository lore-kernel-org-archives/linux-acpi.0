From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [ACPI] [PATCH] `unaligned access' in acpi
	get_root_bridge_busnr()
Date: Thu, 20 Oct 2005 08:44:19 -0600
Message-ID: <1129819459.29828.2.camel@lts1.fc.hp.com>
References: <17239.4347.595396.783239@berry.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751498AbVJTOo2@vger.kernel.org>
In-Reply-To: <17239.4347.595396.783239@berry.gelato.unsw.EDU.AU>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-10-20 at 13:37 +1000, Peter Chubb wrote:
> In drivers/acpi/glue.c the address of an integer is cast to the
> address of an unsigned long.  This breaks on systems where a long is
> larger than an int --- for a start the int can be misaligned; for a
> second the assignment through the pointer will overwrite part of the
> next variable.
> 

   FWIW, I posted a nearly identical patch back at the end of September:

http://marc.theaimsgroup.com/?l=acpi4linux&m=112775252600038

No word of it getting anywhere.  Thanks,

	Alex

-- 
