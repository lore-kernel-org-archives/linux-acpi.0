From: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Subject: drivers/acpi/video.c: null pointer dereference
Date: Thu, 24 Mar 2005 21:37:44 +0100
Message-ID: <20050324203744.GB3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The Coverity checker found the following null pointer dereference in 
drivers/acpi/video.c:

<--  snip  -->

...
static int
acpi_video_switch_output(
...
{
...
        struct acpi_video_device *dev=NULL;
...
        list_for_each_safe(node, next, &video->video_device_list) {
                struct acpi_video_device * dev = container_of(node, struct acpi_video_device, entry);
...
        }
...
        switch (event) {
        case ACPI_VIDEO_NOTIFY_CYCLE:
        case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:
                acpi_video_device_set_state(dev, 0);
                acpi_video_device_set_state(dev_next, 0x80000001);
                break;
        case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:
                acpi_video_device_set_state(dev, 0);
                acpi_video_device_set_state(dev_prev, 0x80000001);
...

<--  snip  -->


Two different variables of the same name within 40 lines of code are a 
good indication that something's wrong...


The outer "dev" variable is never assigned any value different from 
NULL.

acpi_video_device_set_state dereferences this variable.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
