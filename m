From: Ka-shu Wong <kswong-LJ1TwQYPT6cQrrorzV6ljw@public.gmane.org>
Subject: Re: Re: [Swsusp-devel] ACPI A/C adaptor status not updated upon resume
Date: Sat, 19 Jul 2003 09:38:47 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030718233847.GA18001@donkey.nsw.optushome.com.au>
References: <F760B14C9561B941B89469F59BA3A847E9704C@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E9704C-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>, EricAltendorf-gZ4DH+Stb0k@public.gmane.org, swsusp-devel <swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Has there been any progress on this issue?

I'm running kernel 2.4.21 with acpi-20030619 and swsusp-1.0.2 on my
toshiba portege 2000, and I'm getting the same problem.

Disassembling the _PSR method gives:

000031bd:     Method _PSR (\_SB_.ADP1._PSR)
000031c3:       ArgCount 0; NotSerialized
000031c4:       Return
000031c5:         \_SB_.MEM_.ACST (000002da)

It seems that it is storing its state somewhere and changing it based
on events.  Software suspend is probably saving this state and restoring
it upon resume.

There are two possible solutions that I can see:  Either make software
suspend not restore the ACPI state, or reset the ACPI subsystem somehow
after restore.

Are either of these solutions possible?

- KS

PS I'm not on the ACPI list so please CC.


On Thu, Jul 17, 2003 at 01:49:51PM -0700, Grover, Andrew wrote:
> Well we actually are calling the _PSR control method to implement the
> "state" proc entry. Of course, that's just calling a control method so
> who knows what the control method does -- I'd have to see what _PSR
> looks like...can you get your dsdt from /proc/acpi/dsdt, disassemble
> with iasl -d and post what _PSR is?
> 
> Thanks -- Regards -- Andy
> 
> > -----Original Message-----
> > From: Nigel Cunningham [mailto:ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org] 
> > Sent: Thursday, July 17, 2003 1:20 PM
> > To: EricAltendorf-gZ4DH+Stb0k@public.gmane.org
> > Cc: swsusp-devel; ACPI List
> > Subject: [ACPI] Re: [Swsusp-devel] ACPI A/C adaptor status 
> > not updated upon resume
> > 
> > 
> > That's ACPI, not swsusp - it must be toggling the state based 
> > on events,
> > not actually detecting it.
> > 
> > Regards,
> > 
> > Nigel
> > 
> > On Fri, 2003-07-18 at 08:06, Eric Altendorf wrote:
> > > I'm still running an old version swsusp so I apologize if this has 
> > > already been addressed, but I figured I'd just make mention of it.
> > > 
> > > If the laptop is resumed with a different A/C adaptor state (online 
> > > vs. offline) than when it was suspended, the /proc entry is 
> > incorrect 
> > > upon resume.  E.g., plug laptop in, suspend, unplug laptop, resume,
> > > /proc/acpi/ac_adapter/ADP1/state  reports still online until a 
> > > subsequent plug/unplug event.
> > > 
> > > Eric
> > > 
> > > 
> > > -------------------------------------------------------
> > > This SF.net email is sponsored by: VM Ware
> > > With VMware you can run multiple operating systems on a 
> > single machine.
> > > WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual 
> > machines at the
> > > same time. Free trial click here: 
> > http://www.vmware.com/wl/offer/345/0
> > > 
> > _______________________________________________
> > > swsusp-devel mailing list
> > > swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > https://lists.sourceforge.net/lists/listinfo/swsusp-devel
> > -- 
> > Nigel Cunningham
> > 495 St Georges Road South, Hastings 4201, New Zealand
> > 
> > You see, at just the right time, when we were still powerless,
> > Christ died for the ungodly.
> > 	-- Romans 5:6, NIV.
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.net email is sponsored by: VM Ware
> > With VMware you can run multiple operating systems on a 
> > single machine.
> > WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual 
> > machines at the
> > same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: VM Ware
> With VMware you can run multiple operating systems on a single machine.
> WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
> same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
> _______________________________________________
> swsusp-devel mailing list
> swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/swsusp-devel


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
