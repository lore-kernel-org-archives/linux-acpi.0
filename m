From: Thomas Eschenbacher <Thomas.Eschenbacher-Mmb7MZpHnFY@public.gmane.org>
Subject: freqency scaling on compaq nx9010
Date: Sun, 09 Jan 2005 19:47:09 -0300
Message-ID: <41E1B46D.1070107@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

I have a compaq nx9010 laptop, running on kernel 2.4.9-gentoo-r13, with 
ACPI enabled and speedstep for frequency scaling. Speedstep itself works 
rather fine, but I wonder about the available scaling frequencies:

cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
gives only "668000 692000" ?

...and this is also what speedstep does - it switches between these two 
frequencies, 96% and 100% speed. Isn't this absolutely nonsense? Only 4% 
speed difference !?

I now have fixed the bios' DSDT and built my own one in the kernel - no 
change. Furthermore I cannot find the numbers 668000, 692000, 668 and 
692, neither in decimal, nor in hex in the decompiled dsdt.

On the other hand my dsdt contains two entries in the _PSS section, one 
for 3059MHz (100%) and one for 1596MHz (~50%) - but those two 
frequencies appear nowhere in /proc or /sys/devices/... !?

what goes wrong here ?

Is speedstep independend from ACPI ?

Thomas



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
