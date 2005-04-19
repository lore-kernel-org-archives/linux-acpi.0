From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1 - C-state measures
Date: Tue, 19 Apr 2005 23:09:58 +0200
Message-ID: <20050419210958.GE25328@elf.ucw.cz>
References: <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com> <42566C22.4040509@suse.de> <20050408115535.GI4477@atomide.com> <42651C38.6090807@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261663AbVDSVKf@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <42651C38.6090807@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arjan van de Ven <arjan@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>, Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Lee Revell <rlrevell@joe-job.com>, ML ACPI-devel <acpi-devel@lists.sourceforge.net>, Bodo Bauer <bb@suse.de>, Andi Kleen <ak@suse.de>
List-Id: linux-acpi@vger.kernel.org

Hi!

> The machine is a Pentium M 2.00 GHz, supporting C0-C4 processor power states.
> The machine run at 2.00 GHz all the time.
..
> _passing bm_history=0xFFFFFFFF (default) to processor module:_
> 
> Average current the last 470 seconds: *1986mA* (also measured better
> values ~1800, does battery level play a role?!?)

Probably yes. If voltage changes, 2000mA means different ammount of power.


> (cmp. ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/1000_HZ_bm_history_FFFFFFFF)
> 
> 
> _passing bm_history=0xFF to processor module:_
> 
> Average current the last 190 seconds: *1757mA*
> (cmp. ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/1000_HZ_bm_history_FF)
> (Usage count could be bogus, as some invokations could not succeed
> if bm has currently been active).

Ok.

> idle_ms == 100, bm_promote_bs == 30
> Average current the last 80 seconds: *1466mA*
> (cmp.
> ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/tony_dyn_tick_processor_idle_100_bm_30)

Very nice indeed. That seems like ~5W saved, right? That might give
you one more hour of battery life....
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
