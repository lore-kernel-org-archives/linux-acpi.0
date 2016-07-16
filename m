From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V9 6/9] vfio: platform: call _RST method when using ACPI
Date: Fri, 15 Jul 2016 21:09:33 -0400
Message-ID: <b46984d2-25b4-9d3b-394b-b0baf92bbf01@codeaurora.org>
References: <1468461995-32676-1-git-send-email-okaya@codeaurora.org>
 <1468461995-32676-7-git-send-email-okaya@codeaurora.org>
 <20160714160439.5bafca73@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160714160439.5bafca73@t450s.home>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@redhat.com, linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 7/14/2016 6:04 PM, Alex Williamson wrote:
>> +static inline
>> > +bool vfio_platform_acpi_has_reset(struct vfio_platform_device *vdev)
>> > +{
>> > +#ifdef CONFIG_ACPI
>> > +	struct device *dev = vdev->device;
>> > +	acpi_handle handle = ACPI_HANDLE(dev);
>> > +
>> > +	return acpi_has_method(handle, "_RST");
>> > +#else
>> > +	return false;
>> > +#endif
>> > +}
> What exactly is the rationale for making these inline?  Clearly reset
> is not a performance relevant path.  Thanks,
> 
> Alex
> 

It is remaining from the previous stub functions which were inline. I'll get rid
of the inlines.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
