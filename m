From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Decrement method
Date: Mon, 18 Nov 2002 10:54:00 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B914@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'Irene Zubarev' <zubarev-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It's a bug, we will fix for the next release.
Bob


-----Original Message-----
From: Irene Zubarev [mailto:zubarev-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org] 
Sent: Monday, November 18, 2002 10:48 AM
To: Moore, Robert
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: RE: [ACPI] Decrement method

Hi,

Arg0 contains integer, it's the slot # passed to method.

Thanks,

Irene Zubarev



 

                      "Moore, Robert"

                      <robert.moore@int        To:       Irene
Zubarev/Raleigh/IBM@IBMUS, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org             
                      el.com>                  cc:

                                               Subject:  RE: [ACPI]
Decrement method                                                   
                      11/18/2002 01:44

                      PM

 

 




What is in Arg0?


-----Original Message-----
From: Irene Zubarev [mailto:zubarev-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org]
Sent: Monday, November 18, 2002 8:30 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] Decrement method

Hello, I am using Nov. 1st ACPI driver.  I found something strange, if ASL
has the following:

      Store( Arg0, Local0 )
      Decrement( Local0 )

The result is that _both_ Local0 and Arg0 get decremented.  Has anyone seen
this before?  Is this expected behaviour?  I am very new to ACPI, I'd
appreciate any help on how to fix this.

Thanks,

Irene Zubarev




-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
