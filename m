From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Linux/ACPI 2.4 release status and cpufreq
Date: Mon, 15 Dec 2003 19:08:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031215180824.GB14031@poupinou.org>
References: <1071209752.2542.688.camel@dhcppc4> <1071248784.1756.7.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1071248784.1756.7.camel-4/PLUo9XfK/yXfm4dIG/yWZHpeb/A1Y/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: =?iso-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 12, 2003 at 05:06:24PM +0000, Sérgio Monteiro Basto wrote:
> Hi Len
> 
> 
> On Fri, 2003-12-12 at 06:15, Len Brown wrote:
> > Folks,
> > 2.4.23 shipped -- and I'd like to thank all of you for helping build the
> > best stable ACPI kernel yet!
> 
> yes in my laptop it is very stable too. thanks
> 
> 
> > Yes, this is a good time to remind me about, or update and re-send
> > patches that we were not able to handle in time for 2.4.23.
> > 
> 
> have you any plan? to integrated cpufreq that cames in 2.22-ac4 kernels.
> or does anybody have any implantation of cpufreq for kernel 2.4.23? 
> 

I don't think it's up to acpi folks to integrate cpufreq.  The 2 works
are definitely different due to the fact that cpufreq claims at
first to be architecture independant (you have to consider arm, sparc,
ppc...).

Of course, an ACPI based cpufreq driver for 2.4 will be fine, and perhaps
an acpi governor based both on input from thermal stuff, load of the system
may be good, who knows.

Note that acpi use cpufreq api in 2.[56].

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
