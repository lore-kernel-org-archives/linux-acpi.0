From: KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: Re: [Lhms-devel] [PATCH 1/1]  patch to fix acpi_memhotplug.c
Date: Thu, 17 Nov 2005 15:08:44 +0900
Message-ID: <437C1E6C.6000404@jp.fujitsu.com>
References: <1131771825.20603.44.camel@knk> <1132033003.3798.21.camel@knk>	 <20051115171221.7E99.Y-GOTO@jp.fujitsu.com> <1132201107.3798.81.camel@knk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1132201107.3798.81.camel@knk>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: keith <kmannth-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, external hotplug mem list <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

keith wrote:
 >
 > My add event is called with my patch.  The notify event is triggering
 > and falling into the right path.
 >
 > I tried your patch but my device is not making and add event.  I really
 > looks to just be a notify with the memory range attached.  I really
 > think my patch is the right way to go for my hardware.
 >
 >
Could you show your AML tree around Memory ?
I'm interested in.

  	if (!(*mem_device)) {
-		printk(KERN_ERR "\n driver data not found");
-		return_VALUE(-ENODEV);
+		/* Try and get the memory_device from the current handle */
+		result = acpi_memory_get_current_resource(handle,mem_device);
+		if (result) {
+			printk(KERN_ERR "\nThere is no data for this memory device\n");
+			return_VALUE(-EINVAL);
+		}
  	}
I'm not sure why this is *right* way.

This is traditinal way to attach driver data to device.
==
acpi_bus_add() ->
	acpi_add_single_object() ->  ----------------(*) acpi_device is create here.
		acpi_bus_find_driver()->
			acpi_bus_driver_init()->
				driver->ops.add()
==

Maybe driver->ops.add is not called for some reason.
What happens in acpi_add_single_object() in your environment ?
acpi_bus_find_driver() is called ?

-- Kame




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
