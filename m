From: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: [RFC/patch] ACPI in linux PnP layer
Date: Wed, 8 Sep 2004 23:26:47 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409082326.50984.dtor_core@ameritech.net>
References: <1094641221.413ee645d2cb6@imp1-q.free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1094641221.413ee645d2cb6-/A4Sof3AOA+ksujEA26zIQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: castet.matthieu-GANU6spQydw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 08 September 2004 06:00 am, castet.matthieu-GANU6spQydw@public.gmane.org wrote:
> Any comment ?
> 

> +	spin_lock(&acpi_device_lock);
> +	list_for_each_safe(node, next, &acpi_device_list) {
> +		struct acpi_device * dev = container_of(node, struct acpi_device, g_list);
> +		spin_unlock(&acpi_device_lock);
> +		handler(dev);
> +		spin_lock(&acpi_device_lock);
> +	}
> +	spin_unlock(&acpi_device_lock);
> 

What exactly that does spinlock do? Note that list_for_each_safe is only
"safe" in sense that the current element can be deleted from the list
_by the same thread_ that is doing iteration. That is it. If some other
thread accesses the same list it is not safe at all and that spinlock is
next to useless because it is dropped in the middle of the loop. The whole
construct should be protected by a semaphore, acpi_subsys.rewsem is a good
candidate (I hope Len will eventually  apply my patch to the scan.c that
does just that).

-- 
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
