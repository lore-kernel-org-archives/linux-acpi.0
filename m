From: Casey Harkins <charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org>
Subject: Re: acpi on gateway 200x
Date: Fri, 24 Oct 2003 12:53:59 -0500 (CDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0310241211190.16106-100000@data.upl.cs.wisc.edu>
References: <20031023024953.GA29088@masanjin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031023024953.GA29088-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: William Morgan <wmorgan-acpi-devel-xW3KcqxHEMnk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Howdy William,

I'm the one who reported the problem with the 400VTX. Unfortunately, there
are other more pressing issues at work I have to deal with, but I'm going
to try to get the ECDT problem figured out eventually. We have two of
these laptops, both running Linux, and would really like to have battery
monitoring working!


-casey


On Wed, 22 Oct 2003, William Morgan wrote:

> Excerpts (reformatted) from Li, Shaohua's mail of 19 Oct 2003 (EDT):
> > Somebody has reported the same problem. It's about Gateway 400VTX. The
> > reason is BIOS of Gateway 400VTX lacks ECDT table.  And before
> > initialize EC device, DSDT use ec space region when execute some ASL
> > init methods. This will cause that battery can't be initializing. From
> > your dmesg, I find your BIOS lacks the ECDT too. So I think it's the
> > same problem.  A solution is to add an ECDT. But I can't find a tool
> > for this.
>
> Is there some way I can help fix this problem?
>
> --
> William
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: The SF.net Donation Program.
> Do you like what SourceForge.net is doing for the Open
> Source Community?  Make a contribution, and help us add new
> features and functionality. Click here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
