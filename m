From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Subject: Re: Linux 2.6.7 - ACPI still broken
Date: Wed, 16 Jun 2004 21:15:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <40D11AC9.3060009@backtobasicsmgmt.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> <1087407777.2959.12.camel@forum-beta.geizhals.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S266363AbUFQEOz@vger.kernel.org>
In-Reply-To: <1087407777.2959.12.camel@forum-beta.geizhals.at>
To: ACPI Developers <acpi-devel@lists.sourceforge.net>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Thomas Zehetbauer wrote:

> As posted on 2004-06-07 ACPI support seems to be broken for Intel
> D865PERL board since at least 2.6.7-rc2.
> 
> When booting with the standard flags (nmi_watchdog=1 root=/dev/md0
> video=matroxfb:vesa:0x1bb) the kernel locks up with different error
> messages immediately after "ACPI: Subsystem revision 20040326". Adding
> "acpi=off" to the command line makes everything work again.

I have the same problem, using a D865GBF, which is nearly the same 
board. BIOS is the most current version; booting with acpi=off allows 
the boot to proceed and function normally. I've tried rebuilding without 
"kernel IRQ balancing" and "register parameters" (which were my two most 
recent config changes), but no improvement.
