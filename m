From: Brouard Nicolas <nicolas.brouard-TDf4sKD1mxeHlu7OokbhRg@public.gmane.org>
Subject: Sony Vaio ACPI S4 suspend resumes instead of power off
Date: Thu, 04 Nov 2004 19:32:19 +0100
Message-ID: <1099593139.6265.17.camel@pichat>
Mime-Version: 1.0
Content-Type: text/plain
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

I have been using echo 4>/proc/acpi/sleep on kernel 2.6.8.1 successfully
since some time now on my Sony Z1. 

The sonypi module has been patched recently (Dmitry Torokhov) and
Stelian Pop) in order to suspend/resume correctly. I have been able to
patch a kernel 2.6.8.1 with these patches (need kfifo and
roundup_pow_of_two patches from 2.6.10). 

And suspending/resuming works well but it doesn't halt in between! It is
only cycling.

In fact I discovered that the reason is elsewhere. Just at the same time
I upgraded my system (Mandrake cooker uptodated 10.1) by using the 6 CD
of the Mandrake 10.1 Official distribution. The upgrade was very quick
because all of my rpms were already updated, but the upgrade added new
services (Bluetooth) and modules and even other configuration which I
don't know.

I had a list of former modules and removed the new modules (or
daemon/services) added by the upgrade. But I am STILL cycling and don't
know what to do.

With all of my tests or official kernel I am recycling.

Is there a parameter in /proc/acpi/??? which makes the cycling.

Any hint will be appreciated.

Nicolas Brouard

-- 
Brouard Nicolas <nicolas.brouard-TDf4sKD1mxeHlu7OokbhRg@public.gmane.org>



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
