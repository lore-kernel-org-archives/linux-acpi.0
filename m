From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: CALL FOR TESTING
Date: Fri, 20 Sep 2002 11:10:56 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE98@orsmsx119.jf.intel.com>
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
To: 'Matthew Wilcox' <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Federico Di Gregorio <fog-NGVKUo/i/6DYtjvyW6yDsg@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Matthew Wilcox [mailto:willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org] 
> so you're one element short, and that element is what tells 
> us the address
> to call to enter C3.  Clearly this is a broken BIOS, but I 
> wonder if we
> couldn't hande this more cleanly ...
> 
> 	else if (object.processor.pblk_length < 4)
> 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid PBLK 
> length [%d]\n",
> 			object.processor.pblk_length));
> 	else {
> 		pr->throttling.address = object.processor.pblk_address;
> 		pr->throttling.duty_offset = acpi_fadt.duty_offset;
> 		pr->throttling.duty_width = acpi_fadt.duty_width;
> 		if (object.processor.pblk_length >= 5)
> 			pr->power.states[ACPI_STATE_C2].address =
> 				object.processor.pblk_address + 4;
> 		if (object.processor.pblk_length >= 6)
> 			pr->power.states[ACPI_STATE_C3].address =
> 				object.processor.pblk_address + 5;
> 	}
> 
> Andy, what do you think?

I'd rather not add this workaround...it's only one system, and there really
isn't even a big impact on that particular system.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
