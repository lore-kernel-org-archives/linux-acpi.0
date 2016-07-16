From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V9 7/9] vfio, platform: make reset driver a requirement by
 default
Date: Fri, 15 Jul 2016 21:07:23 -0400
Message-ID: <46aea353-ced9-bd6b-199f-9a785d1d8758@codeaurora.org>
References: <1468461995-32676-1-git-send-email-okaya@codeaurora.org>
 <1468461995-32676-8-git-send-email-okaya@codeaurora.org>
 <20160714162454.4b05813c@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160714162454.4b05813c@t450s.home>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@redhat.com, linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 7/14/2016 6:24 PM, Alex Williamson wrote:
>> struct vfio_platform_device {
>> > +	bool				reset_required;
>> >  	struct vfio_platform_region	*regions;
>> >  	u32				num_regions;
>> >  	struct vfio_platform_irq	*irqs;
> Either you have 64bit bools or you're not paying any attention to
> to the alignment of this structure.  If we only care about 64bit
> systems we could tuck this into the gap after num_regions, otherwise
> append it to the end of the structure, we certainly don't care about
> keeping a reset flag within cache line boundaries.  Thanks,

OK, I moved it to the end of the structure.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
