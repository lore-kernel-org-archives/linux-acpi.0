From: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: suspend-to-ram hangs on HP NX7010
Date: Wed, 09 Jun 2004 14:06:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40C6FD44.7090606@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

I've been spending a few days trying to get suspend-to-ram to work on my 
new HP NX7010 laptop. Haven't had much success though so I thought I 
might get some help from the more experienced.

I'm running FC2 with linux 2.6.6. S3 has been tested using vanilla 
kernel and with the patch from acpi.sf.net. I've also included a patch 
from the ACPI bugzilla to be able to control which devices can wake the 
unit. The behaviour has been the same for all tests.

I don't think the unit actually gets all the way into S3 though. If I 
turn on ACPI debug in the kernel I can see a debug message that says 
'Entering S3' but the laptop doesn't power down anything. After this 
point the only way to get control of the machine again is to hold down 
the power button for a couple of seconds, bypassing the OS. Also, for 
some strange reason I have to do this twice because the machine hangs 
during POST after the first reset (after a failed suspend-to-ram that 
is, works fine otherwise).

I've started looking in the ACPI spec. since I suspect the bug might be 
in the DSDT. I doesn't even compile cleanly with Intel's compiler as it 
is. ACPI is new to me however so I could use some pointers on where I 
should start looking. I'm also fluent in C so I intend to have a look at 
the kernel code and insert some debug statements. Might help me pinpoint 
where it hangs.

I'd appreciate any help I can get. Just tell me what information you 
need and what I should test and I'll gladly do it. Suspend-to-ram is a 
badly needed function so I'm ready to devote whatever time is required 
to get this fixed.

Regards
Pierre Ossman


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
