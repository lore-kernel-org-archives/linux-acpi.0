From: Elliott Martin <johnelliottmartin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: help troubleshooting
Date: Wed, 7 Sep 2005 11:01:26 -0700
Message-ID: <200509071101.27211.johnelliottmartin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hello,

I just upgraded to the 2.6.13 kernel and I am now seeing new ACPI errors 
during boot up and I was wondering if I could get some help. I have fixed 
every problem with my DSDT so far, but this is a little more difficult.

My question is, how do I find out exactly what is failing from these messages:


    ACPI-0423: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1172: *** Error: Method execution failed [\_SB_.PCI0.SBRG.EC0_.RWRD] 
(Node ddfba4e0), AE_TIME
    ACPI-1172: *** Error: Method execution failed [\_SB_.PCI0.BAT0.BIF1] (Node 
ddfba1a0), AE_TIME
    ACPI-1172: *** Error: Method execution failed [\_SB_.PCI0.BAT0._BIF] (Node 
ddfba320), AE_TIME


I have looked through the code, and I think the BIF1 and _BIF methods fail 
because they call the RWRD method, so if I fix that I should be alright, but 
I don't know what in the RWRD method is bad. Can I use that node information 
from above to find out where in the DSDT the problem is occuring?

-Elliott


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
