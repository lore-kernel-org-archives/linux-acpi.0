From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Network failures with ACPI enabled (kernel 2.4, 2.6) PROBLEM FOUND!!!!!!
Date: Sat, 3 Jan 2004 22:06:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040103210622.GA2775@elf.ucw.cz>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8954@hdsmsx402.hd.intel.com> <20031231001716.76cb2e8d.mike@it-loops.com> <20031231004648.531549af.mike@it-loops.com> <1072851661.2363.228.camel@dhcppc4> <20031231172328.5ae00921.mike@it-loops.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031231172328.5ae00921.mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Guntsche <mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > The fact that transmit works and receive fails is a clue.
> > Probably the broadcom uses interrupts for receive, but doesn't
> > use interrupts for transmit.  So if it were not getting interrupts,
> > transmit could still send frames.
> > 
> > So if you enable the parallel port in ECP mode, broadcom works --
> > but if the port is disabled, or enabled but not in ECP mode, it fails?
> 
> Hmm I played around with it some more. If I lower the speed on my
> notebook
> to 10baseT-HD the transfer works at 800KB/s.
> But errors and frames on the device (eth0) are increasing at an alarming
> rate.
> For me it looks like that the problem occurs if the network card gets a
> lot of inbound traffic.

Is not this plain old "ACPI stays to log with interrupts disabled"?
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
