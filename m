From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Fri, 24 Oct 2003 17:18:42 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031024151842.GB26732@hell.org.pl>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net> <20031020184750.GA26154@hell.org.pl> <20031023082410.GC643@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031023082410.GC643-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: M?ns Rullg?rd <mru-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Pavel Machek:
> Find out which versions break it, pay special atetion to
> hwsleep.c.

I stated in my original mail that the last working version was 2.6.0-test3.
test4 is broken w.r. to S1, and test5 resumes with ACPI interrupts gone.
I'll try to be more specific, though.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
