From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Tue, 30 Jul 2002 11:32:06 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0207301125370.22697-100000@cherise.pdx.osdl.net>
References: <20020730182255.GC7567@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020730182255.GC7567-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> > >There's power cycle and whole kernel bootup. Device state is
> > >completely lost during suspend to disk.
> > 
> > As it is during suspend-to-ram in most cases (most devices except
> > a couple of them are actually powered down and the drivers have to
> > bring them back up, at least on pmac, though on x86, the APM BIOS
> > helps you a bit there).
> 
> APM BIOS is irrelevant here (when using APM BIOS, everything is done
> by BIOS).

No, it's not. There is still a suspend sequence that must take place in 
the kernel. 

> What I'm doing is "drivers don't have to care about stopping requests
> because everything is stopped". If you are willing to go through all
> drivers and add stopping in them, thats fine with me, but I believe
> its post-2.6.

We have to deal with drivers. Someone has to modify the drivers to make 
them properly support power management. 

Now, it's not as bad as it sounds. Many drivers have pm_callback calls
that should be modified to the new style. So, we know what to do for many
devices. Other than those, the actively maintained drivers will be 
converted, as will be the most popular drivers. Others will gradually be 
taught to deal with it with PM properly. 

The burden is not necessarily on our shoulders. And, we can break 
everything. Trust me, I have permission ;)

	-pat



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
