From: "Peter T. Breuer" <ptb-lKqjX1hQmNLe5aOfsHch1g@public.gmane.org>
Subject: acpi driver blacklist override linux 2.4.18
Date: Thu, 25 Jul 2002 20:33:56 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207251833.UAA03087@betty.it.uc3m.es>
Reply-To: ptb-lKqjX1hQmNLe5aOfsHch1g@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dwmw2-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "Peter T. Breuer" <ptb-e7OjjGEhTcdpPtxwXY8Srg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Good evening

I just got around to trying the acpi driver on my Toshiba Portege 4000
(well, why would I use acpi when I want to use hibernation normally?)
and the acpi blacklists me for being a Toshiba Portege 7020!

Well, I had a 7020 before, and I can understand its feelings.

But the Portege 4000 is near totally different. I get the feeling
that the id comparison is funky. Maybe it shouldn't be a less than,
or something?? I suggest the test be modified. I overrode it with the
following setup args modif in driver.c:

+ static int blacklist_disabled = 0;
  static int __init acpi_setup(char *str) {
        while (str && *str) {
        if (strncmp(str, "off", 3) == 0)
                acpi_disabled = 1;
+       else if (strncmp(str, "nobl", 3) == 0)
+               blacklist_disabled = 1;
        str = strchr(str, ',');
        if (str)
                str += strspn(str, ", \t");
        }
        return 1;
  }


...

        if (acpi_blacklisted(&acpi_fadt)) {
                printk(KERN_ERR "ACPI: On blacklist -- BIOS not fully ACPI compliant\n");
+               if (blacklist_disabled) {
+                       printk(KERN_ERR "ACPI: but blacklist disabled -- continuing\n");
+               } else {
                        acpi_terminate();
                        return -ENODEV;
+               }
        }



and the thing that caused the damage was this table entry:

        {"TOSHIB", "750     ", 0x970814, less_than_or_equal}, /* Portege 7020, BIOS 8.10 */




Pertinent data:


  Jul 25 13:36:23 betty kernel: ACPI Namespace successfully loaded at root c0320d80
  Jul 25 13:36:23 betty kernel: ACPI: On blacklist -- BIOS not fully ACPI compliant

With the blacklist check disabled everything seems to work just as well
as it ought to:

  betty:/usr/src/linux-2.4.17rc2-xfs/drivers/acpi% cat /proc/acpi/info 
  ACPI-CA Version:         20011018
  Sx States Supported:     S0 S3 S4 S5 

  betty:/usr/src/linux-2.4.17rc2-xfs/drivers/acpi% cat /proc/acpi/processor/0/status 
  Bus Mastering Activity:  fdffffdf
  C-State Utilization:     C1[7220] C2[3059127] C3[0]

  betty:/usr/src/linux-2.4.17rc2-xfs/drivers/acpi% cat
  /proc/acpi/battery/1/info 
  Present:                 yes
  Design Capacity:         3600 mAh
  Last Full Capacity:      3475 mAh
  Battery Technology:      secondary (rechargeable)
  Design Voltage:          10800 mV
  Design Capacity Warning: 70 mAh
  Design Capacity Low:     0 mAh
  Capacity Granularity 1:  1 mAh
  Capacity Granularity 2:  1 mAh
  Model Number:            XM2038P04   
  Serial Number:           1000010166
  Battery Type:            Li-ION  
  OEM Info:                


etc. When the apm module was in, I had the bios info visible, but of
course I can't see it right  now ... here's a couple of useless bootup
messages

  Jul 25 14:09:51 betty apmd[321]: Version 3.0final (APM BIOS 1.2, Linux driver 1.15)
  Jul 25 14:09:52 betty apmd[321]: Battery: * * * (100% 3:01)



Where is the latest and greatest kernel acpi driver, btw? There's
nothing obvious at intel or sourceforge that I can see.

Peter


---------------------------------------------------------------------
Peter T. Breuer                   MA CASM PhD (Ing.), Prof. Asoc.
Area de Ingenieria Telematica	  E-mail: ptb-lKqjX1hQmNLe5aOfsHch1g@public.gmane.org
Dpto. Ingenieria		  Tel: +34 (9)1 624 87 81
Universidad Carlos III de Madrid  Fax: +34 (9)1 624 8749/9430
Butarque 15, Leganes/Madrid       URL: http://www.it.uc3m.es/~ptb
E-28911 Spain                     Mob: +34 69 666 7835


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
