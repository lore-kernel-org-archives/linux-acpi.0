From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: System hang when trying to enter sleep/standby state
Date: Thu, 13 Feb 2003 23:09:24 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030213220924.GA9166@elf.ucw.cz>
References: <200302131628.h1DGSID27482@ikffws2.ikff.uni-stuttgart.de> <Pine.LNX.4.33.0302131031290.1133-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302131031290.1133-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Cc: Jens Haug <haug-X6ztD3ggwzuBAmxm6OvjtTjhTm2NLCe8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > You're absolutely right. But, most people do those things deliberately, 
> > > and know the consequences. 
> > 
> > Do you think someone becomes root and does an "echo 5 > /proc/acpi/sleep"
> > by accident? ;-)
> 
> Definitely. By, trying a range of values, they stumble on one that crashes 
> their system. 

And what? Try echo 5 > /proc/kmem and see what you get *then*.

> > > That's a perfectly valid thing to do, and the kernel has no right to crash
> > > when he does something like that. 
> > 
> > The kernel has the right to do what the specs say. There might be 
> > systems where this is wanted (which boot from read only medium and
> > need a really fast poweroff).
> 
> The kernel does what the specs say. Read the code. The system is placed 
> into S5 when doing off from a shutdown sequence, exactly what the spec 
> intended to be done. 
> 
> As a whole, we do enforce a minimum amount of policy we do not want to 
> lose users data. And that will happen. 
> 
> Let me repeat, and try and get you to listen: 
> 
> You *will* corrupt your data if you do not flush the disk buffers. 

Not true... With ext3 or reiser it is okay to power down system like
that.

> That's why it's so slow when you do a normal shutdown. That's why 
> immediately putting the system into S5 is so fast - we don't flush the 
> buffers. 

Normal shutdown takes services down in reverse older they start.

If you reboot by SAK-S,U,B, you can do it under a second on almost any
system. If you powerdown by 
kill -15 -1; sleep 1; kill -9 -1; umount /; echo 5 > /proc/acpi/sleep

you have clean & very fast way to do it.

And btw if someone does echo 4 > /proc/acpi/sleep and then fails to
pass resume=/dev/hdaX he's in pretty much same situation as when he
does echo 5 > sleep... And *way* worse if he manages to pass resume=
after he does fsck (silent corruption vs. fsck being run).

Better don't mess with sleep if you don't know what you know what you
are doing.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
