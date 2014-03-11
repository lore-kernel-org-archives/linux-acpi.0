From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] trace, RAS: Add eMCA trace event interface
Date: Tue, 11 Mar 2014 15:27:11 +0100
Message-ID: <20140311142711.GB4773@pd.tnic>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
 <1393924997-8992-3-git-send-email-gong.chen@linux.intel.com>
 <20140307114416.GA5255@pd.tnic>
 <20140310082241.GA873@gchen.bj.intel.com>
 <20140310070435.1981ddd5@samsung.com>
 <20140310103129.GC14808@pd.tnic>
 <20140310084113.7be77602@samsung.com>
 <20140310132948.GF14808@pd.tnic>
 <3908561D78D1C84285E8C5FCA982C28F31DE8ADA@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:47343 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490AbaCKO1O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2014 10:27:14 -0400
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31DE8ADA@ORSMSX106.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>, "Chen, Gong" <gong.chen@linux.intel.com>, "arozansk@redhat.com" <arozansk@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Mar 10, 2014 at 05:37:19PM +0000, Luck, Tony wrote:
> Since we have separate trace points for EDCA and extlog - we can use
> different conventions for "invalid". If you think that changing the
> ABI in EDAC would be a problem - then you can keep running the almost
> infinitesimal chance that you have a real error at 0x00000000000000
> that you treat as unknown address.

I hardly believe changing that would be noticed by anyone.

> Does X86 actually allocate that page for use? - I know on Itanium
> it got thrown out when rounding usable blocks of memory to 16MB
> boundaries for cache coherency reasons.

Yeah, it turns out we reserve at least the first page - 64K by default
though - because BIOS likes to make love to that range. Detailed
explanation from Kconfig text below.

Still, for correctness sake at least, I think we should use a value
which denotes an invalid memory address, i.e. ~0x0, for example, and not
a valid one.

config X86_RESERVE_LOW
	int "Amount of low memory, in kilobytes, to reserve for the BIOS"
	default 64
	range 4 640
	---help---
	  Specify the amount of low memory to reserve for the BIOS.

	  The first page contains BIOS data structures that the kernel
	  must not use, so that page must always be reserved.

	  By default we reserve the first 64K of physical RAM, as a
	  number of BIOSes are known to corrupt that memory range
	  during events such as suspend/resume or monitor cable
	  insertion, so it must not be used by the kernel.

	  You can set this to 4 if you are absolutely sure that you
	  trust the BIOS to get all its memory reservations and usages
	  right.  If you know your BIOS have problems beyond the
	  default 64K area, you can set this to 640 to avoid using the
	  entire low memory range.

	  If you have doubts about the BIOS (e.g. suspend/resume does
	  not work or there's kernel crashes after certain hardware
	  hotplug events) then you might want to enable
	  X86_CHECK_BIOS_CORRUPTION=y to allow the kernel to check
	  typical corruption patterns.

	  Leave this to the default value of 64 if you are unsure.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
