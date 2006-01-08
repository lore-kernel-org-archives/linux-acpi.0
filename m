From: Brice Goglin <Brice.Goglin-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Subject: Re: 2.6.15-mm2
Date: Sun, 08 Jan 2006 09:39:00 -0500
Message-ID: <43C12404.1010306@ens-lyon.org>
References: <20060107052221.61d0b600.akpm@osdl.org>	<43C0172E.7040607@ens-lyon.org>	<20060107145800.113d7de5.akpm@osdl.org>	<43C050FA.9040400@ens-lyon.org> <20060108042425.4d0b8a76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060108042425.4d0b8a76.akpm-3NddpPZAyC0@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Andrew Morton wrote:

>Well whatever bug it is, it's in Linus's tree now.  Happens for me too.
>
>  
>
Happens for you in -git4 ? Does not here...

Brice



>I traced the failure down as far as acpi_processor_get_performance_info(),
>where it's failing here:
>
>	status = acpi_get_handle(pr->handle, "_PCT", &handle);
>	if (ACPI_FAILURE(status)) {
>		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>				  "ACPI-based processor performance control unavailable\n"));
>		return_VALUE(-ENODEV);
>	}
>
>
>  
>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
