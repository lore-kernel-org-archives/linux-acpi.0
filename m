Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2AB52CCC9
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066807; cv=none; b=cFJZSVEKttQ3Tug68N21khdDtdZ+VHDfXZnrMxC3LhKnTyWsMdA6dmdpv1CsFWgD+6KfugkBAjTzBc6XXonSE+lhSrNh2amB7l/+OVCLwMRAmJvQ1Mgnu9ib93TlM/NMXCxqaNvLJeYB+2RdL0+XdDxPAJWDTw8A67S8Tm+sTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066807; c=relaxed/simple;
	bh=TXsDg8NIm7HJN2tl3l2p2aC54SSE4YQCcwi9qQHzh60=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CptVf7BKC7VFcaXG4Tf2hKjrqOse+wxWPVfu3irvf2py8NhqhMjxcAjIdXfPTIvdsgWpqOAghvrRYjS5NiTV8oTxPocp/j+D+ngu7fuEF+nf8Bv59qN7Y0OmgzwDA4do0OmBg6J0RmcHAPP5t/HHrKOUbn+P19Yg7qpmm76MnMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx+6oREN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx+6oREN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2608A1F000C6
	for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792066806;
	bh=lE661Wroe2zgjZuO0pf3gpxokjJ832mVAkgNNQuLNvI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Yx+6oRENxvUEon0EDnrTB2/eYkaoIOdp+HpfJRkv6+vY2K3xjruKd/F3Si2EXmJkw
	 tXeyQx6k71Q6MXslrKqzbRx5nrfVsKf82oSr8DA9gWPyBuGOpFrFLb7veq8Y6lSy1X
	 FG1twHdp/ZPeOsm76OG9m6L8vcHPXlm46krmxgfNeuX61hnILVHnhYvzJ+qbKH4FDU
	 1zMTg9+2WGSzBJSX3sK8O6U7VEwuUX1vMlx6OVz41svaG/b9ularjvLDQbb5KY5T/5
	 BXC5C+D37QlTsiGs0vsHCTq7uHJKfEBd4p1dJpZERkq5n5fy7mwIdzEKCzv4VhUqfV
	 mfS1kdsQI0PHQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso4332745e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2026 05:20:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByTFGsUQEK8e1w9rqq9TftYoDCL1bvJZsT6VkeQHINo+hcdz45ui2oeO+wYgAPIHCzxIbvR5pV201kl@vger.kernel.org
X-Gm-Message-State: AFq9FYJtuH9HkxAfyj6KR1QJnrw0BUHGR/f0FB5BBq+GPc+uDM+UZ2bZ
	Vt063//J0rUHPYOBmUn5HxzCA7W1QukkgKFr6Tzn+2/fV0kftK7QNhrcclihDvHbrD4mitPQ8ZB
	AGzBYzTowEYFYLT2/csSvG59AHjpcxUTtGTCCogJM4A==
X-Received: by 2002:a05:6512:3e04:b0:5be:3db4:5665 with SMTP id
 2adb3069b0e04-5be3db4582cmr703817e87.7.1792066804656; Thu, 15 Oct 2026
 05:20:04 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 12:20:03 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 12:20:03 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <as4wZeHPziPV3nKU@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011131518.48838-1-toorandom@gmail.com> <as4wZeHPziPV3nKU@ashevche-desk.local>
Date: Thu, 15 Oct 2026 12:20:03 +0000
X-Gmail-Original-Message-ID: <CAMRc=Mf0kGs0gOs52T46C0udU2avb5SzT9V7-Pp+oPAe0b0TQA@mail.gmail.com>
X-Gm-Features: AclHuK8Z90jAgvsy5hC9pGJg69VYpYcrqoLFJxC_udcjr-dP0Dficdu0s-QRt48
Message-ID: <CAMRc=Mf0kGs0gOs52T46C0udU2avb5SzT9V7-Pp+oPAe0b0TQA@mail.gmail.com>
Subject: Re: [PATCH] media: ipu-bridge: hold a reference on the IVSC software node
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Eduardo Ruiz Duarte <toorandom@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, sakari.ailus@linux.intel.com, 
	bingbu.cao@intel.com, djrscally@gmail.com, heikki.krogerus@linux.intel.com, 
	tian.shu.qiu@intel.com, lixu.zhang@intel.com, linux-media@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Oct 2026 15:21:41 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> +Cc: Bart for the double check of the approach. This sounds like it might need
