From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Mon, 29 Jul 2002 11:00:41 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020729090041.GB115@elf.ucw.cz>
References: <Pine.LNX.4.44.0207241100080.954-100000@cherise.pdx.osdl.net> <20020724173809.10194@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020724173809.10194-Q0ErXNX1RuY/GWcAdfcqrQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, Lyle <lwspm-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> The nice thing here, I beleive, is that suspend to disk could then just
> be an additional generic step between 1) and 2) that takes care of
> dumping memory content to disk.

It can not, because after saving state you can not easily write to
swap partition.

> As far as suspend to disk is concerned, we have all sort of nasty issues
> we discussed that I don't feel like resuming right now, so I would rather
> have the lowest level driver able to play the backing store export a
> couple of "hooks" used to dump the pages to the medium, those would work
> synchronously, without VM activity, etc... The driver that is target for
> that would have pre-allocated what it needs, pre-mapped DMA mappings it
> needs etc...

Too complicated. Look at swsusp -- it is designed not to need
pre-allocated pages, pre-mapped DMA etc.

> Though, thinking as I write, injecting requests via the BIO layer may
> be a nicer solution, provided we make sure the driver won't get any
> request _but_ the ones we feed it. I don't trust a mecanism that would
> selectively stop given kernel threads, then just hope nobody will push
> requests any more. That's way too fragile to my taste. I'd rather
> freeze

Why is it fragile? You just have to be carefull. If you mark thread as
PF_IOTHREAD it must *not* generate requests unless told to.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
