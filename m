From: Dmitrij Bogush <dmitrij.bogush-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Touchpad problem on 15XX Acer Aspire laptops.
Date: Wed, 3 Aug 2005 05:12:35 +0400
Message-ID: <2ac89c700508021812208f23d6@mail.gmail.com>
Reply-To: Dmitrij Bogush <dmitrij.bogush-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi.

Someone Dmitry Torokhov on LKML told me to contact ACPI mailing list
with this problem.
=20
Touchpad goes crazy then programs like Kpowersave or Gkrellm check
battery state or current cpu frequency.

 With 2.6.11.4 in dmesg I see this:

psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
=20
With latest 2.6.13-rc5 kernel I get this:
=20
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip handler_IRQ_event+0x20/0x60
=20
With 2.6.13-rc5 touchpad freezes for a second, do not goese crazy like
with 2.6.11.

Thanks.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
