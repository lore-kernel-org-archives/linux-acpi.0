From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Hardware state saving & X
Date: Wed, 15 Oct 2003 09:32:18 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0310150924400.953-100000@localhost.localdomain>
References: <20031014235240.GD20789@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031014235240.GD20789-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> Well, each application should do 
> 
> 	* save state
> 	* reinitialize everything
> 
> when it is switched to, and 
> 
> 	* shutdown everything
> 	* restore state
> 
> when it is being switched from. That includes random game, and that
> includes X.

Whatever, that's fine. 

> > Well, it depends on what X (and in general userspace) needs to know on a 
> > power-state transition. Alan, how does/will X behave differently for each 
> > power state that we can enter? 
> 
> Different scripts should run on apm -s (BIOS saves most of hw state)
> and S3 (we have to save most of hw state).

The fact that different behavior exists is completely obvious (refer to 
the question and documentation). The question was *how* it was different 
from a userpsace perspective. I.e. what exactly is saved, and what isn't. 

Under APM, the BIOS handles the state transition, but it does not know 
each device initimately, so the OS still has to handle some of the device 
state. 

Video devices have an int10 call to save/restore state, which is what the 
APM BIOS uses. Alan, would it suffice to call that from the kernel, in 
either vm86 mode or real mode to handle all the saving/restoring. If we 
were able to call that, what more would you have to do? 


	Pat




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
