From: <joerg.beyer-htSm2yLGOjU@public.gmane.org>
Subject: Re: Re: display interface?
Date: Thu, 5 Sep 2002 10:26:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209050826.g858QYX07834@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>, JohnBelmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org> schrieb am 05.09.02 04:56:15:
...
> utilities or info).  Then you'll have to hook into the ACPI event system 
> for the battery or AC adapter and trigger the brightness accordingly. 

I assume, that is done via acpid configuration. Where can I lookup
what events are sended on which conditiion ("use the source"
combined with a filename (and maybe a function/struct/...) is
of course considered a valid answer :-)

If my assumtion is correct: has anybody an example of how
to configure acpid to do "something" when the AC adapter is plugged
in or out?

> Not a nice task to request of your average computer user.
> 
> In an ideal world, someone would spell out an interface for common 
> functions like this (I don't know if it should be in the kernel or not), 
> and implementations could be plugged into this interface at a fine 
> grain.  There would also be a "power management contruction kit", a very 
> general and configurable application, providing functionality similar to 
> the proprietary tools that come with laptops under Windows.  You'd also 
> have laptop vendors caring if all functionality of their products can be 
> accessed from Linux...

    I share your dreams...
    Joerg



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
