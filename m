From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: acpi-problem with samsung x10 1700
Date: 19 Dec 2003 14:49:45 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1071863385.2449.83.camel@dhcppc4>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8933@hdsmsx402.hd.intel.com>
	 <1071854398.2072.111.camel@drnpc01.hell.hellgate.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1071854398.2072.111.camel-zol+sbJHWF4t3qbh98lueDGFqIE1/xf0XqFh9Ls21Oc@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "D. S." <silent.bob-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hmmm, no missing return statements on ADP1 and BAT1 _STA -- look like
the problem must be elsewhere.

On Fri, 2003-12-19 at 12:19, D. S. wrote:
> ok, here is the output.
> 
> i hope you guys can help me out!
> 
> regards
> dennis
> 
> 
> Am Fr, 2003-12-19 um 17.33 schrieb Brown, Len:
> > Look in the status method specifically:
> > 
> > \SB_.ADP1._STA
> > \SB_.BAT1._STA
> > 
> > Also, it is okay to post your acpidmp output to the list so people can
> > take a look at it.
> > 
> > Cheers,
> > -Len
> > 
> > > -----Original Message-----
> > > From: D. S. [mailto:silent.bob-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org] 
> > > Sent: Friday, December 19, 2003 11:08 AM
> > > To: Brown, Len
> > > Subject: RE: [ACPI] acpi-problem with samsung x10 1700
> > > 
> > > 
> > > hi,
> > > thanks for the quick answer...
> > > 
> > > this is what i thought.
> > > my problem is, that i don't know where to put that add. return (or
> > > change the value to the correct one).
> > > in the dsdt (ref to ADP1 and BAT1) file are returns (i.e 
> > > return (local0)
> > > ).
> > > any idea?
> > > 
> > > regards
> > > dennis
> > > 
> > > Am Fr, 2003-12-19 um 16.43 schrieb Brown, Len:
> > > > AML is like C -- if there is no return statement from a 
> > > routine (method)
> > > > then nothing gets returned.
> > > > 
> > > > Unfortunately the microsoft implementation of the AML interpreter
> > > > behaves as if there is a return statement, and so bugs in AML get
> > > > through windows validation.
> > > > 
> > > > For this to work on the ACPICA AML interpreter, you need to 
> > > insert the
> > > > missing return statements in the AML -- we don't have a 
> > > workaround for
> > > > this type of BIOS bug.
> > > > 
> > > > -Len
> > > > 
> > > > > -----Original Message-----
> > > > > From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> > > > > [mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of D. S.
> > > > > Sent: Friday, December 19, 2003 10:10 AM
> > > > > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > > > Subject: [ACPI] acpi-problem with samsung x10 1700
> > > > > 
> > > > > 
> > > > > hi folks,
> > > > > maybe you folks could help me out.
> > > > > i fixed the dsdt.aml so far that iasl compiles without an error.
> > > > > so far so good.
> > > > > 
> > > > > now dmesg gives me the following:
> > > > > 
> > > > > acpi-1121: error:method execution failed [\SB_.ADP1._STA] (Node
> > > > > c1613920), AE_AML_NO_RETURN_VALUE
> > > > > acpi-1121: error:method execution failed [\SB_.BAT1._STA] (Node
> > > > > c1613a20), AE_AML_NO_RETURN_VALUE
> > > > > 
> > > > > this means, if i'm correct, that the stats for battery 
> > > and ac-adapter
> > > > > can't be read.
> > > > > i am not sure where to correct this and how.
> > > > > 
> > > > > so you maybe need some info on the machine/dist.
> > > > > samsung x10 xtc1700
> > > > > bios 06ye (samsung orginal shipped)
> > > > > suse 9.0 (wich is patched already for reading dsdt)
> > > > > 
> > > > > help would be great!
> > > > > 
> > > > > regards
> > > > > d.
> > > > > 
> > > > > Some programming languages manage to absorb change, but withstand
> > > > > progress. -- Epigrams in Programming, ACM SIGPLAN Sept. 1982
> > > > > 
> > > > > 
> > > > > 
> > > > > -------------------------------------------------------
> > > > > This SF.net email is sponsored by: IBM Linux Tutorials.
> > > > > Become an expert in LINUX or just sharpen your skills.  Sign 
> > > > > up for IBM's
> > > > > Free Linux Tutorials.  Learn everything from the bash shell 
> > > > > to sys admin.
> > > > > Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> > > > > _______________________________________________
> > > > > Acpi-devel mailing list
> > > > > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > > > > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> > > > > 
> > > One difference between a man and a machine is that a machine is quiet
> > > when well oiled.
> > > 
> > > 
> Democracy is the recurrent suspicion that more than half of the people
> are right more than half of the time. -- E. B. White



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
