From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI/ECDT on gateway 200x notebook
Date: Wed, 7 Jan 2004 18:17:08 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040107171708.GQ14031@poupinou.org>
References: <3FF773E5.5070102@rochester.rr.com> <Pine.LNX.4.44.0401032005180.7785-100000@data.upl.cs.wisc.edu> <20040106183426.GJ14031@poupinou.org> <3FFB552F.8030508@rochester.rr.com> <20040107104941.GL14031@poupinou.org> <20040107114742.1f2de5b1.greg@morningdave.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040107114742.1f2de5b1.greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Cc: richibb-aYIB8uWIUb2Vn7q6wjsIow@public.gmane.org, charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 07, 2004 at 11:47:42AM -0500, Greg Sarjeant wrote:
> Ducrot,
> 
>    Thanks for the help. I have updated the DSDT as you suggested and applied the patch to load it. I had to make a small change to the patch to get it to compile with 2.4.23. I changed the #include from this:
> 
> 	#include "dsdt_table.h"
> 
> to this:
> 	
> 	#include <acpi/dsdt_table.h>
> 
>     Once I did that, everything worked like a charm. Using kernel 2.4.23, the latest acpi patch from acpi.sourceforge.net, this DSDT override patch and the fixed DSDT, I am back to the point where I was when I had just applied the bit_width patch. However, the behavior is now improved, because the lid now correctly reports its state. Before, when I was only using the bit_width patch, I had a lid button, and it generated events, but it always reported its state as "closed".
> 

Interresting.  I had to add a patch made by another guy (Shaohua Li IIRC),
and I guess that part give you correct events.
So it's not my fault if your lid work now, sorry :)

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
