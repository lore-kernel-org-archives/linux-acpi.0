From: Ducrot Bruno <ducrot@poupinou.org>
Subject: Re: [ACPI] [PATCH] acpi-cpufreq fixups
Date: Fri, 16 Jan 2004 20:32:07 +0100
Sender: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
Message-ID: <20040116193207.GC14031@poupinou.org>
References: <20040115233215.GC5386@dominikbrodowski.de>
	<20040116140144.GW14031@poupinou.org>
	<20040116093404.S76365@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040116093404.S76365@root.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Nate Lawson <nate@root.org>
Cc: acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 16, 2004 at 09:35:11AM -0800, Nate Lawson wrote:
> On Fri, 16 Jan 2004, Ducrot Bruno wrote:
> > > - fix OOPS when PST has core_frequency values of zero
> >
> > FYI: That one have been fixed by Nate Lawson by calling _INI for processors.
> > I don't know if it is in acpi-ca yet.  Of course, it is still safe
> > to check if freq is 0.
> 
> I was told it was in 20031203 but I don't know what Linux kernel version
> has that dist.  I haven't checked to be sure since my FreeBSD cpufreq code
> is in a rough state right now.  :)

Well, my question was for ACPI-CA.  Now, if that is put in Linux, or not,
who cares ;)

BTW, I installed a FreeBSD.  I will be happy to test some FreeBSD cpufreq
code.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
