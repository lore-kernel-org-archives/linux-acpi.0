From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: ACPI interrupts..
Date: Thu, 26 Sep 2002 10:33:29 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEC9@orsmsx119.jf.intel.com>
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
To: 'Linus Torvalds' <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>
Cc: "'KOCHI, Takayoshi'" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, 'Bernd Pfrommer' <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Linus Torvalds [mailto:torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org] 
> My machine says:
> 
>   ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] 
> polarity[0x0] trigger[0x0])
>   ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] 
> polarity[0x1] trigger[0x3])
> 
> but I have no idea what that means in ACPI-speak. That 
> "global_irq[0x9]"
> thing certainly matches my ACPI irq.
> 
> What does polarity[0x1] trigger[0x3] mean?

It means active HIGH, level-triggered.

Well, I think we have our answer. If there is an interrupt source override,
we should not force the ACPI interrupt to active-low, level.

I'll start working on a patch.

Regards -- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
