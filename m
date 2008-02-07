From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend to ram problem
Date: Thu, 7 Feb 2008 10:20:35 +0100
Message-ID: <20080207092035.GB1816@elf.ucw.cz>
References: <47A5C399.7010405@free.fr> <47A6B758.7070405@free.fr> <47A8EB02.90502@free.fr> <200802060020.12289.rjw@sisk.pl> <47AA3763.7000106@free.fr> <20080206224328.GB1630@elf.ucw.cz> <47AA4000.6010701@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38379 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756564AbYBGPTS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 10:19:18 -0500
Content-Disposition: inline
In-Reply-To: <47AA4000.6010701@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>

Hi!

>>>>> If I remove stack access (remove clearing flag stuff, not call to video 
>>>>> stuff) the resume works.
>>>> Hm, can you place a "pushl %eax; popl %eax;" in place of the removed code and
>>>> see if that breaks?
>>> Yes that also break.
>>
>> Hmm, and what kind of machine is that?
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 6
> model name      : AMD Athlon(tm) XP 1800+
> stepping        : 2
> cpu MHz         : 1533.490
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow ts
> bogomips        : 3070.84
> clflush size    : 32

So I assume it is some kind of desktop?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
