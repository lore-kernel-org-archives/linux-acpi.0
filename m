From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [ACPI] _PDC method in DSDT
Date: Thu, 26 Jun 2003 13:13:38 +0200
Sender: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
Message-ID: <20030626111338.GS19556@poupinou.org>
References: <20030623161136.GG19556@poupinou.org> <1056388336.15250.62.camel@ixodes.goop.org> <1056398545.10322.111.camel@aldebaran.caltech.edu> <20030623213726.GA1317@brodo.de> <1056417280.10323.148.camel@aldebaran.caltech.edu> <1056418635.5977.20.camel@sherkaner.pao.digeo.com> <1056420149.10322.160.camel@aldebaran.caltech.edu> <20030624091836.GI19556@poupinou.org> <1056491271.3979.15.camel@aldebaran.caltech.edu> <20030626104041.GR19556@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030626104041.GR19556-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: cpufreq-admin-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm38Ik5SeuEX72+df2TVCvIA@public.gmane.org>
List-Post: <mailto:cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Help: <mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMm4xOcYYyLxz0@public.gmane.org>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request-1walMZg8u8rXmaaqVzeoHW9u/PF5AtMmEuNEP1Y2mCuZIoH1IeqzKA@public.gmane.org>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq/>
To: David Moore <dcm-HInyCGIudOg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, cpufreq list <cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> > Dword 0 should be 0x1
> > Dword 1 should be 0x1
> > Dword 2 should be 0x1
> > 
> > The 0x1 in Dword 2 indicates that the driver supports Enhanced
> > Speedstep.  In my DSDT, Dwords 0 and 1 are ignored anyway, but the
> > values above should be correct.
> 
> Sound like ok, but not for Dword 0.  Will look more at it then.

Ok.  Actually Dword 0 seems to be 0x0001.  Sorry.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
