From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: suspend.c vs driver-model.txt
Date: Wed, 24 Jul 2002 08:51:34 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0207240843090.954-100000@cherise.pdx.osdl.net>
References: <20020724134715.6060914808@o-o.yi.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020724134715.6060914808-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Lyle <lwspm-RAHWjsxJnJUdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Wed, 24 Jul 2002, Lyle wrote:

> 
> Also, drivers/acpi/system.c seems to assume that SAVE_STATE and RESTORE_STATE 
> will implicitly disable and enable I/O, but that's not the way it's specified, 
> and that's not the way that any code wants to work -- that I can see.  Do we 
> agree?

You're right, there should be an explicit call to disable I/O for the 
devices. 

On a side, though related, note, while we were in Ottawa, several of us 
had a chance to sit down and hammer out exactly what needs to take place. 
The results exist in a notebook (a real, pencil-driven one), but have not 
had a chance to be expressed in ASCII text yet. (Frankly, it's a low 
priority right now: -EPLATEFULL). 

> > I don't know why driver.h has the enums listed in a different order from 
> > driver-model.txt, or if it's really necessary to fix the order, unless 
> > somebody decides to start doing ordered comparisons.

I assume you mean include/linux/device.h. Yes, the enums are in the wrong 
order. Thanks for pointing that out. 

	-pat



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
