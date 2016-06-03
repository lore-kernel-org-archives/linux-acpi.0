From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] ACPI:video: skip evaluating _DOD when it does not exist
Date: Fri, 3 Jun 2016 14:04:03 +0800
Message-ID: <20160603060401.GA8618@aaronlu.sh.intel.com>
References: <1464335226-11212-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:47495 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbcFCGEH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Jun 2016 02:04:07 -0400
Content-Disposition: inline
In-Reply-To: <1464335226-11212-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: rui.zhang@intel.com, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org

On Fri, May 27, 2016 at 03:47:06PM +0800, Alex Hung wrote:
> Some system supports hybrid graphics and its discrete VGA
> does not have any connectors and therefore has no _DOD method.
> 
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  drivers/acpi/acpi_video.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 5fdac39..549cdbe 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1211,6 +1211,9 @@ static int acpi_video_device_enumerate(struct acpi_video_bus *video)
>  	union acpi_object *dod = NULL;
>  	union acpi_object *obj;
>  
> +	if (!video->cap._DOD)
> +		return AE_NOT_EXIST;
> +
>  	status = acpi_evaluate_object(video->device->handle, "_DOD", NULL, &buffer);
>  	if (!ACPI_SUCCESS(status)) {
>  		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _DOD"));

Is the patch supposed to avoid the above error message?
I'm OK with the patch though, it's just not clear to me the point since
the acpi_evaluate_object should probably also return AE_NOT_EXIST.

Thanks,
Aaron
