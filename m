From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] x86 ACPI: Fix breakage of resume on 64-bit UP systems
	with SMP kernel
Date: Fri, 17 Oct 2008 10:37:00 +0200
Message-ID: <20081017083646.GA25445@elf.ucw.cz>
References: <200810170126.27890.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38234 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbYJQIfb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Oct 2008 04:35:31 -0400
Content-Disposition: inline
In-Reply-To: <200810170126.27890.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Fri 2008-10-17 01:26:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> x86 ACPI: Fix breakage of resume on 64-bit UP systems with SMP kernel
> 
> We are now using per CPU GDT tables in head_64.S and the original
> early_gdt_descr.address is invalidated after boot by 
> setup_per_cpu_areas().  This breaks resume from suspend to RAM on
> x86_64 UP systems using SMP kernels, because this part of head_64.S
> is also executed during the resume and the invalid GDT address
> causes the system to crash.  It doesn't break on 'true' SMP systems,
> because early_gdt_descr.address is modified every time
> native_cpu_up() runs.  However, during resume it should point to the
> GDT of the boot CPU rather than to another CPU's GDT.
> 
> For this reason, during suspend to RAM always make
> early_gdt_descr.address point to the boot CPU's GDT.
> 
> This fixes http://bugzilla.kernel.org/show_bug.cgi?id=11568, which
> is a regression from 2.6.26.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Reported-and-tested-by: Andy Wettstein <ajw1980@gmail.com>

Acked-by: Pavel Machek <pavel@suse.cz>
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
