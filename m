From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [ACPI] Re: [2.5.50, ACPI] link error
Date: 11 Dec 2002 16:00:14 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1039622414.17702.29.camel@irongate.swansea.linux.org.uk>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A581@orsmsx119.jf.intel.com>
	<1039481341.12046.21.camel@irongate.swansea.linux.org.uk>
	<20021210204031.GF20049@atrey.karlin.mff.cuni.cz>
	<23440000.1039553448@localhost.localdomain>
	<20021211101438.GC29390@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20021211101438.GC29390-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Andrew McGregor <andrew-Rd3uoDiDeHXJKwlM9GxbOw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2002-12-11 at 10:14, Ducrot Bruno wrote:
> No.  You are wrong.  I need to suspend allmost all the drivers, and the
> video chipset is not an execption (or go to a console before suspending,
> in fact).
> You still need to bug NVIDIA in order to have proper pm support
> in their driver.

To an extent. However you can also switch back to text mode on suspend
to disk, then resume back into text mode and effectively switch back
into X11
