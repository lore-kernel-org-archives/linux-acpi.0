From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: current ACPI status in 2.6.7 kernel
Date: 11 Aug 2004 23:48:16 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092282496.7765.148.camel@dhcppc4>
References: <411881B1.9000903@ti.com>
	 <1092132146.2666.3.camel@laptop.cunninghams> <4118D40D.5030404@ti.com>
	 <4118F918.7070909@optonline.net>  <411A2EA9.6000000@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <411A2EA9.6000000-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nathan Bryant <nbryant-p32f3XyCuykqcZcGjlUOXw@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Alexander Sirotkin <demiurg-l0cyMroinI0@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Alexander,
The status of ACPI S3 suspend/resume in 2.6.7 is...

Run the latest ACPI patch on top of 2.6.7
(indeed, you still need the latest patch for 2.6.8)

build EHCI as a module, and unload it first

echo 3 >/proc/acpi/sleep

(yes, it is on the list to move to sysfs...)

some systems get a double event if wakeup with power button.
I use the LID to wake up my system and that works fine.

many systems come back up from S3, but don't re-enable
the LCD, or some re-enable it, but in the wrong mode.
Sometimes you can wake it up by running X.
Sometiems you can wake it up by switching
virtual consoles.
There is a lot of experimentation in this area, but
we don't really have fixes for this yet that are
universally positive -- ie fix platforms w/o breaking others.

in summary, YMMV;-)

cheers,
-Len




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
