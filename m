From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S1bios
Date: Wed, 12 Mar 2003 22:52:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030312215246.GA136@elf.ucw.cz>
References: <E18sfx5-0001dg-00@incognito> <Pine.LNX.4.33.0303110908260.1003-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303110908260.1003-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: lneves-3+EeCmRbAIo+BYJ/izffpQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > As S4Bios was created to use the ability of the machines who still have some 
> > APM support to overcome the current limitations and difficulties of swsusp, 
> > isn't it possible to do the same with S1?
> 
> No. S1 is a very simple suspend state, and IIRC, doesn't require that 
> devices even be powered down. 
> 
> There are two solutions to your problem - a quick easy one that anyone can 
> do, and a right one that we desparately need people to start doing. 
> 
> The first: userspace. You may be able to turn off the backlight via some 
> command. I've seen it done before, but it's been a long time. You may also 
> be able to spin down the disks. 

Actually, I have not found out a way to turn off backlight on toshiba
4030cdt without using APM. Nor I know how to turn off backlight on hp
omnibook.

> The right way to do it is to fix the drivers to properly handle suspend/
> resume transitions. It's needed for all power states, as well as 
> supporting runtime power management. 

Well, and should S1 turn backlight off? It seems like the original
poster wants S3, not S1.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
