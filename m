From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] fix an issue around kobject_hotplug() in processor.c and container.c
Date: Thu, 25 Nov 2004 10:15:48 -0800
Message-ID: <20041125181548.GB30760@kroah.com>
References: <20041125230257.56917529.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041125230257.56917529.tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 25, 2004 at 11:02:57PM +0900, Keiichiro Tokunaga wrote:
> +	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
> +				"DRV_NAME=%s", dev->driver->name))

That should be PHYSDEVDRIVER not DRV_NAME to be consistant with the rest
of the driver core.

thanks,

greg k-h


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
