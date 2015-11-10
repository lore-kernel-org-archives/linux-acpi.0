From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 2/4] nvdimm: Add IOCTL pass thru
Date: Tue, 10 Nov 2015 13:05:20 -0500
Message-ID: <x494mgtlogv.fsf@segfault.boston.devel.redhat.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
	<cover.1446684001.git.jerry.hoemann@hpe.com>
	<4f81a8b6fa24723c808c72888290e2368fcdbca0.1446684001.git.jerry.hoemann@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4f81a8b6fa24723c808c72888290e2368fcdbca0.1446684001.git.jerry.hoemann@hpe.com>
	(Jerry Hoemann's message of "Fri, 6 Nov 2015 15:27:29 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org
List-Id: linux-acpi@vger.kernel.org

Jerry Hoemann <jerry.hoemann@hpe.com> writes:

> Add internal data structure for ndctl_passthru call.
>
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>  include/linux/libnvdimm.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 3f021dc..01117e1 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -72,6 +72,7 @@ struct nvdimm_bus_descriptor {
>  	unsigned long dsm_mask;
>  	char *provider_name;
>  	ndctl_fn ndctl;
> +	ndctl_fn ndctl_passthru;

I don't think this is necessary.  Vector off inside of __nd_ioctl.  That
especially makes sense if you do switch to passthrough as a command
instead of a type, but it can work either way.

-Jeff
