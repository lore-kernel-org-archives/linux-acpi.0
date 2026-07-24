Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A374424D73;
	Fri, 24 Jul 2026 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784895570; cv=none; b=p7CLmGp2yL+V3kvVesf/6QxhWmeEACPciALj3rFNSJXFxdIo7ZHY8JLIhvWjA1w1pomTqAuPsPj5SmBJ3iZ9Yn5CyZjJ13XeOY+kdkRpeA2ROjoKEpwdva7OtXkhMpY48aSpzRTNy17f2BIl3zg7Ul5K6k6F4ykuhpEobsb6jlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784895570; c=relaxed/simple;
	bh=6uomoyV0iRv18desCe0Ak+BFbkxhWlYI9AcLsTwWEyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddUjE+sb2grijxLCPM9q5kVKvOgtOiRjwwb4K710jxFvAgWQmR+r3G3UPy3cTDa4N4E056C974Itr9ivGTdzjcmg6xnZbnSlM7oTcP5K63c9pm0MdbTHP+eCb0QQz9PpyUu8ajEnF3avEPunLgy3FcSSJe5nGWvJny96uNJPG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGR1+R3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGR1+R3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117CA1F00A3D;
	Fri, 24 Jul 2026 12:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784895568;
	bh=2NihTIkzvJJhL1oMJLkkInbq38KcecjKA4gcRVTiYro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HGR1+R3Utvf9qRUvr8MB/WEz/YIO7CFExPVMRcFsOjvGb/mhOz57ZZLW4G8DGzlKi
	 jCwQSCoOos3aLTbrn+yAOjadJhCjxqFtgp9HIKSA/8w8HFoaR3wGdHKLDfDyBU6+2q
	 UEm5YkrYt3eGQW/gl1td6o6mUmd9SCBwoHsaYarHVkiVTZJ3WLSkZsB9Z3yadfRBbl
	 7qSDulW2JajROCYIXjXaYTr6pL6MsHku94UmabQD/1FUWADB4qdHY1Wre6CSZgvu9G
	 Frr1z5nG+wsonT8jDV84KcUak3r2w5opxI9vxJBJ0TNwlVkO7Uxl26TSeVloHdvLcN
	 VghuxtNsSqVxg==
Date: Fri, 24 Jul 2026 13:19:22 +0100
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
Subject: Re: [PATCH v4 05/10] arm_mpam: propagate MSC access errors for
 __ris_msmon_read()
Message-ID: <20260724-daffy-red-gazelle-3f70be@sudeepholla>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
 <20260723155454.1760823-6-andre.przywara@arm.com>
 <20260724-horned-wolf-of-will-a49c1d@sudeepholla>
 <1864c9a2-2e97-411e-9f12-862a8cfd4101@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1864c9a2-2e97-411e-9f12-862a8cfd4101@arm.com>

On Fri, Jul 24, 2026 at 01:17:06PM +0200, Andre Przywara wrote:
> Hi,
> 
> On 7/24/26 12:02, Sudeep Holla wrote:
> > On Thu, Jul 23, 2026 at 05:54:49PM +0200, Andre Przywara wrote:
> > > Allow the function for RIS accesses to return an error, and propagate
> > > read and write errors from the lower level up.
> > > This function is a bit special, since it can be called via an SMP
> > > helper, so the prototype must stay as void. So propagate any errors
> > > using the "err" field in the struct passed in as the sole argument to
> > > that function.
> > > 
> > 
> > Not sure if this was already discussed by build bisection regresses between
> > 4/10 and 5/10 as you change function prototype there and caller here or
> > am I missing to read it correctly ?
> 
> Does it? I build tested every patch multiple times yesterday, and just
> repeated it, and it comes back cleanly.
> 
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >   drivers/resctrl/mpam_devices.c | 36 +++++++++++++++++++++++++---------
> > >   1 file changed, 27 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> > > index 9ee4eb4db03f..bcff53477133 100644
> > > --- a/drivers/resctrl/mpam_devices.c
> > > +++ b/drivers/resctrl/mpam_devices.c
> > > @@ -1328,6 +1328,10 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type,
> > >   	return overflow_val;
> > >   }
> > > +/*
> > > + * This function might be called via smp_call_function_any(), so propagate
> > > + * errors inside the arg struct.
> > > + */
> > >   static void __ris_msmon_read(void *arg)
> > >   {
> > >   	u64 now;
> > > @@ -1351,7 +1355,9 @@ static void __ris_msmon_read(void *arg)
> > >   	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, ctx->mon) |
> > >   		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
> > > -	mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> > > +	m->err = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> > > +	if (m->err)
> > > +		return;
> > >   	switch (m->type) {
> > >   	case mpam_feat_msmon_mbwu_31counter:
> > > @@ -1371,7 +1377,9 @@ static void __ris_msmon_read(void *arg)
> > >   	 * Read the existing configuration to avoid re-writing the same values.
> > >   	 * This saves waiting for 'nrdy' on subsequent reads.
> > >   	 */
> > > -	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
> > > +	m->err = read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
> > > +	if (m->err)
> > > +		return;
> > > 
> > 
> > Atleast read_msmon_ctl_flt_vals() changed to return value in last patch.
> 
> Ah, but this is not a problem that breaks the build, as we formerly just
> ignored the (at this point bogus) error value, but now pass it up.

Rather than return I was thinking about added parameter to get the read value.

> But this is one occasion of "touching the same line twice", that was
> criticised before. Not nice, but the alternative would be to have one giant
> patch, which I figured to be unreadable.
> 

Ah then good. May be I was overthinking.

-- 
Regards,
Sudeep
