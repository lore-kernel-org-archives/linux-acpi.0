From: Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
Subject: Re: gettimeofday() moving backwards
Date: Wed, 18 Dec 2002 23:40:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021218224033.GA1077@brodo.de>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A5BB@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A5BB-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Paul Richards' <p.a.richards-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 18, 2002 at 01:23:57PM -0800, Grover, Andrew wrote:
> > From: Paul Richards [mailto:p.a.richards-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org] 
> > I am using linux kernel v2.4.20 with ACPI patch dated 2002-12-05.
> > 
> > I have noticed that if my processor changes state (800Mhz up 
> > to 1200Mhz say)
> > then gettimeofday() behaves weirdly.  It runs smoothly but 
> > every now and again
> > (on the order of 10 times a second) it makes a correction.  
> > If I have gone from
> > 800Mhz to 1200Mhz then the correction is backwards, otherwise 
> > it makes a forward
> > jump..
> 
> Hmm, can you mention this on the cpufreq mailing list?
> cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org .

In kernel 2.5.5x, gettimeofday() should work fine: ACPI uses the cpufreq
infrastructure, which adds -among other things- a hunk in
arch/i386/timer/tsc.c which updates some values on frequency transitions.
(see http://www.brodo.de/cpufreq/ for details on cpufreq).

As cpufreq isn't included in 2.4. kernels, and likely never will, the 2.4.
gettimeofday() call does cause strange results in 2.4.

	Dominik




-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
