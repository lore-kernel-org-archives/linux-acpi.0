From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [ACPI] _PDC method in DSDT
Date: Thu, 26 Jun 2003 12:40:41 +0200
Sender: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <20030626104041.GR19556@poupinou.org>
References: <20030623133834.GA2330@brodo.de> <20030623161136.GG19556@poupinou.org> <1056388336.15250.62.camel@ixodes.goop.org> <1056398545.10322.111.camel@aldebaran.caltech.edu> <20030623213726.GA1317@brodo.de> <1056417280.10323.148.camel@aldebaran.caltech.edu> <1056418635.5977.20.camel@sherkaner.pao.digeo.com> <1056420149.10322.160.camel@aldebaran.caltech.edu> <20030624091836.GI19556@poupinou.org> <1056491271.3979.15.camel@aldebaran.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1056491271.3979.15.camel-cfibRQahR+cF6I9xFAAkN5QCsf4PZ8us@public.gmane.org>
Errors-To: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq/>
To: David Moore <dcm-HInyCGIudOg@public.gmane.org>
Cc: Jeremy Fitzhardinge <jeremy-TSDbQ3PG+2Y@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Adachi, Kenichi" <adachi-fvZ7ij+YLgEZc9YY0SgeQc8NsWr+9BEh@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq list <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jun 24, 2003 at 02:47:52PM -0700, David Moore wrote:
> On Tue, 2003-06-24 at 02:18, Ducrot Bruno wrote:
> > Then only concern I may have for is still the _PDC method.  It is currently
> > only documented in a MS document.  It is defined as an optional method
> > used by the OS in order to be somehow compatible with older releases
> > of Windows.  But it has the folowing:
> > 
> > Arguments:
> > Arg0 (buffer):
> > DWORD 0:         Revision Id
> > DWORD 1:    Number of capabilities DWORDs in buffer
> > DWORD 2-n:   Capabilities DWORDs, where each bit
> > 	defines capabilities and features supported by the OSPM for
> > 	processor power management.
> > 	The definitions and meaning of each capabilities bit is vendor
> > 	specific, and shared with OSPM by the vendor.
> > 
> > Result Code:
> > None
> > 
> > Then give us now the correct values to be passed for Pentium-M found
> > in Centrino platform, and I will be glad to do the break of cpufreq/acpi.c
> > for you.
> > 
> 
> Dword 0 should be 0x1
> Dword 1 should be 0x1
> Dword 2 should be 0x1
> 
> The 0x1 in Dword 2 indicates that the driver supports Enhanced
> Speedstep.  In my DSDT, Dwords 0 and 1 are ignored anyway, but the
> values above should be correct.

Sound like ok, but not for Dword 0.  Will look more at it then.

> 
> Feel free to do the split into two files if you think that's the way to
> go.  I'm going to submit my patch to the cpufreq list anyway under a
> separate email, just so it exists for the record.  You might change your
> mind after seeing it.  I also have a patch that fixes a few bugs in the
> current cpufreq/acpi.c.

Yes, I saw some of those bugs too.  Will look at it a little bit more.

Note that I am not really against at, but I prefer to see at first all
implications of supporting this method.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
