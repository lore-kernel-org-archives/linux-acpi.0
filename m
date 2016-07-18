From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V9 4/9] vfio: platform: add support for ACPI probe
Date: Mon, 18 Jul 2016 17:23:21 -0400
Message-ID: <83c60af8-ad2a-d351-eace-82e653183521@codeaurora.org>
References: <1468461995-32676-1-git-send-email-okaya@codeaurora.org>
 <1468461995-32676-5-git-send-email-okaya@codeaurora.org>
 <20160714154146.38e37d84@t450s.home>
 <bd8dacde-da6c-2353-7488-58b2f050699c@codeaurora.org>
 <20160718113208.5afb26c2@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160718113208.5afb26c2@t450s.home>
Sender: kvm-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@redhat.com, linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 7/18/2016 1:32 PM, Alex Williamson wrote:
> The implementation looks pretty fixed, it seems like a lot would break
> if that were changed, so the callers of the function would need to be
> updated, including this one.  The ternary below is already paranoid
> enough to handle an API change, but if you want to add one more level
> of paranoia, you could use WARN_ON(!vdev->acpihid) to make it user
> visible.  It could still be done as:
> 
> return WARN_ON(!vdev->acpihid) ? -ENOENT : 0;

OK. I'm adding this and will post a new version after testing.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
