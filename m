From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: [ACPI] _PDC method in DSDT
Date: Mon, 23 Jun 2003 15:42:43 +0200
Sender: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <20030623134243.GB2330@brodo.de>
References: <F760B14C9561B941B89469F59BA3A84725A301@orsmsx401.jf.intel.com> <1056354807.10323.71.camel@aldebaran.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1056354807.10323.71.camel-cfibRQahR+cF6I9xFAAkN5QCsf4PZ8us@public.gmane.org>
Errors-To: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq/>
To: David Moore <dcm-HInyCGIudOg@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 23, 2003 at 12:53:27AM -0700, David Moore wrote:
> My intention was not for processor.c and cpufreq to cooperate, but
> rather for processor.c to be able to control Enhanced Speedstep solely
> with P-states -- no cpufreq necessary.  Cpufreq is certainly useful for
> those systems not running the ACPI driver, but in the long run, ACPI and
> processor.c seem to be the right way to get maximum compatibility with
> many platforms.

Actually, in 2.5. ACPI provides one of several cpufreq drivers. The user can
choose which one best suits his needs [e.g. speedstep-centrino for the
faster wrmsr method instead of the slow io-based ACPI-2.0 module - 
arch/i386/cpu/cpufreq]. Also I doubt that ACPI will allow maximum
compatibility: this new _PCT method again tries to implement things
in a "proprietary", "legacy", "secret" way, supported only by
reverse-engineered or binary-only drivers.

	Dominik
