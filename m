From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: RE: ACPI interrupts..
Date: Thu, 26 Sep 2002 10:09:38 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DEC8@orsmsx119.jf.intel.com>
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
To: "'KOCHI, Takayoshi'" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, 'Bernd Pfrommer' <berndp-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: KOCHI, Takayoshi [mailto:t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org] 

> From the definition of SCI in the spec:
> |A system interrupt used by hardware to notify the OS of ACPI events.
> |The SCI is an active, low, shareable, level interrupt.
> 
> Although the spec states that the SCI is an active-low & level
> interrupt, there are some ia64 platforms that break this rule
> (such as BigSur, NEC AzusA).  But they describe the SCI's polarity
> and trigger in MADT's interrupt source override record.

OK, so do the affected machines have an interrupt source override for the
ACPI IRQ (usually 9)? Look for INT_SRC_OVR in dmesg.

-- Andy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
