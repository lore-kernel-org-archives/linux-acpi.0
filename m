From: Nate Lawson <nate@root.org>
Subject: Re: [ACPI] [PATCH] acpi-cpufreq fixups
Date: Fri, 16 Jan 2004 09:35:11 -0800 (PST)
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040116093404.S76365@root.org>
References: <20040115233215.GC5386@dominikbrodowski.de>
	<20040116140144.GW14031@poupinou.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-bounces@www.linux.org.uk>
In-Reply-To: <20040116140144.GW14031@poupinou.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces@www.linux.org.uk
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

On Fri, 16 Jan 2004, Ducrot Bruno wrote:
> > - fix OOPS when PST has core_frequency values of zero
>
> FYI: That one have been fixed by Nate Lawson by calling _INI for processors.
> I don't know if it is in acpi-ca yet.  Of course, it is still safe
> to check if freq is 0.

I was told it was in 20031203 but I don't know what Linux kernel version
has that dist.  I haven't checked to be sure since my FreeBSD cpufreq code
is in a rough state right now.  :)

-Nate
