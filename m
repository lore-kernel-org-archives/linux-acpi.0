From: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Subject: Re: display interface?
Date: Thu, 05 Sep 2002 11:54:40 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D76C770.40807@prairienet.org>
References: <200209041157.g84BvCX20736@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> this may be a dump question: is there a acpi interface to the laptop display?
> Is it possible to make the display darker/lighter depending on the state of battery?
> 
>      Joerg

There is no standard interface under ACPI for this.  Vendors implement 
the control in a variety of ways.  You'll have to first find a way to 
set the brightness for your model laptop (try searching the internet for 
utilities or info).  Then you'll have to hook into the ACPI event system 
for the battery or AC adapter and trigger the brightness accordingly. 
Not a nice task to request of your average computer user.

In an ideal world, someone would spell out an interface for common 
functions like this (I don't know if it should be in the kernel or not), 
and implementations could be plugged into this interface at a fine 
grain.  There would also be a "power management contruction kit", a very 
general and configurable application, providing functionality similar to 
the proprietary tools that come with laptops under Windows.  You'd also 
have laptop vendors caring if all functionality of their products can be 
accessed from Linux...

-John



-- 
http:// i      .   /



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
