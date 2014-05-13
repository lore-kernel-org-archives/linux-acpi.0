From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Add option to favor 32-bit FADT addresses."
Date: Tue, 13 May 2014 02:09:20 +0200
Message-ID: <2640573.uiu9DRCeSI@vostro.rjw.lan>
References: <38907770.bupFXhytsS@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E880255B3F0@SHSMSX101.ccr.corp.intel.com> <1AE640813FDE7649BE1B193DEA596E880255B72C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53618 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752461AbaELXwf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 May 2014 19:52:35 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880255B72C@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Oswald Buddenhagen <ossi@kde.org>

On Monday, May 12, 2014 08:51:36 AM Zheng, Lv wrote:
> Hi, Rafael
> 
> I checked the bug.
> 
> The dmesg of the kernel without the bisected commit:
> [    0.000000] ACPI BIOS Warning (bug): Incorrect checksum in table [XSDT] - 0xA0, should be 0xC9 (20140214/tbprint-218)
> [    0.000000] ACPI Warning: 32/64 FACS address mismatch in FADT - two FACS tables! (20140214/tbfadt-395)
> [    0.000000] ACPI BIOS Warning (bug): 32/64X FACS address mismatch in FADT - 0xCF661F40/0x00000000CF667E40, using 32 (20140214/tbfadt-522)
> 
> The dmesg of the kernel with the bisected commit:
> [    0.000000] ACPI BIOS Warning (bug): Incorrect checksum in table [XSDT] - 0xA0, should be 0xC9 (20131218/tbprint-214)
> [    0.000000] ACPI BIOS Warning (bug): 32/64X FACS address mismatch in FADT: 0xCF661F40/0x00000000CF667E40, using 64-bit address (20131218/tbfadt-271)
> 
> This is the purpose of the bisected commit.
> According to the link below:
> http://bugs.acpica.org/show_bug.cgi?id=885
> And Windows documentation:
> http://download.microsoft.com/download/5/b/9/5b97017b-e28a-4bae-ba48-174cf47d23cd/CPA002_WH06.ppt
> We believe 64-bit addresses should be used by default so that new features can be enabled according to the public knowledge of Windows Vista+ behavior.
> For old Windows, it's hard for us to guess, we should wait for the reports and add quirks for them.
> 
> Thus this commit is not wrong, it shouldn't be reverted.

It is wrong, because it breaks a system that worked without it.

It's *that* simple.

And either you have a fix for that (which is not a quirk, because there may be
more machines like that), or we have to revert it.

> Though this platform is newer than vista, we still should offer a quirk mechanism
> for it as a quick fix:

We didn't need a quirk for it before, though.

So really, I'm reverting it.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
