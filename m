From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [ACPI] Vaio doesn't poweroff with 2.4.22
Date: Mon, 15 Sep 2003 15:53:03 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030915135303.GH11391@poupinou.org>
References: <Pine.GSO.4.21.0309150835480.3191-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309150835480.3191-100000-Q9iLAqk50tFNk+PO8Cj175kigfUh6rMo@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Development <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 15, 2003 at 08:43:56AM +0200, Geert Uytterhoeven wrote:
> 	Hi,
> 
> With 2.4.22, my Sony Vaio PCG-Z600TEK (s/600/505/ in US/JP) shows a regression
> w.r.t. power management:
>   - It doesn't poweroff anymore (screen contents are still there after the
>     powering down message)
>   - It doesn't reboot anymore (screen goes black, though)
>   - It accidentally suspended to RAM once while I was actively working on it (I
>     never managed to get suspend working, except for this `accident'). I didn't
>     see any messages about this in the kernel log.
> 


Are you able to reboot without acpi?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
