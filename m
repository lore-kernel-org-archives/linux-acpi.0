From: Tom <gmane.20.thinkinginbinary-w1QkCcy0X+Ct7aBEGUsviw@public.gmane.org>
Subject: Enhanced SpeedStep on Asus M2400Ne with Pentium-M Dothan
Date: Sun, 5 Sep 2004 23:26:16 +0000 (UTC)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <loom.20040906T011917-422@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I recently bought an Asus M2400Ne laptop.  It is a Centrino, and it has the
newer generation of the Pentium-M processor, Dothan.  Dubiously, Asus advertises
a Power4Gear power management function on it, which I assumed only is a utility
to change Windows power management schemes.  I'm instead running Gentoo Linux on
it, specifically kernel 2.6.8.1, unpatched except for a small patch to
speedstep-centrino.c to make it recognize the new Dothans.

I am having absolutely no success getting Intel Enhanced SpeedStep to work on
this notebook.  Using either kernel module, acpi (ACPI Processor P-States
driver) or speedstep-centrino (Intel Enhanced SpeedStep driver), I get a "No
such device" error.  In dmesg, speedstep-centrino tells me to contact the
maintainer (I did, and he said it's something with my laptop--it is looking for
a freq./voltage table for my processor when there should be one in the BIOS),
and acpi is silent.

I have talked with a few people about this, and I'm still stuck.  Someone said
that (by looking at my DSDT) Asus renamed some methods in the DSDT (probably to
make their "proprietary" power management technology require special drivers) by
one letter (from "_***" to "A***"), but I have no further ideas on how to
proceed.  I wouldn't mind either making a custom DSDT (but I wouldn't know what
names to change) or editing some files in my copy of the kernel to make it call
the "A***" methods instead (same problem), but I'm really stuck.

Any help that anyone could offer would be greatly appreciated.

Thanks,

Tom



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
