From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: ACPI source release updated (20021002)
Date: Thu, 3 Oct 2002 13:29:56 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DF00@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "'berndp=p32f3XyCuykqcZcGjlUOXw@public.gmane.org'" <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Bernd Pfrommer [mailto:berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org] 
>     - it seems that there are a lot of these link devices, not just 
> LNUS, no? Or do you think LNUS is the only one causing 
> trouble? Maybe I 
> can somehow get rid of it then?

You want them there if you are in a mode (usually PIC) that uses them. I
think we may want to eliminate the dmesg output concerning them unless
ACPI_DEBUG_OUTPUT, since in your case they're not even used (except for
LNUS).

>     - is there a way to disable the link devices altogether 
> by modifying 
> the DSDT?

They really are just a logical representation of the chipset routing control
registers, so they should be harmless.

>     - any suggestions as to why pci=noacpi does not fix the problem?
>     - any other things I could try?

No, I'm kind of mystified why fixing GETI didn't fix things.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
