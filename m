From: John Knottenbelt <jak97-CezfXpuMXD6Fxr2TtlUqVg@public.gmane.org>
Subject: Re: Computer Resets on Resume From S3
Date: Sat, 22 Nov 2003 17:16:10 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200311221716.10690.jak97@doc.ic.ac.uk>
References: <200311201522.15255.jak97@doc.ic.ac.uk> <200311212333.10341.jak97@doc.ic.ac.uk> <20031122131957.GA1162@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031122131957.GA1162-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Saturday 22 November 2003 1:19 pm, Pavel Machek wrote:
> I've seen something similar before -- it usually meant we left
> hardware in "weird" state and it crashed in BIOS.
>
> Can you add "noapic" first, then turn off all unneccesary drivers? No
> SMP, please.
> 								Pavel

Hi,

I boot with noapic and also init=/bin/bash so no modules loaded. Same 
behaviour. 

My kernel config is at: http://www.doc.ic.ac.uk/~jak97/dsdt/config.gz
And the dmesg is: http://www.doc.ic.ac.uk/~jak97/dsdt/dmesg
Other info at http://www.doc.ic.ac.uk/~jak97/dsdt

I am running with standard DSDT with relaxed AML checking, however I have also 
tried a fixed DSDT previously and that didn't seem to make any difference at 
all.

Are there any other useful places I might put an infinite loop?

What about something to check before the machine goes into S3?

I am compiling for Athlon architecture, do you think I should try i386?

Could it be a gcc problem? gcc is version 3.3.2.

Thanks

John



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
