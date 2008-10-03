From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH v2] thermal: Make it simpler to use the thermal layer inside the kernel
Date: Fri, 3 Oct 2008 19:08:36 +0200
Message-ID: <200810031908.37618.trenn@suse.de>
References: <20081001120420.GA29479@srcf.ucam.org> <20081001184111.GA3330@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754027AbYJCRIw@vger.kernel.org>
In-Reply-To: <20081001184111.GA3330@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com, pavel@suse.cz
List-Id: linux-acpi@vger.kernel.org

On Wednesday 01 October 2008 08:41:11 pm Matthew Garrett wrote:
> The thermal layer passes temperatures and trip point types around as
> strings. This is fine for sysfs, but makes it hard to use them for other
> purposes in-kernel. Move the string conversion to the sysfs-specific
> code.
I went through your very first version and I also like the string to 
int conversion very much.
I wanted to move the polling from acpi/thermal.c to the new thermal
layer to have the thermal polling in the architecture independent part
and started on top of your first version, but I got stuck and run out of time, 
otherwise I'd also sent this.

>  struct thermal_cooling_device_ops {
> -	int (*get_max_state) (struct thermal_cooling_device *, char *);
> -	int (*get_cur_state) (struct thermal_cooling_device *, char *);
> +	int (*get_max_state) (struct thermal_cooling_device *, unsigned int *);
> +	int (*get_cur_state) (struct thermal_cooling_device *, unsigned int *);
>  	int (*set_cur_state) (struct thermal_cooling_device *, unsigned int);
>  };
Looks like you forgot the menlow driver again which also makes use of this:

grep get_max_state drivers/misc/intel_menlow.c
        .get_max_state = memory_get_max_bandwidth,

It would be great to see the conversion in .28.

        Thomas
