From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] ACPI/Processor: C1/C3 states promotion and demotion
Date: Wed, 11 Feb 2004 13:22:18 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040211122218.GM13262@poupinou.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB6A1@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB6A1-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 11, 2004 at 07:37:16PM +0800, Yu, Luming wrote:
> 
> > On Wed, Feb 11, 2004 at 10:19:22AM +0800, Yu, Luming wrote:
> > > > > Some processors seems to support only C1 and C3 states, for 
> > > > instance... mine ;-)
> > > > > (Pentium III Coppermine). The problem is that, in this 
> > > > case, no promotion or
> > > > > demotion are linking those two states, therefore the 
> > > > preocessor never goes to C3!
> > > > > 
> > > > 
> > > > There is no intel-like processors for which there is C3, but 
> > > > no C2.  So
> > > > you have actually to fake a C2 (which should be at a latency 
> > > > of 30 IIRC).
> > > > 
> > > 
> > > I'm not sure a faking C2 can work as expected, because
> > > C2 power state is an optional ACPI clock state that needs 
> > > chipset hardware support. (ACPI spec 2.0b  8.1.3)
> > > 
> > 
> > We are talking about a PIII Coppermine that need to be put in sleep
> > mode (C2) before deep sleep (C3).
> 
> According to ACPI spec, entering  C2 needs chipset hardware support.
> So it is possible that only C1 and C3 get supported, despite CPU 
> can support C1 , C2, and C3. 
> 

I am not aware of southbridge that are buggy in order to enter a PIII
coppermine in the sleep state whereas it can can put it in deep sleep
state.  Hmm, well, appart perhaps earlyer version of the ich2m ?
I don't remember.  Will check.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
