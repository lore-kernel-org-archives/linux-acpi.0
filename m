From: Luca Capello <luca@pca.it>
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
Date: Mon, 28 Jun 2004 11:18:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <40DFE262.3040107@pca.it>
References: <B44D37711ED29844BEA67908EAF36F032D566A@pdsmsx401.ccr.corp.intel.com> <40DFDB5A.7070301@travellingkiwi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S264900AbUF1JSb@vger.kernel.org>
In-Reply-To: <40DFDB5A.7070301@travellingkiwi.com>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 06/28/04 10:48, Hamie wrote:
> Li, Shaohua wrote:
>> I attached a new patch to handler all level triggered IRQs after resume
>> for 8259 in http://bugme.osdl.org/show_bug.cgi?id=2643. Please try and
>> attach your test result on it.
> Uh.... That might work.... Except that after applying the patch &
> restarting. Then suspend-resume I get another small problem... My
> thinkpad (r50p) uses the power button to wake up from suspend... The
> system wakes, but with this latest patch, acpid then kicks in & says
> 'Ohh! I saw him press the power button' and promptly shuts down...
<cut>
> Sleeps, wakes & a shutdown... Should acpid do that? (i.e. shouldn't it
> eat the power button event that woke it up as a wakeup? Should it even
> get that?) Or is it the previous patch for drivers/acpi/sleep/main.c
> resetting the IRQ9 to edge triggered that's killing me? (I'll try
> removing that now).
this is a known /bug/, I experienced the same on my ancient ASUS M3N. It
has nothing to do with 'acpid'. Please refer to this thread:
	http://marc.theaimsgroup.com/?l=acpi4linux&m=107291320113621&w=2

For the moment, you can use the workaround I proposed here
	http://marc.theaimsgroup.com/?l=acpi4linux&m=107333070225744&w=2

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFA3+JiVAp7Xm10JmkRAoioAJ0Wm/HoUcW0CH2yePQvjB4YGJDs/gCdHd8S
NHmS97q0bfg8JOec6H7fFKs=
=J5E+
-----END PGP SIGNATURE-----
