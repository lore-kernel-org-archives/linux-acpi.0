From: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: PCI power state mapping
Date: Thu, 29 Jul 2004 12:47:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4108D5BC.8040302@drzeus.cx>
References: <B44D37711ED29844BEA67908EAF36F036BCB8C@pdsmsx401.ccr.corp.intel.com> <41069C59.5020603@drzeus.cx> <20040729084154.GH21889@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------060700050204040107040905"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040729084154.GH21889-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060700050204040107040905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:

>Hi!
>
>  
>
>>Anyhow, I did some hacks into pci_device_suspend() getting it to 
>>suspend devices without a driver. Combined with my escalation patch 
>>in pci_set_power_state() all devices on the machine now enters D2 or 
>>D3 depending on device capabilities. My laptop still cannot enter the 
>>suspend state so there is still something missing... Are there any 
>>more areas of power management in linux that aren't quite up to spec.?
>>    
>>
>
>You forgot to say if you are trying to suspend to ram or to disk.
>				Pavel
>  
>
RAM. It was in the beginning of the thread...

Rgds
Pierre

--------------060700050204040107040905
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Pavel Machek wrote:
<blockquote cite="mid20040729084154.GH21889-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org"
 type="cite">
  <pre wrap="">Hi!

  </pre>
  <blockquote type="cite">
    <pre wrap="">Anyhow, I did some hacks into pci_device_suspend() getting it to 
suspend devices without a driver. Combined with my escalation patch 
in pci_set_power_state() all devices on the machine now enters D2 or 
D3 depending on device capabilities. My laptop still cannot enter the 
suspend state so there is still something missing... Are there any 
more areas of power management in linux that aren't quite up to spec.?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
You forgot to say if you are trying to suspend to ram or to disk.
				Pavel
  </pre>
</blockquote>
RAM. It was in the beginning of the thread...<br>
<br>
Rgds<br>
Pierre<br>
</body>
</html>

--------------060700050204040107040905--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
