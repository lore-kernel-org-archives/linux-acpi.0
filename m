From: "Mr. Mailing List" <mailinglistaddie-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: how to get Fn key working on compaq 2100/2110
Date: Fri, 27 Jun 2003 14:47:44 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030627214744.42676.qmail@web20707.mail.yahoo.com>
References: <20030626103302.GQ19556@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030626103302.GQ19556-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

What I am asking is, how do i see if the hardware
supports it?  I know some people have laptops that
bypass the kernel and put it in hibernate with certain
keystrokes.


--- Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:
> On Tue, Jun 24, 2003 at 01:08:48PM -0500, David
> Cougle wrote:
> > Is this to say that with 2.5/2.6 my Compaq
> 2100/2110 will bypass kernel
> > and suspend to ram? How do I see if it supports
> that?  I am running
> > acpid.
> > 
> 
> acpid will only do (amongst other thinks like
> perhaps unloading
> modules, etc.)
> echo -n 3 > /proc/acpi/sleep
> when it detect the correct event via
> /proc/acpi/event
> 
> via an external script if you press the sleep
> button.
> 
> You still have to write the shell script called by
> acpid, if
> none are already done, or if the distributor have
> not provided
> one.
> 
> Some people may want to replace the echo stuff via
> for
> example a '/sbin/shutdown -h now'
> 
> 
> For your second question, you first have to shutdown
> acpid.
> Then do a 
> cat /proc/acpi/event
> 
> By pressing the power button, or the sleep button,
> etc., you should
> see those events.  acpid will do exactly the same,
> just that when
> it look those events, it will take appropriate
> actions by calling external
> scripts.
> 
> Cheers,
> 
> -- 
> Ducrot Bruno
> 
> --  Which is worse:  ignorance or apathy?
> --  Don't know.  Don't care.
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by: INetU
> Attention Web Developers & Consultants: Become An
> INetU Hosting Partner.
> Refer Dedicated Servers. We Manage Them. You Get 10%
> Monthly Commission!
> INetU Dedicated Managed Hosting
> http://www.inetu.net/partner/index.php
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>
https://lists.sourceforge.net/lists/listinfo/acpi-devel


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
