From: Spam Guard <spamguard-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: Support for "standby" in ACPI4Linux
Date: Thu, 17 Nov 2005 00:10:58 -0600
Message-ID: <437C1EF2.1090806@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi,

I'm have a Thinkpad T42, and on it I'm running a kernel compiled from 
the Debian "linux-source-2.6.14" package, which is basically the latest 
2.6.14.2 kernel with Debian some patches (security, stability, etc.).  
As I understand it, a pretty recent ACPI4Linux version should be 
included in this kernel by default.  Also, I've patched this kernel with 
Suspend2 (www.suspend2.net), in case that's of consequence. 

ACPI "sleeping" to memory works pretty well on my computer, but I was 
wondering about the "standby" mode.  My /sys/power/state reports that 
it's capable of both "mem" and "standby," but "mem" is the only option 
that seems to work.  With "standby" all I get is a message that reads 
"acpi_pm_prepare does not support 1" on virtual terminal 63. 

Is there still enough demand to continue development of this feature, or 
has it kind of fallen off the map because users get enough functionality 
out of sleeping to memory?  Or should standby be functioning now?  Is 
there possibly something wrong with my configuration?

Thanks for your help,
Sukant Hajra



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
