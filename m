From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: Testing: NVidia closed driver fails.
Date: Thu, 19 Sep 2002 16:48:18 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0209191645050.961-100000@cherise.pdx.osdl.net>
References: <200209192215.g8JMEv306270@pfn1.pefnos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200209192215.g8JMEv306270-a1J+ToZc0kR3t0M9ZKkFCQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Cc: Jochen Reinwand <jbr.1-hi6Y0CQ0nG0@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> To A. Grover: if the trouble lies in the bttv driver, the kernel will be 
> considered broken until both drivers co-exist..

Actually, if it's a problem with an nVidia video card, or something that 
is using the proprietary nVidia driver, the driver is considered broken 
and it is nVidia's problem. 

Because their driver is closed-source, kernel developers should not spend 
the time to reverse engineer the driver or attempt to figure out what 
they're trying to do. There are better things to worry about. 

Now, if you see this happening with an open-source driver, then we can 
help..

	-pat



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
