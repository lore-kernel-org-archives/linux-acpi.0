From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: 2.6.15-mm2
Date: Sun, 8 Jan 2006 13:18:29 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005A134FE@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Brice Goglin <Brice.Goglin-vYW+cPY1g1pg9hUCZPvPmw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

 
>> 2.6.15 and 2.6.15-git3 both don't show any of these issues. 
>> Did acpi and cpufreq get merged after -git3 ?
>> 
>
>Well whatever bug it is, it's in Linus's tree now.  Happens for me too.
>
>I traced the failure down as far as acpi_processor_get_performance_info(),
>where it's failing here:
>
>	status = acpi_get_handle(pr->handle, "_PCT", &handle);
>	if (ACPI_FAILURE(status)) {
>		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>				  "ACPI-based processor 
>performance control unavailable\n"));
>		return_VALUE(-ENODEV);
>	}

No, acpi was not merged after 2.6.15 -- see if cpufreq changed.

-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
