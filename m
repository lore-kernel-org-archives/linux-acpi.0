From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: IDE failure on ACPI resume
Date: Sun, 13 Mar 2005 19:14:01 +0000
Message-ID: <1110741241.8136.46.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On resume, an HP nc6220 fails during resuming of the IDE devices. In
this section of code from ide-iops.c:

                stat = hwif->INB(hwif->io_ports[IDE_STATUS_OFFSET]);
                if ((stat & BUSY_STAT) == 0)
                        return 0;
                /*
                 * Assume a value of 0xff means nothing is connected to
                 * the interface and it doesn't implement the pull-down
                 * resistor on D7.
                 */
                if (stat == 0xff)
                        return -ENODEV;

0xff is read and ENODEV returned. This results in

hda: bus not ready on wakeup
hda: drive not ready on wakeup

and then the machine sits there until some later command times out. It
seems that reading anything off the IDE bus just results in 0xff being
read.

The IDE controller is an Intel ICH6. Another HP laptop with an identical
chipset works fine, which makes me suspicious of the BIOS. Is the fact
that Linux doesn't seem to run the GTF, STM or GTM methods likely to be
relevant here?

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
