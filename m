From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] [15/105] x86_64: Add documentation for CPU hotplug ACPI  extension
Date: Mon, 16 Jan 2006 17:02:36 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005B83B30@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ak-l3A5Bk7waGM@public.gmane.org, torvalds-3NddpPZAyC0@public.gmane.org
Cc: discuss-Wa75r+71Mmgdnm+yROfE0A@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

(corrected Ashok Raj's e-mail address, added linux-acpi).

One problem here is that big systems will not specify
even all the _present_ CPUs in the MADT -- they'll be
in the DSDT; as the MADT method I s limited to 256.

-Len

>-----Original Message-----
>From: ak-l3A5Bk7waGM@public.gmane.org [mailto:ak-l3A5Bk7waGM@public.gmane.org] 
>Sent: Wednesday, January 11, 2006 4:43 PM
>To: torvalds-3NddpPZAyC0@public.gmane.org
>Cc: discuss-Wa75r+71Mmgdnm+yROfE0A@public.gmane.org; akpm-3NddpPZAyC0@public.gmane.org; ashok.ray-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; Brown, Len
>Subject: [PATCH] [15/105] x86_64: Add documentation for CPU 
>hotplug ACPI extension
>
>
>Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.ray-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
>
>Signed-off-by: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
>
>Index: linux/Documentation/x86_64/cpu-hotplug-spec
>===================================================================
>--- /dev/null
>+++ linux/Documentation/x86_64/cpu-hotplug-spec
>@@ -0,0 +1,21 @@
>+Firmware support for CPU hotplug under Linux/x86-64
>+---------------------------------------------------
>+
>+Linux/x86-64 supports CPU hotplug now. For various reasons 
>Linux wants to
>+know in advance boot time the maximum number of CPUs that 
>could be plugged
>+into the system. ACPI 3.0 currently has no official way to supply
>+this information from the firmware to the operating system.
>+
>+In ACPI each CPU needs an LAPIC object in the MADT table 
>(5.2.11.5 in the
>+ACPI 3.0 specification).  ACPI already has the concept of 
>disabled LAPIC
>+objects by setting the Enabled bit in the LAPIC object to zero.
>+
>+For CPU hotplug Linux/x86-64 expects now that any possible 
>future hotpluggable
>+CPU is already available in the MADT. If the CPU is not available yet
>+it should have its LAPIC Enabled bit set to 0. Linux will use 
>the number
>+of disabled LAPICs to compute the maximum number of future CPUs.
>+
>+In the worst case the user can overwrite this choice using a 
>command line
>+option (additional_cpus=...), but it is recommended to supply 
>the correct
>+number (or a reasonable approximation of it, with erring 
>towards more not less)
>+in the MADT to avoid manual configuration.
>
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
