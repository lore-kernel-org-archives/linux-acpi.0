From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH] s3_bios and lcall $0xc000,$3
Date: Tue, 18 Feb 2003 10:31:21 -0600 (CST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0302181029280.1035-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0302181426010.22900-100000@godzilla.axis.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0302181426010.22900-100000-Hi2dXqvvzfEtpH44vsTDoQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Cc: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



> I found this somewhat interesting PM code in the GPL part of the nvidia 
> binary driver. I wonder what the comment is talking about wrgds to APM vs. 
> ACPI and if it might work now. Haven't tried... (the rm_power_management 
> functions are in the binary-only part).

>         // our video bios doesn't support APM, only ACPI
>         // for now, return an error to try and keep the machine
>         // from entering suspend/resume, so as to not lose any
>         // user's data.

Makes sense - they want to save the framebuffer contents, and I imagine 
it's certainly a lot easier with a full 32-bit OS to work with than with a 
BIOS, even if it is running in protected mode..

	-pat



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
