From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [UPDATE PATCH] acpi/video: check brightness is non-NULL before writing
Date: Thu, 17 Nov 2005 14:30:16 +0800
Message-ID: <200511171430.16431.luming.yu@intel.com>
References: <20050912184401.GC25471@us.ibm.com> <20051116204339.GK3122@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051116204339.GK3122-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
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
Cc: Nishanth Aravamudan <nacc-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thursday 17 November 2005 04:43, Nishanth Aravamudan wrote:
>
> Signed-off-by: Nishanth Aravamudan <nacc-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
>
> ---
>
>  drivers/acpi/video.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> diff -urpN 2.6.15-rc1/drivers/acpi/video.c
> 2.6.15-rc1-dev/drivers/acpi/video.c ---
> 2.6.15-rc1/drivers/acpi/video.c	2005-11-11 20:32:50.000000000 -0800 +++
> 2.6.15-rc1-dev/drivers/acpi/video.c	2005-11-16 12:40:42.000000000 -0800 @@
> -812,7 +812,7 @@ acpi_video_device_write_brightness(struc
>
>  	ACPI_FUNCTION_TRACE("acpi_video_device_write_brightness");
>
> -	if (!dev || count + 1 > sizeof str)
> +	if (!dev || !dev->brightness || count + 1 > sizeof str)
>  		return_VALUE(-EINVAL);
>
>  	if (copy_from_user(str, buffer, count))

Is it this http://bugzilla.kernel.org/show_bug.cgi?id=5571?


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