> to be fixed in driver core (software node implementation).
>
> On Sun, Oct 11, 2026 at 03:15:18PM +0200, Eduardo Ruiz Duarte wrote:
>> ipu_bridge_instantiate_ivsc() attaches the IVSC software node to the mei-csi
>> device with set_secondary_fwnode(), but never takes a reference on it, while
>> the driver core unconditionally drops one when that device goes away.
>>
>> device_add() calls software_node_notify(), which does a kobject_get() on the
>> swnode behind dev_fwnode(dev). device_del() calls
>> software_node_notify_remove(), which does the matching kobject_put() -- and
>> that put sits *outside* the "if (swnode->managed)" block, so it runs for every
>> device whose fwnode is a software node, managed or not:
>>
>> 	sysfs_remove_link(&swnode->kobj, dev_name(dev));
>> 	sysfs_remove_link(&dev->kobj, "software_node");
>> 	kobject_put(&swnode->kobj);
>>
>> 	if (swnode->managed) {
>> 		set_secondary_fwnode(dev, NULL);
>> 		kobject_put(&swnode->kobj);
>> 	}
>>
>> csi_dev is the mei-csi device, which the MEI client bus has already added by
>> the time ipu_bridge_instantiate_ivsc() runs. The add-side get therefore never
>> happens for this node, but the del-side put always does.
>>
>> On hardware where the MEI bus resets -- which it does on every s2idle and S4
>> resume on a Dell XPS 13 9340 -- mei-csi is destroyed and recreated each cycle,
>> so the node loses one reference per resume. INTC10CF-N starts at 3: one for its
>> own registration plus one for each of its two port children, since
>> kobject_add() of a child takes a reference on the parent. The third resume
>> therefore frees it, software_node_find_by_name() starts returning NULL, and
>> isys walks the fwnode graph into freed memory:
>>
>>   refcount_t: addition on 0; use-after-free
>>   WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x7e/0xb0
>>    kobject_get+0x94/0xb0
>>    software_node_graph_get_port_parent+0x89/0xd0
>>    fwnode_graph_get_port_parent+0x70/0xd0
>>    fwnode_graph_get_endpoint_by_id+0x93/0x280
>>    isys_notifier_init+0x92/0x180 [intel_ipu6_isys]
>>    isys_register_devices+0x3c9/0x4e0 [intel_ipu6_isys]
>>    isys_probe+0x3df/0x500 [intel_ipu6_isys]
>>    auxiliary_bus_probe+0x4c/0x70
>>    ...
>>    deferred_probe_work_func+0xa5/0x110
>>
>> followed by an underflow and a saturate on the same kobject, and the camera
>> never comes back.
>>
>> Take a reference so the attachment owns one, balancing the put the core will do
>> when csi_dev is destroyed. Where csi_dev is never destroyed this leaks a single
>> kobject reference, which is what the lifetime of the node already assumes.
>>
>> Found while making the camera survive hibernation on a Dell XPS 13 9340
>> (ov02c10 behind an INTC10CF IVSC); with suspend-then-hibernate the first cycle
>> burns two resumes, so the failure consistently showed up on the second
>> hibernation. Tested on 7.0.0-1015-oem: two consecutive hibernations with the
>> node alive throughout and no refcount warnings, where before the second one
>> hung the machine.
>>
>> Signed-off-by: Eduardo Ruiz Duarte <toorandom@gmail.com>
>> ---
>>  drivers/media/pci/intel/ipu-bridge.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> --- a/drivers/media/pci/intel/ipu-bridge.c
>> +++ b/drivers/media/pci/intel/ipu-bridge.c
>> @@ -765,6 +765,15 @@
>>  	if (!fwnode)
>>  		return -ENODEV;
>>
>> +	/*
>> +	 * Balance the kobject_put() that software_node_notify_remove() will do
>> +	 * on this node when csi_dev is destroyed. That put is unconditional,
>> +	 * while the matching get in software_node_notify() only happens at
>> +	 * device_add() time -- and csi_dev was added before we got here, so it
>> +	 * never ran for this node.
>> +	 */
>> +	fwnode_handle_get(fwnode);
>> +
>>  	set_secondary_fwnode(sensor->csi_dev, fwnode);
>>
>>  	return 0;
>

Thanks Andy. Yes, it looks like a bug in swnode.c. I'll send a fix proposal.

Bart
