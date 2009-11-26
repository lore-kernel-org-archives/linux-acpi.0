From: andrej.gelenberg-KJIyc1CJxjQ@public.gmane.org
Subject: Re: eeepc-laptop: bugreport
Date: Thu, 26 Nov 2009 17:45:25 +0100
Message-ID: <cone.1259253925.112628.13921.1000@eeekiste>
References: <cone.1258203372.445001.1633.1000@eeekiste>
	<71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com>
	<cone.1258211472.464906.1633.1000@eeekiste>
	<71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com>
	<cone.1258312767.545625.1812.1000@eeekiste>
	<71cd59b00911260703r284b5bfdn3144de4db74b7c3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

i know, what it is not a proper solution, but it work
for me at the moment. Pleas tell me, if i can help.

I think it is better not to let switch the rfkill
on button in the driver itself.
It is more flexible when button send only event and
userspace-tool handle it. Userspace-tool  can
choose the right rfkill (or may be multiple rfkills)
(it can be runned, after wlan-driver was loaded).
As i can see, other platform-drivers provide
only rfkill device and do not bind it to
keys.

Regards,
Andrej

Corentin Chary writes:

> Hi,
> Making hotplug optional won't fix the problem,
> because this mean you need to ship a specific module for each Eeepc.
> 
> We need a more generic solution, and we need to implement a driver for
> the new wmi interface.
> I'll start to work on that as soon as I can get the hardware...
> Thanks,
> 
> 
> -- 
> Corentin Chary
> http://xf.iksaif.net

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
