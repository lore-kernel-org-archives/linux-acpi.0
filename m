From: Ducrot Bruno <ducrot@poupinou.org>
Subject: Re: [ACPI] [PATCH] acpi-cpufreq fixups
Date: Fri, 16 Jan 2004 15:01:44 +0100
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <20040116140144.GW14031@poupinou.org>
References: <20040115233215.GC5386@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces@www.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20040115233215.GC5386@dominikbrodowski.de>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces@www.linux.org.uk
To: len.brown@intel.com, acpi-devel@lists.sourceforge.net, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

> - fix OOPS when PST has core_frequency values of zero

FYI: That one have been fixed by Nate Lawson by calling _INI for processors.
I don't know if it is in acpi-ca yet.  Of course, it is still safe
to check if freq is 0.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
