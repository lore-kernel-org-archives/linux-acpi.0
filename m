From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [ACPI] Linux 2.6-pre1 Does not boot on ASUS L3800C: lock up in acpi while "Executing all Devices _STA and_INIT methods"
Date: Mon, 14 Jul 2003 18:40:48 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030714164048.GA15445@hell.org.pl>
References: <3F12AF06.6080004@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3F12AF06.6080004-GANU6spQydw@public.gmane.org>
To: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Eric Valette:
> I happily run 2.4.21-pre5 with ACPI enabled and everything works just 
> fine. I tried today 2.6-pre1 with exactly the same hardware 
> configuration as the 2.4 one and the laptop does not boot. It hangs 
> while dispaying : "Executing all Devices _STA and_INIT methods" 
> allthough it has already printed several '.'

I reported the same on ACPI devel several (18?) hours ago. For now, the
solution is to compile a kernel without APIC support. No, the noapic option
doesn't help.

The problem appeared in 2.5.74, along with changes in handling a
BIOS-disabled APIC, or so I suppose.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
