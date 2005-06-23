From: Andrey Kislyuk <kislyuk-TVLZxgkOlNX2fBVCVOL8/A@public.gmane.org>
Subject: Problems with lcd/dvi switching with ibm-acpi
Date: Thu, 23 Jun 2005 10:34:21 -0700
Message-ID: <42BAF29D.4060604@berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hello,

I'm having problems switching between my LCD and minidock throughput DVI 
on an IBM Thinkpad T40 using ibm-acpi. DVI always shows up as disabled, 
and commands like "echo dvi_enable > /proc/acpi/ibm/video" are always 
ignored (as opposed to commands for switching between LCD and analog 
HD15). The system does boot fine using DVI if DVI was the active display 
device at boot, but then it can't switch to LCD.

This is observed on kernel 2.6.11 and 12 and all recent verisons of 
ibm-acpi. I'm sure this isn't anything related to X since it doesn't 
work when booting into a rescue CD console, either.

Any suggestions?

Thanks,
-ak


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
