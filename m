Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F563C3F73;
	Mon, 27 Jul 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192674; cv=none; b=fnxCWbqFdm+s26ZcuPvjDXbyqFndb2yXyeUMVZNSHlAH+UJXdRu3hXqUlDSqUoYC+0TbQTXX6NtBc5DpTfbvtn57NJ4ZjYsQSVEKHX2kHnMlq3JWMpvIfhvrl3X2vZbYi3C2YQFnmZCvKebVg4p1GY+N6okBaPigJpfY2eWM+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192674; c=relaxed/simple;
	bh=go7V3v0u7G3cWcfTYeVJgFje64SWV8uPz4pmHui51bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueuk9ZkKhgf8ON8iJBLPC2uwv4EmUUZoR6vvDqQdAe4Td758Lr89qds7VzYXnc0a9bmq5kQTA1jeBqGJavVckfDBlNZ2xc+NcvfOoB7GbcccZwJ6Z+aEgI+hTfOMMQxtnBxGHww0nyhbGfJsK5SXqsI5UGzLjjQTxI9BYhLPUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMjD1Wll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMjD1Wll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1E31F000E9;
	Mon, 27 Jul 2026 22:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192672;
	bh=Os/hNsBhlrW8yY2Huxh6rA06MFVClKkCltrPKtDOtfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gMjD1WllPfwdyJuRpIT00rIIbyz5IMm2v8b9kpT9hAjCb0e6GXpXWiK3RmSKvo+ga
	 tZXfImieApzyyp8UWAC5fC5bE5izXzCPYxQIRAX/VeEJIuqszr/G5tYArg//e9abyk
	 w+i03CRIG71OOyj7R1sTGSZXONr3fQEocgBP2WYUc30M6QA2gsyzMn1LUhpG5Ubw56
	 gN/Y99Nh4IGk8GbSMdFxzSvOsTV6k3pLhWes9GMATNLJvlbqlL+tFaiAOO3vP1L6c2
	 Vp1uZ2nyKDueIp1cRaQyaUydsn/KzFLwYla4vaA6faXINVUQiUkdrcJW/P9MMQVWGW
	 wZB8cIKdFNmCw==
Date: Mon, 27 Jul 2026 23:51:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ben Horgan <ben.horgan@arm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Andre Przywara
 <andre.przywara@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun
 Guo <guohanjun@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>, Srivathsa L
 Rao <srivathsa.rao@oss.qualcomm.com>, Ganapatrao Kulkarni
 <ganapatrao.kulkarni@oss.qualcomm.com>, Trilok Soni <tsoni@quicinc.com>,
 Srinivas Ramana <sramana@qti.qualcomm.com>, Niyas Sait
 <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/10] arm_mpam: propagate MSC access errors for
 state saving function
Message-ID: <20260727235108.0ec96f09@jic23-huawei>
In-Reply-To: <83336f0e-85ac-4711-9594-5edcb27eecdd@arm.com>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
	<20260723155454.1760823-7-andre.przywara@arm.com>
	<20260724-important-curassow-of-support-ce4777@sudeepholla>
	<e182f2ac-6fd9-4a25-9409-9617012584ed@arm.com>
	<20260724-perfect-pygmy-chinchilla-447ce0@sudeepholla>
	<83336f0e-85ac-4711-9594-5edcb27eecdd@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 17:43:12 +0100
Ben Horgan <ben.horgan@arm.com> wrote:

> Hi Sudeep, Andre,
> 
> On 7/24/26 13:27, Sudeep Holla wrote:
> > On Fri, Jul 24, 2026 at 01:19:14PM +0200, Andre Przywara wrote:  
> >> Hi,
> >>
> >> On 7/24/26 12:07, Sudeep Holla wrote:  
> >>> On Thu, Jul 23, 2026 at 05:54:50PM +0200, Andre Przywara wrote:  
> >>>> Allow the mpam_save_mbwu_state() function to return an error, and
> >>>> propagate read and write errors from the lower level up.
> >>>>
> >>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >>>> ---
> >>>>   drivers/resctrl/mpam_devices.c | 29 ++++++++++++++++++++++-------
> >>>>   1 file changed, 22 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> >>>> index bcff53477133..6329443c451f 100644
> >>>> --- a/drivers/resctrl/mpam_devices.c
> >>>> +++ b/drivers/resctrl/mpam_devices.c
> >>>> @@ -1833,22 +1833,37 @@ static int mpam_save_mbwu_state(void *arg)
> >>>>   		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
> >>>>   			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
> >>>> -		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> >>>> -		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> >>>> -		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> >>>> -		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
> >>>> +		ret = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> >>>> +		if (ret)
> >>>> +			return ret;
> >>>> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> >>>> +		if (ret)
> >>>> +			return ret;
> >>>> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> >>>> +		if (ret)
> >>>> +			return ret;  
> >>>
> >>> How does it work in general with PCC. Now that you can fail at any point,
> >>> what happens to the write that occurs before a failed read like above one.
> >>> Who will take care of erasing those new writes or it doesn't matter ?  
> 
> At least in this particular case it doesn't matter. The MON_SEL just configures which instance of
> the monitor we are reading or writing from and we'll just write MON_SEL again next time we want to
> interact with a monitor.
> 
> >>> Just checking as I don't have much knowledge on MPAM intrinsics.  
> >>
> >> TBH I don't know, but I think we consider MPAM botched at this point, and
> >> just stop the driver, similar to an error IRQ? But I am not sure this is
> >> properly implemented at this point. The focus of these first six patches was
> >> merely to lay the dirty groundwork for *being able* to handle errors, and do
> >> this now rather than in the future.
> >>  
> 
> I've just been discussing the error handling with James and trying to work out what we can do
> without limiting our options going forward. Ideally, if there are transient errors we'd like to
> retry in the kernel if it's not taking "too long" and otherwise report the error back to user space.

Agreed a retry makes sense.  Perhaps moan a fair bit via a ratelimited print though as
it is a pretty bad sign if retries are normally needed.

> For catastrophic errors, such as when the scp doesn't reply at all or that no MPAM commands are
> going to work again we should disable MPAM. As resctrl does not anticipate errors willy nilly from
> arch code it ends up reporting the info/last_cmd_status as "ok" even in situations when the MSC
> accesses have failed. I notice this in at least rdtgroup_schemata_write(). Before we can report
> proper failure information from resctrl and update last_cmd_status based on the error status from
> the architecture code it doesn't make sense to report the errors to user space. We would likely want
> resctrl to understand -ETIMEDOUT as well. As such, this leaves us the option of just nuking MPAM on
> any error reported from the MPAM firmware interface. For now, we needn't do any retries and just
> error out on the first error. It should be possible to just schedule mpam_broken_work from mpam_fb.c
> on error.

Hmm. Inelegant but I suppose that works... 

> 
> Sorry for prompting the writing of these error handling patches but they will likely come in useful
> in the future.
> 
> Thanks,
> 
> Ben
> 
> > 
> > Well, I agree to some extent, but PCC adds that failure case before which
> > it wasn't there. So, it is hard to claim that it was botched up before so
> > let it be. I will let James/Ben to decide if it was already botched up or
> > PCC addition makes it fragile in terms of error handling.  
> 
> 
> 

