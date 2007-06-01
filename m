From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH]: ACPI: preserve the ebx value in acpi_copy_wakeup_routine
Date: Fri, 1 Jun 2007 12:17:07 +0200
Message-ID: <20070601101707.GC31453@elf.ucw.cz>
References: <1180692553.7707.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35864 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757912AbXFAKRH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Jun 2007 06:17:07 -0400
Content-Disposition: inline
In-Reply-To: <1180692553.7707.76.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, kevin.tian@intel.com

Hi!

> From: Tian Kevin <kevin.tian@intel.com>
> 
> Register %ebx serves as the "global offset table base register"
> for position-independent code. For absolute code, %ebx serves
> as a local register and has no specified role in the function
> calling sequence. In either case, a function must preserve the
> register value for the caller.
> 
> acpi_copy_wakeup_routine overrides %ebx without saving it,
> this may corrupt the called data.
> 
> Kevin found that most time the value of Sx is saved in %esi,
> however sometimes compiler also uses %ebx. When this happens,
> suspends fails since sleep value in ebx is changed by
> acpi_copy_wakeup_routine.
> 
> The same funtion in X86_64 doesn't have this problem.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Looks okay to me. That routine also corrupts ecx and edx, hopefully
that's okay?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
