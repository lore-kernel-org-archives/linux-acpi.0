From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Mon, 20 Oct 2003 20:47:51 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031020184750.GA26154@hell.org.pl>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <yw1x8yngj7xg.fsf-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: M?ns Rullg?rd <mru-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote M?ns Rullg?rd:
> > Suspending and resuming from S1 disables ACPI interrupts for my machine
> > (ASUS L3800C laptop). No further interrupts and events are generated,
> > /proc/interrupts shows no change w.r. to ACPI. This happens regardless of
> > whether the specific IRQ is shared or not.
> suspend, the extra buttons (I use them to fire up programs) stop
> working.  Normally, they will generate an ACPI event, that is
> processed by acpid etc.  After a suspend, each button will work once.
> If I then close and open the lid, they will work one more time, and so
> on.  Any way I can help?

Please specify the type of suspend. The situation I described only occurs
for S1 (or, echo -n standby, more specifically), and only in certain kernel
versions.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
