From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI problems on Athlon MP system
Date: Fri, 10 Jan 2003 13:46:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030110124637.GC12516@poup.poupinou.org>
References: <20030110030741.GA2580@stikine.ucs.sfu.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030110030741.GA2580-0ze2hujOWYhqr3d4nwidZ7Dks+cytr/Z@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Martin Siegert <siegert-z1KUqvL5UUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 09, 2003 at 07:07:41PM -0800, Martin Siegert wrote:
> Hi,
> 
> I am not sure whether this is the correct place to ask this question,
> but hopefully you can point me in the right direction.
> 

...

> The machine has ACPI enabled in the bios. When I compile the kernel
> with ACPI disabled, the poweroff command shuts down the system, but
> does not shut off the power (it acts exactly like the halt command).
> In order to shutoff the machine I must press the power switch.
> 
> When I compile the kernel with ACPI enabled the situation is worse:
> the halt and poweroff commands still work in exactly the same way
> (shutdown the system), but now I cannot switch off the machine
> anymore: pressing the power switch has absolutely no effect
> (regardless of how long I hold the switch). The only way to

ACPI spec require that holding the power switch for 4 second will
switch off the system in *any* case as an emergency power down.
Those if really you can not power down your machine this way,
this is more likely an hardware trouble.

BTW, have you tried the latest ACPI patch on sf.net?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
