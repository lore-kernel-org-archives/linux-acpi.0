From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] S4bios for 2.5.52.
Date: Tue, 17 Dec 2002 13:39:02 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A5B1@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Ducrot Bruno' <poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Ducrot Bruno [mailto:poup-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org] 
> This patch add s4bios support for 2.5.52.
> 
> S4bios is an alternative for the ACPI S4 system suspend 
> state, but is a bit
> more easy to implement.  It suppose though that the BIOS 
> support this feature.
> For some BIOS, creating a so-called suspend partition with the help
> of lphdisk is OK.
> 
> Plus, it permit for Pavel to have a nice graphic display at 
> suspend/resume. 
> 
> echo 4 > /proc/acpi/sleep is for swsusp;
> echo 4b > /proc/acpi/sleep is for s4bios.

I still am not clear on why we would want s4bios in 2.5.x, since we have S4.
Like you said, S4bios is easier to implement, but since Pavel has done much
of the heavy lifting required for S4 proper, I don't see the need.

Regards -- Andy
