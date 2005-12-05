From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ACPI] [PATCH] i386 No Idle HZ aka dynticks v051205
Date: Mon, 5 Dec 2005 22:16:02 +0100
Message-ID: <20051205211602.GB1728@elf.ucw.cz>
References: <200512051154.45500.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ck-bounces@vds.kolivas.org>
Content-Disposition: inline
In-Reply-To: <200512051154.45500.kernel@kolivas.org>
List-Unsubscribe: <http://bhhdoa.org.au/mailman/listinfo/ck>,
	<mailto:ck-request@vds.kolivas.org?subject=unsubscribe>
List-Archive: <http://bhhdoa.org.au/pipermail/ck>
List-Post: <mailto:ck@vds.kolivas.org>
List-Help: <mailto:ck-request@vds.kolivas.org?subject=help>
List-Subscribe: <http://bhhdoa.org.au/mailman/listinfo/ck>,
	<mailto:ck-request@vds.kolivas.org?subject=subscribe>
Sender: ck-bounces@vds.kolivas.org
Errors-To: ck-bounces@vds.kolivas.org
To: Con Kolivas <kernel@kolivas.org>
Cc: vatsa@in.ibm.com, Tony Lindgren <tony@atomide.com>, Daniel Petrini <d.pensator@gmail.com>, linux list <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, ck list <ck@vds.kolivas.org>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi!

> The main change to this version is the inclusion of Dominik's patches to
> cpufreq ondemand, acpi c-states and bus mastering which should start making
> the potential power saving features of dyntick a reality (thanks!).
> One buildfix for !CONFIG_NO_IDLE_HZ as well.
> 
> If you get strange stalls with this patch then almost certainly it is a
> problem with dynticks and your apic so booting with the "noapic" option
> should fix it.
> 
> Split out patches, timertop and pmstats utilities and latest patch available
> here:
> http://ck.kolivas.org/patches/dyn-ticks/
> 
> FAQ:
> What Hz should I use with dynticks in the config?
> 1000 to realise the benefits of the power saving features and low latency.
> 
> Should I enable timer statistics?
> Only if you're planning on using the timertop utility to help you recognise
> the biggest sources of timers currently in use to help you improve power
> savings.

Strange. It works okay here (thinkpad x32, configured SMP), but
something strange is going on with cursor. I use softcursor (normal
underline but highlight background), and underline no longer blinks
over it.

Try:

    echo -e "\33[10;5000]\33[11;50]\33[?18;0;136c\33[?102m"

on vanilla and no-idle-hz kernels to see what I mean. I'm using
framebuffer console here.
							Pavel
-- 
Thanks, Sharp!
