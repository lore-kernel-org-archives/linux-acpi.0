From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] s3_bios and lcall $0xc000,$3
Date: Mon, 17 Feb 2003 18:16:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030217171610.GC25625@poup.poupinou.org>
References: <Pine.LNX.4.33.0302171423290.21415-100000@godzilla.axis.se> <Pine.LNX.4.33.0302171647410.21415-100000@godzilla.axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302171647410.21415-100000-Hi2dXqvvzfEtpH44vsTDoQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 17, 2003 at 04:53:16PM +0100, Bjorn Wesen wrote:
> On Mon, 17 Feb 2003, Bjorn Wesen wrote:
> > I'm guessing that the bios call corrupt some data segment pointers, because 
> > if I print out any of the real_save_* values, they are all zero! WHich 
> > obviously causes a crash when you load up a zero GDT, zero CR0, zero CR4 
> > etc... 
> 
> Yup - the s3_bios triggered lcall corrupts DS (and possibly SS) as well. CS 
> is still alive though so redoing the CS->DS duplicating worked.. the 
> following is not in patch format but you get the idea :)
> 
> 	lcall   $0xc000,$3
> 
> +       # reset the data and stack segments after possible bios tampering
> +       movw    %cs, %ax
> +       movw    %ax, %ds
> +       movw    %ax, %ss
> 
> So now S3 resume works on the travelmate 630! :)
> 
> However, the IDE system (using DMA) seems to not survive the resume. WHat is 
> the current status of fixing that ? (kernel 2.5.61)
> 

IMO this lcall should not be used at all.  This is used by the
BIOS only on POST stage in order to setup the VGA subsystem (not
reinitialize, which was first intented, I guess).

Actually, everything can happen, as to setup the MCH in order
to expose the VGA shadowing for example, which is completely
wrong at this stage, or else, kaboom.

Then, providing a workaround in order to prevent the kaboom
can work for you, but not for others.
Hum this workaround do not work for you?  Try this one.
But kill others.

Worst, in case of s4bios, since the whole POST is done
(and because I use the same wakeup code), then
we already know that the lcall is done.  Then, do I have to
provide a different wakeup code just for s4bios?

Pavel, really, we need to provide a better way to reinitialize
the VGA subsystem.

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
