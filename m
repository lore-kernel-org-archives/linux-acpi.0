From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: ACPI/ECDT on gateway 200x notebook
Date: Wed, 7 Jan 2004 12:12:15 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040107121215.7ced87c0.greg@morningdave.org>
References: <3FF773E5.5070102@rochester.rr.com>
	<Pine.LNX.4.44.0401032005180.7785-100000@data.upl.cs.wisc.edu>
	<20040106183426.GJ14031@poupinou.org>
	<3FFB552F.8030508@rochester.rr.com>
	<20040107104941.GL14031@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040107104941.GL14031-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: richibb-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org, charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Ducrot,

    I've got an email that is pending moderator approval because I misbehaved and attached too many things to it, so this may seem slightly out of context. However, I applied the following patches to a 2.4.23 kernel:

	latest ACPI patch from acpi.sourceforge.net
	DSDT override patch from www.poupinou.org/acpi (slightly modified)
	Luming's Embedded Control patch from bugzilla.kernel.org (bug 1744)

Now everything works! The battery gives me state info and charging/discharging rate. The lid correctly reports its state. It all looks hunky-dory.

    I had attached the updated patch and my fixed DSDT to my prior email, which is why it is getting hung up. I'll go ahead and attach them to bug 1744, and update with these results, too. Thanks!

    Greg



On Wed, 7 Jan 2004 11:49:41 +0100
Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:

> On Tue, Jan 06, 2004 at 07:39:11PM -0500, Rich Ibbotson wrote:
> > Thanks for the reply.  I've attached the disassembled dsdt from
> > "iasl -d  dsdt.dat".  I notice that the iasl output has "\_SB.PCI0" 
> > whereas the acpidmp output has "\_SB_.PCI0".  I'll try that with your 
> > fake_ecdt patch.
> > 
> > I do see an error and two warnings when I let iasl compile the dsdt:
> > 
> 
> ...
> 
> > dsdt.dsl  2620:                     Field (ECR, DWordAcc, Lock, Preserve)
> > Error    1048 -                              ^ Host Operation Region 
> > requires ByteAcc access
> 
> The problem you encounter is here.  You have to update your dsdt by
> replacing that DWordAcc by ByteAcc.  You can see something for doing
> that via http://www.poupinou.org/acpi/.
> 
> -- 
> Ducrot Bruno
> 
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
