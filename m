From: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>
Subject: Re: [RFC] cpufreq: use new acpi processor perflib in
	speedstep-centrino [Was: Re: [ACPI] _PDC method in DSDT]
Date: Fri, 05 Sep 2003 09:53:32 -0700
Sender: cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <1062780812.23453.40.camel@localhost.localdomain>
References: <20030623133834.GA2330@brodo.de>
	<20030623161136.GG19556@poupinou.org>
	<1056388336.15250.62.camel@ixodes.goop.org>
	<1056398545.10322.111.camel@aldebaran.caltech.edu>
	<20030623213726.GA1317@brodo.de>
	<1056417280.10323.148.camel@aldebaran.caltech.edu>
	<1056418635.5977.20.camel@sherkaner.pao.digeo.com>
	<1056420149.10322.160.camel@aldebaran.caltech.edu>
	<20030624091836.GI19556@poupinou.org>
	<1056491271.3979.15.camel@aldebaran.caltech.edu>
	<20030904231932.GA8518@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
In-Reply-To: <20030904231932.GA8518-JhLEnvuH02M@public.gmane.org>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
Errors-To: cpufreq-bounces-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
To: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, cpufreq list <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>, David Moore <dcm-HInyCGIudOg@public.gmane.org>, "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2003-09-04 at 16:19, Dominik Brodowski wrote:
> This patch modifies the speedstep-centrino driver to use the ACPI 
> processor perflib if no hardcoded value could be found. Centrino-specific
> stuff is taken from a patch to arch/i386/kernel/cpu/cpufreq/acpi.c by 
> David Moore [in this thread].

Sorry, I haven't really been following this thread.  What's the complete
minimal set of other patches I need to make this one work?  Are they
against 2.5.0-test4?

Thanks,
	J
