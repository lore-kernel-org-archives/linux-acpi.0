Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F2175A73;
	Thu, 30 Apr 2026 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777544717; cv=none; b=E3Ju6liUP06Y0YDTPHtG5g1Lfr01cxltxEquxJBP7j9KLCpH+vJLo9RiA0ZA5tA9NevxFbPPBe0rcAzA+1gi6akeSL/wDiZXP7OBE8K38Q3A+V/1LkLxE0bmqLcjP3Za06t0lvZJ/3Lx/8lQC2QXeJ3g+5CZnHB8qf8b2VEK4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777544717; c=relaxed/simple;
	bh=tMcr/ZNDm33BeUEJo0HZiE0/fFa3R/A1Oa5PdaowDp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYOVv7dNVf26pZJj6vUjfCg8vg4smEASBWw38Cwi4+uOXp2juoJE6aCMxAstU9yZSOIjZhzZ0DDGspTXOb8mWrmL+F5qy7bL3pDya0RO+bqIP82MBE+zopbHxLgHnqJXyutrf2XYUnmGFYYg0qiYFiVHIStAAMIsrlEkq6vOA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO2eG3k+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jO2eG3k+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A06C2BCB3;
	Thu, 30 Apr 2026 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777544717;
	bh=tMcr/ZNDm33BeUEJo0HZiE0/fFa3R/A1Oa5PdaowDp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jO2eG3k+TD7SKH3f063YziHmLklRYcBOUMzewUdMjWcIV2LALhpDAffX/JjJ4h8TP
	 AIRE8MkcqsfqjFNsgwigb//V3tYBoWFE9eY7ILSkNgWYiN/FyxRxIDZ+BNfu+Rzasp
	 0L4NyU69D21eZTQnN49/hp6Kdjnj0FTjSjEsa+R1Jb7daHQva3fc820Ue5tl3Vhusz
	 eiuv7mMfhOAywMNOOB0Ta3+NJ0ETwGAxZyKGDstCaBo3yPhSnm28gtubg2yeukPPbK
	 qCVNiOmpwVYJKJfYRt3DnBmMxj/DpsDT3n1ByOY6G0jpH5oHRxUgW2l3xOwgvwvWyY
	 Eu4MEXZsF8H2w==
Date: Thu, 30 Apr 2026 11:25:12 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm_mpam: detect and enable MPAM-Fb PCC support
Message-ID: <20260430-chirpy-snobbish-pogona-58a9de@sudeepholla>
References: <20260429141339.3171205-1-andre.przywara@arm.com>
 <20260429141339.3171205-6-andre.przywara@arm.com>
 <20260430-brave-hoatzin-of-fascination-e7d4ad@sudeepholla>
 <fc96c088-f767-4bf2-b58b-d4e91b0acde4@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc96c088-f767-4bf2-b58b-d4e91b0acde4@arm.com>

On Thu, Apr 30, 2026 at 11:20:42AM +0200, Andre Przywara wrote:
> Hi Sudeep,
> 
> thanks for having a look!
> 
> On 4/30/26 10:35, Sudeep Holla wrote:
> > On Wed, Apr 29, 2026 at 04:13:39PM +0200, Andre Przywara wrote:
> > > The Arm MPAM-Fb specification [1] describes a protocol to access MSC
> > > registers through a firmware interface. This requires a shared memory
> > > region to hold the message, and a mailbox to trigger the access.
> > > For ACPI this is wrapped as a PCC channel, described using existing
> > > ACPI abstractions.
> > > 
> > > Add code to parse those PCC table descriptions associated with an MSC,
> > > and store the parsed information in the MSC struct.
> > > This will be used by the MPAM-Fb access wrapper code.
> > > 
> > > [1] https://developer.arm.com/documentation/den0144/latest
> > > 
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >   drivers/acpi/arm64/mpam.c      |  2 ++
> > >   drivers/resctrl/mpam_devices.c | 46 +++++++++++++++++++++++++++++++---
> > >   2 files changed, 45 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
> > > index 99c2bdbb3314..edb4d10e8dc3 100644
> > > --- a/drivers/acpi/arm64/mpam.c
> > > +++ b/drivers/acpi/arm64/mpam.c
> > > @@ -341,6 +341,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
> > >   	} else if (iface == MPAM_IFACE_PCC) {
> > >   		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
> > >   							tbl_msc->base_address);
> > > +		props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
> > > +							tbl_msc->identifier);
> > 
> > I may be looking at the wrong documents, but neither DEN0065 nor DEN0144 carry
> > any definitions of pcc-channel and msc-id for the device with HID
> > "“ARMHAA5C". Since "pcc-channel" is already merged, I think I am looking at
> > wrong documents, please point me to the right one.
> 
> Please excuse my ignorance, but I was under the assumption that the strings
> used here are just unique identifiers that need to match the property_get
> calls in the MPAM code. Is there any requirement to match those
> property_entry.name fields with the names given in some spec? And those
> strings are kernel-internal only, right? But for DT would match exactly the
> property names?
> 

My bad, I missed to see that these are properties added to the software node
created for ACPI. I assumed the ACPI code is expecting this property in the
namespace device with HID 'ARMHAA5C'. Ignore my comment.

-- 
Regards,
Sudeep
