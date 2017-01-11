From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v6 05/14] ACPI: platform-msi: retrieve dev id from IORT
Date: Wed, 11 Jan 2017 22:15:41 +0800
Message-ID: <58763E0D.2030905@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org> <1483363905-2806-6-git-send-email-hanjun.guo@linaro.org> <20170104191805.GE8604@red-moon> <eb1a8149-7c46-39bc-f655-58ca6345f40a@linaro.org> <20170105151530.GA30852@red-moon> <237ca4dc-07ce-0104-27f2-5437b7c7718e@linaro.org> <20170110145741.GA17967@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36814 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbdAKOPy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2017 09:15:54 -0500
Received: by mail-pf0-f169.google.com with SMTP id 189so50474999pfu.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2017 06:15:54 -0800 (PST)
In-Reply-To: <20170110145741.GA17967@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, charles.garcia-tobin@arm.com, huxinwei@huawei.com, yimin@huawei.com, Jon Masters <jcm@redhat.com>

On 01/10/2017 10:57 PM, Lorenzo Pieralisi wrote:
> On Tue, Jan 10, 2017 at 09:39:39PM +0800, Hanjun Guo wrote:
>
> [...]
>
>>> What you can do is create a wrapper, say iort_node_map_platform_id()
>>> (whose signature is equivalent to iort_node_map_rid() minus rid_in)
>>> that carries out the two steps outlined above.
>>>
>>> To do that I suggest the following:
>>>
>>> (1) I send a patch to "fix" iort_node_get_id() (ie index issue you
>>>     reported)
>>
>> I prepared two simple patches, one is for fix the indentation and
>> the other is adding the missing kernel-doc comment, how about
>> sending the out for 4.10-rcx?
>
> For me it is fine depending on how Rafael wants to handle them,
> ie if he can batch those with the eg iort_node_get_id() fix I have
> just sent:
>
> https://patchwork.kernel.org/patch/9507041/
>
>>> (2) We remove type_mask handling from iort_node_get_id()
>>
>> iort_node_get_id() for now only supports id single mappings,
>> Do we need to extend it for multi id mappings? seems Sinan's
>> platform have such cases.
>
> I am not really sure I understand what you mean here.

Sorry for not clear, I was thinking if we want to support
ID mapping entries with multi IDs like BDFs for RC,

>
>>> (3) We create iort_node_map_platform_id() that (pseudo-code, I can
>>>     write the patch if it is clearer):
>>>
>>> struct acpi_iort_node *iort_node_map_platform_id(u8 type_mask, int index,
>>> 						 ...)
>>> {
>>> 	u32 id, id_out;
>>> 	struct acpi_iort_node *parent = iort_node_get_id(&id, index);
>>>
>>> 	if (!parent)
>>> 		return NULL;
>>>
>>> 	/* we should probably rename iort_node_map_rid() too */
>>> 	if (!(IORT_TYPE_MASK(parent->type) & type_mask)
>>> 		parent = iort_node_map_rid(parent, id, &id_out, type_mask);
>>>
>>> 	return parent;
>>> }
>>>
>>> (4) we update current iort_node_get_id() users and move them over
>>>     to iort_node_map_platform_id()
>>
>> I think we need to prepare one patch for the above steps, or it
>> have functional changes for iort_node_get_id(), for example we
>> removed the type_mask handling from iort_node_get_id() and it
>> will break the case for SMMU if we only have requester id entries.
>
> If the question is "should we apply this change as a single logical
> patch" the answer is yes, it looks a simple one to me (basically
> it implies writing the function above and update the iort_node_get_id()
> existing callers with it). Does this answer your question ?

Yes, thank you for your patience :)

When I was preparing patches, I split them into three patches, hope it
makes the review easier, will send out the patch set soon.

Thanks
Hanjun
