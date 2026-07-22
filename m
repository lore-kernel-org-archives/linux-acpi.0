Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321048123F;
	Wed, 22 Jul 2026 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710039; cv=none; b=Wo5shq2IHDpul4JfNUZY1CL/eVjlI/BlJ3nmwcjsGPZmHOyDsFDta6FZx1ImGWwlcKJSJhf5u63DbddQatWSkTGFl3iQn2gu+3lBPYNtdsfvAq+cgK9YGMzbHAKj3EjSZh268tmAOWp7lLXdCWpfl+ZdTIG8zDNPvK+XzDw9ers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710039; c=relaxed/simple;
	bh=JL1IdaTIT0AHriy6OYKEoOpjLJ3xBJf0DYsSy3uyL+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQU2VRH3JZ2bIkh58IUtUw+Xe4h+PofzoBMToV7dBZB3sg2IcB8I7SMlJerpyyQSGnPVWV2Bh8bhh+5sgfBHtYzRa3BH7R1LpkFaYa5q98cbshlR43CCwn9sS2jsGvS/FKHUQbYnxfh6fS1Nt2URx/RwsMYVcsgnqy1ZvmB2454=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZINaTcSn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZINaTcSn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB5C1F000E9;
	Wed, 22 Jul 2026 08:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710037;
	bh=O2V9EqMp/L80uF/JnlqVNY323ovkEmjYXpt1l+MoU1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZINaTcSnhBGoFFgtM/fKCvVPtSDKxts+onhhcZBa+hs/RgS/q/l9OC9UsVIj1Ziir
	 l2Ca1aSFUl6x5N0w/ld3cMLmnQ19Of7CcR57xTO0xZjUPl0zj+YBBdYCGD9Wn41nWL
	 GrHf9EYQ5FpHGNbt7Yr2y5tb+1z0jbT1ae5gYlOAFjk3FtkjB90icJVmgEwunUs32i
	 OUFRB97nBEKltExKMtUnCpBXp883nq17ANdC0o7GyaIL4DmHvP9KPVXgxxJ4KyKFZ9
	 iHEx+vMQdYdbmNZtCO+GRqtdx6yin+8cOVAncQVKEStv+VseCUJezUtglU7In0fuZ7
	 dOKZvPV+65gkQ==
Date: Wed, 22 Jul 2026 09:47:14 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: "lihuisong (C)" <lihuisong@huawei.com>, linux-acpi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: Re: [PATCH 2/4] ACPI: PCC: Preserve shared memory signature in
 OpRegion handler
Message-ID: <20260722-accomplished-exceptional-gibbon-f06ba7@sudeepholla>
References: <20260717081005.470013-1-sudeep.holla@kernel.org>
 <20260717081005.470013-3-sudeep.holla@kernel.org>
 <b75fc80b-6d1c-44d9-986c-be2c0a6e7711@huawei.com>
 <20260721-honest-shiny-teal-da9d6d@sudeepholla>
 <CAJZ5v0jAOA3iQB6htExJNAtLu5oVJB9nZGzh=0+uaerVwgHMxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jAOA3iQB6htExJNAtLu5oVJB9nZGzh=0+uaerVwgHMxQ@mail.gmail.com>

On Tue, Jul 21, 2026 at 09:20:15PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Tue, Jul 21, 2026 at 2:27 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> >
> > On Tue, Jul 21, 2026 at 07:43:53PM +0800, lihuisong (C) wrote:
> > >
> > > On 7/17/2026 4:10 PM, Sudeep Holla wrote:
> > > > ACPI 6.3 introduced PCC OperationRegions. Section 5.5.2.4.7.3,
> > > > "Declaring message fields within a PCC OperationRegion", states that,
> > > > for all PCC subspace types, the PCC Operation Region pertains to the
> > > > region of PCC subspace that succeeds the PCC signature.
> > > >
> > > > The PCC address space handler currently copies the OperationRegion
> > > > buffer to and from the start of the PCC shared memory region. That can
> > > > overwrite or expose the signature at byte offset 0, and it also misses
> > > > the last 4 bytes of the actual PCC OperationRegion data.
> > > >
> > > > Offset OperationRegion copies by the size of the signature and reject
> > > > regions that do not fit in the shared memory after that signature. AML
> > > > that sizes the PCC OperationRegion to include the signature is not
> > > > conforming to the PCC OperationRegion definition.
> > > >
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > > > ---
> > > The below commit description said the PCC operationRegion contains the
> > > signature field.
> > > "77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC
> > > Type 3 subtype")"
> > > And I find that the definition of this OperationRegion in ACPI spec 6.3 is
> > > the same with spec 6.5 and 6.6.
> > > That is, the original implementation already didn't comply with ACPI spec.
> > >
> > > Patch 1/4 also requires the change of platform AML about PCC
> > > OperationRegion.
> > > These modification may lead to the existed PCC OperationRegion method in
> > > some drivers doesn't work.
> > > Because the platform AML still contains signature field in PCC
> > > OperationRegion method.
> > > I don't know how many drivers in linux have used this method.
> > > IMO, we at least need to reclarify this usage change and provide a new usage
> > > example in the commit log like the original commit did.
> > >
> >
> > Good point, I didn't realise I had wrong example in the original commit.
> > I will add the example of correct usage in this change. Thanks for pointing
> > it out.
> >
> > > Anyway, this patch also makes the driver more compliant with the
> > > specifications.
> > > So I agree.
> > > Reviewed-by: Huisong Li <lihuisong@huawei.com>
> > >
> >
> > Thanks again for all the review.
> 
> I gather that there will be a v2 then.

Yes, just with the improved commit message giving illustration of AML code
like the original commit that this change fixes. No change is the code as
such.

-- 
Regards,
Sudeep
