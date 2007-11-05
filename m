From: =?ISO-8859-1?Q?=C2ngelo?= Miguel Arrifano <miknix@gmail.com>
Subject: Re: Writing to the EC
Date: Mon, 5 Nov 2007 19:00:06 +0000
Message-ID: <20071105190006.04e31cc5.miknix@gmail.com>
References: <472E23BC.2010909@gmail.com>
	<200711050055.37904.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:11768 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426AbXKESwO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Nov 2007 13:52:14 -0500
Received: by ug-out-1314.google.com with SMTP id z38so960704ugc
        for <linux-acpi@vger.kernel.org>; Mon, 05 Nov 2007 10:52:12 -0800 (PST)
In-Reply-To: <200711050055.37904.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 5 Nov 2007 00:55:37 +0000
Carlos Corbacho <carlos@strangeworlds.co.uk> wrote:

> On Sunday 04 November 2007 19:55:40 Erik Andr?n wrote:
> > To make a long story short, I've hacked up a kernel module that dumps
> > the EC
> 
> For acer_acpi, we have a Perl script that can do this from userspace (but
> it should run on any other machine, since there's nothing Acer specific
> about dumping the EC registers).
> 
> http://aceracpi.googlecode.com/svn/trunk/acer_ec/acer_ec.pl
> 
> ./acer_ec.pl regs
> 
> (ACPI throws a few warnings in dmesg, because we're stepping on it's turf
> a bit here, but it's far simpler than having to write a kernel module
> just to get a few registers).
>  
Awesome! I found the EC register for changing the backlight on my laptop using acer_ec.pl.

Register 0xE2 - Set screen brightness to <value>
                Min: 0x00 Max: unknown
                Windows Brightness key Min: 0x14 Max: 0x5F

Register 0xE3 - Fade out screen brightness from <value>

This is for HP dv6535ep laptop which should be similar to any other HP laptop in the 6xxx series.

I'll look at other backlight drivers if I can do something..

> 
> -Carlos
> -- 
> E-Mail: carlos@strangeworlds.co.uk
> Web: strangeworlds.co.uk
> GPG Key ID: 0x23EE722D
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks!!!
- -- 
Angelo Arrifano AKA MiKNiX
CSE Student at UBI, Portugal
Gentoo Linux AMD64 Arch Tester
miknix@gmail.com
http://miknix.homelinux.com
PGP Pubkey online

- - -
The only thing that experience teaches us is that experience teaches us nothing.
		-- Andre Maurois (Emile Herzog)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHL2gzNahyoD2SuwsRAnqXAKCcWxVvXy4AudRvRPgqkYn8Oybo4wCffpn5
NkU/v5/HZFgqYc0GhEBzGi4=
=uPxz
-----END PGP SIGNATURE-----
