From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: 2.6.15-mm2
Date: Sat, 7 Jan 2006 14:58:00 -0800
Message-ID: <20060107145800.113d7de5.akpm@osdl.org>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<43C0172E.7040607@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <43C0172E.7040607-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brice Goglin <Brice.Goglin-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Brice Goglin <Brice.Goglin-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org> wrote:
>
> 2) acpi-cpufreq does not load either, returns ENODEV too. It's probably
>  git-acpi. I tried to revert it but there are lots of other patches
>  depending on it, so I finally gave up.

OK, let me try to reproduce this.  acpi and cpufreq are fully merged up, so
this bug may well be in mainline now.

>  3) wpa_supplicant does not find my WPA network anymore (while iwlist
>  scanning sees). I didn't see anything relevant in dmesg. My driver is
>  ipw2200.

It's things like this which make me consider a career in carpentry.

I assume 2.6.15 works OK?

Unfortunately I don't know diddly about wpa_supplicant (how come FC5-test1
doesn't ship it?)

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
