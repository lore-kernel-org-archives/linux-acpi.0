From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [giri@lmc.cs.sunysb.edu: Resume from suspend-to-ram]
Date: Sat, 21 Feb 2004 10:57:38 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1077321457.9623.27.camel@gaston>
References: <20040220235512.GA27779@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040220235512.GA27779-sTXFmx6KbOnUXq0IF5SVAZ4oGUkBHcCu@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Kronos <kronos-OwEdLhkac/ZLIFpYAn0waQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Giridhar Pemmasani <giri-IxWJ8JVbGpr5NRxSJurNR4dd74u8MsAO@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


> Since new radeonfb has suspend/resume driver model, I thought I might
> give it a try, but still the laptop would hang during resume. With a
> bit of trial and error (and some guess work), I got the laptop to
> resume successfully with the following patch.

> .../.../

That's interesting. You are basically preventing fbdev from resuming
at all. Well, partially, since you still have the radeonfb_set_par,
which is supposed to set back the mode.

So X manage to restore the chip in a way that radeonfb doesn't.

Can you send me a dump of XFree log after such a successful suspend
& resume phase ?

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
