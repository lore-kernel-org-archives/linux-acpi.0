Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800F4908B5;
	Fri, 24 Jul 2026 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896070; cv=none; b=lMHCXh2OOK0a5LewyJaipeKdkDWzGSjTC4pJX/6F02iLvIqWQ3SBkEhYG/x7VzYuLCNCz5aeVjC+TXmpoj3kE1wyazwEq/z26qb11n9PsEUYgbWmgOUGDt5dSsQuTy2f6KOM46i/5fk8EYNLChVJJxtMorwCG2DgwENo5l5MNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896070; c=relaxed/simple;
	bh=3QKK/PsMi839vUkpV9uGTan6FayBth+7nmc+nvnWGdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK//ACXkXfhOpkgvVvhAN52kZaVCGhX94WQaOxQXA/RJXz+2HBylybL8xR0TWUGBuhTSbhYMI1panFd+qzO+4HJB976mZRaLXjxuOAWkFerqEYa7AIO6aZWHHXBVOkeIN8SU8RDcfY8mtXH2BZ1tZh0txkrZNRo1oAQjUUv+jy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT4IhH1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT4IhH1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2855B1F000E9;
	Fri, 24 Jul 2026 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784896069;
	bh=WgozD0Rc2fWO01kt42DkQme7vONpq6/PGcDgZ00x91w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PT4IhH1hRFHzTAIo4FI8RZuBKmj+osHKCecVoMaYKIKQTIZoIh4hMLNcemneDAPe1
	 J6VO2XEY8IVEw9ZgJ4Lit85p0rZ5EbEvrradYosrRwh+n6AneRHRe/ZJtYLF5N77hC
	 UBWon6+e0EGWFdiPIajFDEq+kQqRNSu8/ny9DdEXaMY63AlcLgdQDisZYNw04d2L/y
	 DDFLxavPVzKC1DzFLsLZTYFk8tsAlJpcg3hZhmx1jqpNjB6nJ2zEWS9U7KhldeO+Cc
	 pkYNyC/vvVV9Z9R+C4JawFkptPLYOoB6uP/uRy6C41Z2M2Rm2/62qpkcCtxUjGK4kO
	 HAHFg2r8EPkrw==
Date: Fri, 24 Jul 2026 13:27:42 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
	Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>,
	Niyas Sait <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/10] arm_mpam: propagate MSC access errors for state
 saving function
Message-ID: <20260724-perfect-pygmy-chinchilla-447ce0@sudeepholla>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-7-andre.przywara@arm.com>
 <20260724-important-curassow-of-support-ce4777@sudeepholla>
 <e182f2ac-6fd9-4a25-9409-9617012584ed@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e182f2ac-6fd9-4a25-9409-9617012584ed@arm.com>

On Fri, Jul 24, 2026 at 01:19:14PM +0200, Andre Przywara wrote:
> Hi,
> 
> On 7/24/26 12:07, Sudeep Holla wrote:
> > On Thu, Jul 23, 2026 at 05:54:50PM +0200, Andre Przywara wrote:
> > > Allow the mpam_save_mbwu_state() function to return an error, and
> > > propagate read and write errors from the lower level up.
> > > 
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >   drivers/resctrl/mpam_devices.c | 29 ++++++++++++++++++++++-------
> > >   1 file changed, 22 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> > > index bcff53477133..6329443c451f 100644
> > > --- a/drivers/resctrl/mpam_devices.c
> > > +++ b/drivers/resctrl/mpam_devices.c
> > > @@ -1833,22 +1833,37 @@ static int mpam_save_mbwu_state(void *arg)
> > >   		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
> > >   			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
> > > -		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> > > -		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> > > -		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> > > -		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
> > > +		ret = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> > > +		if (ret)
> > > +			return ret;
> > > +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> > > +		if (ret)
> > > +			return ret;
> > > +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> > > +		if (ret)
> > > +			return ret;
> > 
> > How does it work in general with PCC. Now that you can fail at any point,
> > what happens to the write that occurs before a failed read like above one.
> > Who will take care of erasing those new writes or it doesn't matter ?
> > Just checking as I don't have much knowledge on MPAM intrinsics.
> 
> TBH I don't know, but I think we consider MPAM botched at this point, and
> just stop the driver, similar to an error IRQ? But I am not sure this is
> properly implemented at this point. The focus of these first six patches was
> merely to lay the dirty groundwork for *being able* to handle errors, and do
> this now rather than in the future.
> 

Well, I agree to some extent, but PCC adds that failure case before which
it wasn't there. So, it is hard to claim that it was botched up before so
let it be. I will let James/Ben to decide if it was already botched up or
PCC addition makes it fragile in terms of error handling.

-- 
Regards,
Sudeep
