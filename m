From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: acpi=force safe?
Date: Fri, 6 Feb 2004 22:13:34 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040206211334.GH13262@poupinou.org>
References: <3ACA40606221794F80A5670F0AF15F8401CBB685@PDSMSX403.ccr.corp.intel.com> <16644.65.164.3.3.1076087775.squirrel@mail.diamondcpu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16644.65.164.3.3.1076087775.squirrel-gjzqEhKAtSBis2HOlLKa7kEOCMrvLtNR@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nick Bartos <spam99-1EIjRwF9Gc5s5w19saIqfg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 06, 2004 at 11:16:15AM -0600, Nick Bartos wrote:
> Am I to understand that the worse that could happen is that the acpi
> features I compiled in (just standard and the button option) just wouldn't
> work?  If that is the case then that would be fine.

Just standard mean that all the IRQ routing was done by ACPI
amongst other things.  And you need to do so if you want to receive
events from the power button.

That part of the firmware may be broken, and you may have hang on boot
(even though I think it is safe now without lapic support even on old laptops).

> Really I just don't want things like kernel screw ups (which I thought I
> might have had once due to acpi, but I don't remember), or other things
> that affect system stability.
> 
> If I can compile in these things and force acpi on and not be any worse
> off stability wise than if I didn't force it, then that willl be fine for
> me.

Why not let user decide at boot time?  That easy to do so with syslinux
for example.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
