From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V8 7/9] vfio, platform: make reset driver a requirement by
 default
Date: Wed, 13 Jul 2016 16:48:32 -0400
Message-ID: <eeb13445-a4bb-9230-527c-d85ab4da4c3e@codeaurora.org>
References: <1466437879-32182-1-git-send-email-okaya@codeaurora.org>
 <1466437879-32182-8-git-send-email-okaya@codeaurora.org>
 <20160623125955.647008cb@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160623125955.647008cb@t450s.home>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@redhat.com, linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 6/23/2016 2:59 PM, Alex Williamson wrote:
>> -static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
>> > +static int vfio_platform_get_reset(struct vfio_platform_device *vdev)
>> >  {
>> >  	if (vdev->acpihid)
>> > -		return;
>> > +		return vfio_platform_acpi_has_reset(vdev) ? 0 : -ENOENT;
>> >  
>> >  	vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>> >  						    &vdev->reset_module);
>> > @@ -140,6 +140,8 @@ static void vfio_platform_get_reset(struct vfio_platform_device *vdev)
>> >  		vdev->of_reset = vfio_platform_lookup_reset(vdev->compat,
>> >  							&vdev->reset_module);
>> >  	}
>> > +
>> > +	return vdev->of_reset ? 0 : -ENOENT;
>> >  }
> nit, this looks more like a:
> 
> static bool vfio_platform_has_reset(...)
> 	...
> 		return vfio_platform_acpi_has_reset() == 0;
> 
> 	...
> 
> 	return vdev->of_reset != NULL
> 

Sorry, I didn't understand this comment. The code has get and put functions for DT.
These functions are not useful for ACPI. This is the reason for the above change. 

Can you be more specific?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
