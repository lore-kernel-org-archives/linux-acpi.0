Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B22BF3F3;
	Tue, 21 Jul 2026 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636829; cv=none; b=D+vr2utc8D2wGu5ISzTL60uZQD9IhiZb2os3oV0Ax5Ph3p8Z0qkgpkW9RJResEagCw5HqxYLurlaRnjK8FfaXB+Xchv+qSSP4uZdwVWDinHB7dC5urfn0DlLDbIVY6wV+mvZERDmoc2opOdwJoF41rFbh6fbl4bxjZQ7EhQ6npU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636829; c=relaxed/simple;
	bh=kS7pGa7W9ggTxkUS7tLCEMaxQyQhib+HIbsZm4WFvh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw/9lTIqRdE6kZzjf7o33Z/1z5YSMsrCYR2Wun32Fc7EUZLbrRoH+AvsJZQNLi3aBkj7CY6rvEGpYX+1690nGUC/YjCMEpt07MV/X0UNn8tq5dECohBjNl6h2YL9mIAN/ZG27ZoHunUtu0ScUNHmi+hW75tZuSW1cup/5lvKvxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3QmwPYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3QmwPYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DDB1F000E9;
	Tue, 21 Jul 2026 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784636827;
	bh=0FeaAJPknYRzqr3lr/xI99C+B9GaP/MgRADlP+jJ6O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a3QmwPYI5GDLG5DuxTtMPyE4MvlJSLT624waeRaiepN2lhFnBvREoinNX3TZv9L81
	 ONxnFS1VOVVUnXS2B/DBHIYXzWrwiJ1az6qwoQcj0ky0TeOdshs6LtzBVEoYsQs/EB
	 a+EEy4y+/Z1vdJ5lvq6HkYRp+bpb6Y1EztcUeXlo8iGB6ly5yTQiCfV24RDs2pFT5f
	 ubbycxibv5hr0WZ7Bm64pixTVtrZ8tiwv4dkBbHFvXfNDeMbHX8Nw3TGfRWgspHcOi
	 Wz+JAPHqr25x1Bo0/QDScn1EXhafCOBKzkbETzSdit6yumh5DKdpiw/SsT5siW8biN
	 F1i3BPvsX+DaA==
Date: Tue, 21 Jul 2026 13:27:04 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	acpica-devel@lists.linux.dev,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>
Subject: Re: [PATCH 2/4] ACPI: PCC: Preserve shared memory signature in
 OpRegion handler
Message-ID: <20260721-honest-shiny-teal-da9d6d@sudeepholla>
References: <20260717081005.470013-1-sudeep.holla@kernel.org>
 <20260717081005.470013-3-sudeep.holla@kernel.org>
 <b75fc80b-6d1c-44d9-986c-be2c0a6e7711@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75fc80b-6d1c-44d9-986c-be2c0a6e7711@huawei.com>

On Tue, Jul 21, 2026 at 07:43:53PM +0800, lihuisong (C) wrote:
> 
> On 7/17/2026 4:10 PM, Sudeep Holla wrote:
> > ACPI 6.3 introduced PCC OperationRegions. Section 5.5.2.4.7.3,
> > "Declaring message fields within a PCC OperationRegion", states that,
> > for all PCC subspace types, the PCC Operation Region pertains to the
> > region of PCC subspace that succeeds the PCC signature.
> > 
> > The PCC address space handler currently copies the OperationRegion
> > buffer to and from the start of the PCC shared memory region. That can
> > overwrite or expose the signature at byte offset 0, and it also misses
> > the last 4 bytes of the actual PCC OperationRegion data.
> > 
> > Offset OperationRegion copies by the size of the signature and reject
> > regions that do not fit in the shared memory after that signature. AML
> > that sizes the PCC OperationRegion to include the signature is not
> > conforming to the PCC OperationRegion definition.
> > 
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
> > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > ---
> The below commit description said the PCC operationRegion contains the
> signature field.
> "77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC
> Type 3 subtype")"
> And I find that the definition of this OperationRegion in ACPI spec 6.3 is
> the same with spec 6.5 and 6.6.
> That is, the original implementation already didn't comply with ACPI spec.
> 
> Patch 1/4 also requires the change of platform AML about PCC
> OperationRegion.
> These modification may lead to the existed PCC OperationRegion method in
> some drivers doesn't work.
> Because the platform AML still contains signature field in PCC
> OperationRegion method.
> I don't know how many drivers in linux have used this method.
> IMO, we at least need to reclarify this usage change and provide a new usage
> example in the commit log like the original commit did.
> 

Good point, I didn't realise I had wrong example in the original commit.
I will add the example of correct usage in this change. Thanks for pointing
it out.

> Anyway, this patch also makes the driver more compliant with the
> specifications.
> So I agree.
> Reviewed-by: Huisong Li <lihuisong@huawei.com>
> 

Thanks again for all the review.

-- 
Regards,
Sudeep
