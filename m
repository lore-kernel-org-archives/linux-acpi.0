From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH V6 4/7] OF: properties: Implement get_match_data()
 callback
Date: Thu, 7 Dec 2017 16:20:36 +0100
Message-ID: <20171207162036.6a71a4f5@karo-electronics.de>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
        <1512493493-6464-5-git-send-email-okaya@codeaurora.org>
        <20171207141029.575c0a03@karo-electronics.de>
        <def8e351-bc2d-7adc-fdc5-362b365302a8@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <def8e351-bc2d-7adc-fdc5-362b365302a8-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Thu, 7 Dec 2017 09:45:31 -0500 Sinan Kaya wrote:
> On 12/7/2017 8:10 AM, Lothar Waßmann wrote:
> >> +void *of_fwnode_get_match_data(const struct fwnode_handle *fwnode,
> >> +			       struct device *dev)
> > Shouldn't this be 'const void *of_fwnode_get_match_data
> 
> OF keeps the driver data as a (const void*) internally. ACPI keeps the
> driver data as kernel_ulong_t in struct acpi_device_id.
> 
> I tried to find the middle ground here by converting output to void*
> but not keeping const.
> 
It should be no problem to cast a (const void *) to an unsigned long
data type (without const qualifier).


Lothar Waßmann
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
