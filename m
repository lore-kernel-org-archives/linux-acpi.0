From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: C2 or C3 on Presario 2110US?
Date: Thu, 13 Mar 2003 17:34:01 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96D05@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Carl Thompson <cet-GxmFRYwVNOxKOnpN5g9PlQ@public.gmane.org>, "Breathnach, Proinnsias (Dublin)" <breatpro-Lp/cVzEoVybn/p8AFm7ortBPR1lH4CV8@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Carl Thompson [mailto:cet-GxmFRYwVNOxKOnpN5g9PlQ@public.gmane.org] 
> Is it possible this machine just doesn't do C2-C3, processor limit
> control or processor performance control?  If that is the 
> case, then why
> does Windows seem to be running cooler?  The fan is often off 
> in Windows
> but never off in Linux.  Also battery life seems to be better 
> in Windows
> whereas on my other laptops it's better in Linux.  And yes, I am using
> CPUFreq's PowerNow support to throttle down the CPU speed and 
> voltage to
> the minimum.

Does the system feel slow, or are there an abnormal number of interrupts
shown in /proc/interrupts?

Also, the latest code required that the Processor P_BLK have a length of
0 or 6, without exception.

Finally, C2 and C3 statistics should be exposed through perfmon under
Windows. You might try finding that information, and seeing if indeed it
is using C2 or C3.

> Does anyone know of any tools to display the exact CPU speed, voltage
> and temperature under Windows so I can see exactly what it's 
> doing?  The
> PowerNow dashboard from AMD just gives a (simulated) analog 
> guage which
> does not give accurate measurements.

Wcpuid by H. Oda? I know it shows speed, but I don't have a PowerNow CPU
to test the other part. :)

Regards -- Andy



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
