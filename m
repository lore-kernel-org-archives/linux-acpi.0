From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: [ACPI] _PDC method in DSDT
Date: Mon, 23 Jun 2003 15:38:34 +0200
Sender: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <20030623133834.GA2330@brodo.de>
References: <F760B14C9561B941B89469F59BA3A84725A303@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A303-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq/>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: David Moore <dcm-HInyCGIudOg@public.gmane.org>, "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 23, 2003 at 02:19:27AM -0700, Grover, Andrew wrote:
> The spec intended FixedFunctionalHW registers to be an "escape hatch".
> FFH means that while ACPI is used for perf state enumeration, the
> transitions will be handled in a CPU-specific driver, not via methods
> described in the ACPI spec. This division (use ACPI for enum, x for
> control) isn't currently supported by cpufreq; ACPI either does both
> enum and control, or neither.

But it could easily be added to the cpufreq drivers. For example, the
speedstep-centrino driver could call a 

int acpi_get_frequency_table(struct cpufreq_frequency_table **freq_table)

which returns an array with the frequency in freq_table[i].frequency, and
some sort of "index" in freq_table[i].index, e.g. what needs to be written
into the IA32_PERF_CTL MSR.


	Dominik
