From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: s3 on vaio z600
Date: Fri, 28 Mar 2003 21:59:23 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030328205923.GG5147@zaurus.ucw.cz>
References: <1048682112.501.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1048682112.501.11.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, ole.rohne-vJEk5272eHo@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> So I conclude that either there is something wrong with _WAK and _BFS or
> it locks up in wakeup.S - just before the hardware part in control of
> the leds gets resumed (resetted). 

So disassemble _WAK/BFS and look
what it does/where it dies.

> Now, I would really appreciate any hint, how I can gather more
> information. Is there any chance to find out wether it actually jumps
> into wakeup.S after resume?

Few leds on parallel port may do the trick... along with outb() in wakeup.S.

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
