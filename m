From: Petros Kolyvas <pkolyvas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Unknown "mem" state issue
Date: Wed, 26 Oct 2005 22:52:44 -0400
Message-ID: <BAYC1-PASMTP04C919DC8A9A856B255912D6680@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Message-ID: <436040FC.5040008@gmail.com>
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

Hi!

I can't seem to send my system into the "mem" state. I've recently
switched from FC4 to Gentoo. My kernel is 2.6.13-r3 with some custom
patches - including the new ieee802.11 subsystem (ieee80211.sf.net) for
the linux ipw2200 drivers (ipw2200.sf.net) patched directly into the
kernel (which may very well be part of the problem) - but I was unable
to suspend to memory before such patching occurred. acpid is 1.0.4-r2
and I did compile the acpi kernel options, including the userspace
governor for my cpu into the kernel and I am using powernowd to to
manage my CPUs frequency settings.

Basically my tried and true acpi sleep state script hasn't been working
and even when I manually 'echo "mem" > /sys/power/state' the system
doesn't respond at all.

I'm not sure where to start or what I'm doing wrong.

Thanks for your time and consideration.

Petros


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
