From: Radoslaw Chyra <chyras-foVc9aoM7mKFAqYqPk0RtA@public.gmane.org>
Subject: Re: Acer Extensa 3002 WLMi: DSDT fixed but system misses keyboard and mouse events
Date: Thu, 27 Oct 2005 05:34:18 +0000 (UTC)
Message-ID: <loom.20051027T072257-534@post.gmane.org>
References: <435D43BB.2080702@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  
Hello!  
  
I can confirm the same problems (missing mouse events, and also bad keyboard  
behaviour, ie missing keystrokes and multiplying keys with single press when  
typing even not-so-fast).  
  
I fixed DSDT and patched it with acer-tm4xxx-sbs-cm.diff from the sbs-linux  
project. I have the same warnings from iasl (20050930) as Berthold Cogel. 
 
I have DSTD compiled right into kernel, and boot it with ec_burst=1. 
 
Kernel:  
 
linux-2.6.14-rc5-git6, suspend2 
 
(I've tried also 2.6.14-rc3, 2.6.13.1 witch ec_burst patch) 
 
Hardware:  
   
Acer TravelMate 4001 LMi  
ATI Mobility Radeon 9600  
Intel 802.11 b/g Wlan 
 
Regards 
 
Radoslaw 
  



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
