From: Hiroshi 2 Itoh <HIROIT-JE5g2YyFxFHQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] GDT table patch for resume only reboots problem
Date: Sat, 23 Oct 2004 21:05:47 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OF38C223A3.5509B742-ON49256F36.00412958-49256F36.0041FAA1@jp.ibm.com>
References: <1098530036.3996.18.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1098530036.3996.18.camel@tyrosine>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org





>
> Further digging - the machine claims that the FACS revision is 0, the
> table length is 64 and that xfirmware_waking_vector is set to 0, As a
> result of the first and last of these things, firmware_waking_vector is
> used instead of xfirmware_waking_vector. This shouldn't be an issue,
> right?
> --

Yes, nothing is bad. Try to write the value in both etc...

- Hiro.



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
