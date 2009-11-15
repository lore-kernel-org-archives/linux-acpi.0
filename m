From: andrej.gelenberg-KJIyc1CJxjQ@public.gmane.org
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 12:53:11 +0100
Message-ID: <cone.1258285991.924736.2588.1000@eeekiste>
References: <cone.1258203372.445001.1633.1000@eeekiste>
	<71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com>
	<cone.1258211472.464906.1633.1000@eeekiste>
	<71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com>
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

Corentin Chary writes:

> Matthew, you added hotplug in commit  5740294ca3a9b113fe146f2826effb69ca50008d,
> it was needed for 701/900/901. Do you know if it's still needed for 1005ha ?

Is it not better to use rfkill-switch provided from wlan-driver when? At 
least Atheros drivers support rfkill propertly. You can make it LED for that 
eeepcs and set the default trigger to rfkill. I have tried to make it so, 
but on 1005ha it is a proper rfkill.

I have tried to make the devicesearch for hotplug propertly, but it cause
the system freeze. (http://bugzilla.kernel.org/show_bug.cgi?id=14570#c1)

Regards,
Andrej Gelenberg

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
