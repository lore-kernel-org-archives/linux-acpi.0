From: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: Linux 2.4.23-pre8
Date: Mon, 27 Oct 2003 10:29:22 -0200 (BRST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0310271028050.17121-100000@logos.cnet>
References: <3F995586.3020408@comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F995586.3020408-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David van Hoose <david.vanhoose-Wuw85uim5zDR7s880joybQ@public.gmane.org>
Cc: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



On Fri, 24 Oct 2003, David van Hoose wrote:

> Attached config, boot messages, and interrupts for 2.6.0-test8-bk2.
> The boot messages do not have any USB debug, but do have ACPI debug. 
> Also, all of my USB ports work 100% of the time on 2.6 with ACPI enabled.

David, 

Have you tried what Len suggested in the bugzilla?

----------
Created an attachment (id=1185)
SIS I2C quirk foundin 2.6 but not in 2.4

One difference between 2.4 and 2.6 is the attached SIS quirk added for 
I2C.

Please back that quirk out of your 2.6 tree like so:

patch --dry-run -Rp1 </tmp/sis_quirk_26.diff

remove the code that depends on it from your .config:
CONFIG_I2C_SIS96X=n

and see if that makes 2.6 mis-behave like 2.4, or if USB still runs.

Also, please verify for me that you get ACPI events properly.
If you connect your USB mouse to one of the ports that isn't shared
with acpi, then you should be able to trigger ACPI interrupts by
pressing your power button.  (if acpid is enabled, it may shut down your
system,
so you may want to disable that first), and observering the
/proc/interrupts row for acpi incrementing for each button press.




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
