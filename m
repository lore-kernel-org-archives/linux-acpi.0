From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: S3 freezes on wake on NC6000 laptop
Date: Mon, 07 Feb 2005 18:42:58 +0100
Message-ID: <4207A8A2.1040202@gmx.net>
References: <4207A416.8030400@colitti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <4207A416.8030400-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Lorenzo Colitti schrieb:
> Hi,
> 
> I am trying to get S3 (suspend to RAM) to work on an HP NC6000 laptop
> with no success. The system seems to enter the S3 state correctly, but
> when I turn back on it freezes completely.
> 
> I tried booting with no modules and no processes loaded (init=/bin/sh)
> and with a serial console, but I can't see anything helpful. What I see
> is this:
> 
>> kjournald starting.  Commit interval 5 seconds
>> sh-3.00# mount -t proc proc /proc
>> sh-3.00# mount -t sysfs sys /sys
>> sh-3.00# echo C057 > /proc/acpi/wakeup
>> sh-3.00# cat /proc/acpi/wakeup
>> Device  Sleep state     Status
>> C057       5             enabled
>> sh-3.00# echo mem > /sys/power/state
>> radeonfb (0000:01:00.0): suspending to state: 2...

Ah, radeonfb. Please don't use radeonfb if you want to have any chance in
resuming. Don't use any framebuffer on systems with radeon cards. It will
freeze your machine completely. Actually, any graphics activity (framebuffer
or X or svga access) will freeze it.

Without framebuffer, your machine will come back from sleep, but you won't
get any video. We're currently busy to write code which will help radeon
users (I'm one of them).

>> PM: Entering state.
>>  hwsleep-0307 [04] acpi_enter_sleep_state: Entering sleep state [S3]
> 
> 
> After that, it seems that the system goes to sleep. There is nothing on
> the screen, the HD stops, and the power light starts blinking.
> 
> However, when I turn the machine back on it freezes completely. The HD
> starts, the power light comes on, but the serial console is
> unresponsive, the keyboard doesn't seem to work, and it won't turn off
> again, even if I hold the power button for 5 seconds.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
