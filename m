From: "Shawn P. Garbett" <listman-qZIqNUI/gJRAfugRpC6u6w@public.gmane.org>
Subject: 2.5.64 kernel bug
Date: Fri, 7 Mar 2003 11:49:33 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303071149.33553.listman@garbett.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I just got a P2120 laptop and really really want ACPI working. I grabbed the 
2.5.64 kernel and it didn't compile. Looking back through the archives of 
this list I found nothing related to this. 

I'm a proficient programmer, but have never done any serious kernel work under 
linux. 

Here's what I changed to make it compile: 

sputnik:/usr/src/linux# diff drivers/cpufreq/userspace.c.orig 
drivers/cpufreq/userspace.c
514c514
<               device_create_file (policy->intf.dev, 
&dev_attr_scaling_setspeed );
---
>               device_create_file (policy->dev, &dev_attr_scaling_setspeed);
523c523
<               device_remove_file (policy->intf.dev, 
&dev_attr_scaling_setspeed
);
---
>               device_remove_file (policy->dev, &dev_attr_scaling_setspeed);



Shawn


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
