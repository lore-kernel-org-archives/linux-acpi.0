From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: [ACPI] RE: ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
Date: Thu, 4 Sep 2003 11:33:46 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030904093346.GA14506@hell.org.pl>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCFB@hdsmsx402.hd.intel.com> <20030904085315.GA29773@hell.org.pl> <1062667556.13465.37.camel@idoru.kc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1062667556.13465.37.camel-65LrUGLyukAb1SvskN2V4Q@public.gmane.org>
To: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Martin Mokrejs <mmokrejs-V2lp6ZUObelkZyP8+xg2CQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Nils Faerber:
> Just FYI...
> I have kernel 2.4.22 + swsusp 1.1-rc7 running without problems on the
> very same machine (Asus L3800C, BIOS 121a).
[...]
> One point that proofs to be a good idea is to remove any unnecessary
> drivers before suspending, like USB, Firewire and ethernet and to
> re-insert them afterwards. The attached script does this.

Actually, most modules do not need to be unloaded. I don't know about
firewire (I don't use it), but certainly 8139too contains proper
suspend/resume support, I even had no problems suspending with yenta_socket
and orinoco_cs card. As of now: no modules unloading at all. Anyway, the
crash is not swsusp related.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
