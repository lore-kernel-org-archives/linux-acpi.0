From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v4] ACPI: Fix acpi_evaluate_object() return
	value check
Date: Thu, 23 Jan 2014 10:19:53 +0800
Message-ID: <52E07C49.9070509@huawei.com>
References: <1390272375-28728-1-git-send-email-wangyijing@huawei.com>
	<CAErSpo4_VCVHcq2cs_HP-_0kFSnUWsxsr6Y1iiR==3XLNaVc2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <CAErSpo4_VCVHcq2cs_HP-_0kFSnUWsxsr6Y1iiR==3XLNaVc2w@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Hanjun Guo <guohanjun@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, DRI mailing list <dri-devel@lists.freedesktop.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Dave Airlie <airlied@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On 2014/1/23 5:37, Bjorn Helgaas wrote:
> On Mon, Jan 20, 2014 at 7:46 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> Since acpi_evaluate_object() returns acpi_status and not plain int,
>> ACPI_FAILURE() should be used for checking its return value.
>>
>> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>> v3->v4: Fix spell error, add Jani Nikula reviewed-by.
>> v2->v3: Fix compile error pointed out by Hanjun.
>> v1->v2: Add CC to related subsystem MAINTAINERS
>> ---
>>  drivers/gpu/drm/i915/intel_acpi.c              |   24 ++++++++++++++----------
>>  drivers/gpu/drm/nouveau/core/subdev/mxm/base.c |    9 +++++----
>>  drivers/gpu/drm/nouveau/nouveau_acpi.c         |   23 +++++++++++++----------
>>  drivers/pci/pci-label.c                        |    9 ++++++---
> 
> For the drivers/pci/pci-label.c part,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks.

> 
>> +       status = acpi_evaluate_object(handle, "_DSM", &input, &output);
>> +       if (ACPI_FAILURE(status)) {
>> +               DRM_DEBUG_DRIVER("failed to evaluate _DSM: %s\n",
>> +                               acpi_format_exception(status));
> 
> It's too bad there isn't an easy way to produce more informative error
> messages, e.g., by including a namespace path or something.  A message
> like:
> 
>     failed to evaluate _DSM: A requested entity is not found
> 
> is only useful if there's enough context to figure out what's going on.

Yes, I will add the namespace path into the debug info, thanks!

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing
