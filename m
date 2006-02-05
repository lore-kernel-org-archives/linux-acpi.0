From: Arthur Huillet <arthur.huillet@agoctrl.org>
Subject: Re: Question about AthlonXP on nforce 2 : C2-C3 states
Date: Sun, 5 Feb 2006 16:55:49 +0100
Message-ID: <20060205165549.0bffebc8.arthur.huillet@agoctrl.org>
References: <20060205152120.1688bd7b.arthur.huillet@agoctrl.org>
	<20060205143742.GA20815@tangens.sinus.cz>
	<20060205160750.4a1c1b3e.arthur.huillet@agoctrl.org>
	<20060205154245.GA31112@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from [84.4.96.230] ([84.4.96.230]:21709 "EHLO Chani.agoctrl.org")
	by vger.kernel.org with ESMTP id S1751782AbWBEPzs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2006 10:55:48 -0500
In-Reply-To: <20060205154245.GA31112@tangens.sinus.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>
Cc: linux-acpi@vger.kernel.org


> On Athlon boards, I'm successfully using athcool
> ( http://members.jcom.home.ne.jp/jacobi/linux/files/athcool-0.3.11.tar.gz ),
> it substantially decreases CPU temperature even with C1 due to enabling
> "HALT Command detection" bit on the NB. 

Yes, I've already done that and it does work very well. 

> HOWEVER, as many ACPI people already said several times, IT MAY BE RISKY AND
> you CAN severely DAMAGE YOUR DATA when experimenting with this.

I guess so, otherwise the BIOS wouldn't probably be blocking those features. 
Thanks for the help, I won't test C2-C3 because the temperature results in C1 are already
excellent.

Now to take a look at cpufreq-nforce2 and have fun with it :) 
Have a nice day.
-- 
Greetings, 
A.H.
