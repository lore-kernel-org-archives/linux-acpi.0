Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362B3F1670;
	Tue, 30 Jun 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814674; cv=none; b=sdE73idHs86yi2OA41d6LWaIM0GAij3geFbCHJCbT9PyCVDjlgO13fPCpfPh4YT+39SwxuQlSOlhOZWckAflyYuAS2NV+haJAT1FmgsYZD81dUkgXEpUY4tD/YuxoyWSR3ReSs/6/ORtQ2OzDlLRRQmQRuugt/9qTFvGG5YMIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814674; c=relaxed/simple;
	bh=ylEfsd1UyDYOatDpU3evEe46Sedio+5bHpIHaeaS0mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1jPS+mqACIhK1+DfwHjqTjRCz9iUJ6+rSUPh5dsk9ecotOvS74C8W5Y9Tv4pg8Nq6i2b1K/gWgv9RCSe2JnPSYTE+HjLhEX7NrerO4Tytf3mLf5MfEXQUqCNnuAB8huCQDBKUg+PPIUdhMxR8CUOlRmEqL4GF8XTvwULlJFN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsBULc5H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsBULc5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2410A1F00AC4;
	Tue, 30 Jun 2026 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782814666;
	bh=Xvu8Px80lmkke9YSnT8Xs2XYWg6KDBDPQOGflwZ40lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lsBULc5HRoC2TpEY/Q81VDHUzWSLbYVnVS4W2ZmvYfi6Z2HC5o9exzeNqSLY7MUqL
	 7BVrPln4jHECe3cZ9noX8R/MExgXYO2K9JIPuXOjPWbm82cUpNSULECzVhsQOwU/OT
	 oz/d8Myp19I5juSVnVZiP+T9jBxNufdyHeQMmRSlhDIzWQ1dhACM38hFvvU+7V1fjP
	 j5qTZuSNuFF1kEUveElUqGd1glZBUSDe2egdjEFBDU2pNiFijf+bAd67tyEVGX6lY6
	 DoNttKonSBgDpJOIyssldj8Iz+cNO1S3QRjSKo/WqOMRSSLBcRErcz8EC5eYlhqTK3
	 vrWx4l1B10+Bg==
Date: Tue, 30 Jun 2026 11:17:42 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 1/6] mailbox: pcc: Validate shared memory signature on
 request
Message-ID: <20260630-encouraging-aspiring-sawfish-016faf@sudeepholla>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <20260627-acpi_pcc_signature-v1-1-c1b7268d4fdc@kernel.org>
 <53b369fc-6ad0-4b0e-8f0d-e1e4ceec2937@huawei.com>
 <0f7ea2f6-a584-4d56-a8b6-3d0c5c577c8e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f7ea2f6-a584-4d56-a8b6-3d0c5c577c8e@huawei.com>

On Tue, Jun 30, 2026 at 05:18:39PM +0800, lihuisong (C) wrote:
> 
> On 6/30/2026 5:02 PM, lihuisong (C) wrote:
> > 
> > On 6/28/2026 12:37 AM, Sudeep Holla wrote:
> > > ACPI defines the PCC shared memory signature as the bitwise OR of
> > > 0x50434300 and the PCC subspace ID. The signature is located at byte
> > > offset 0 for the generic, extended and reduced PCC shared memory region
> > > layouts.
> > > 
> > > Validate the signature when a client requests a PCC mailbox channel,
> > > after
> > > mapping the shared memory and before binding the mailbox client. This
> > > keeps PCC shared memory validation in the PCC mailbox controller instead
> > > of duplicating it in individual clients.
> > > 
> > > ACPI 6.6 added clarification that the signature is populated by the
> > > platform and verified by OSPM.
> > > 
> > > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > > Cc: Huisong Li <lihuisong@huawei.com>
> > > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > > ---
> > >   drivers/mailbox/pcc.c | 38 +++++++++++++++++++++++++++++++++-----
> > >   1 file changed, 33 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > > index 636879ae1db7..6fbc17d41774 100644
> > > --- a/drivers/mailbox/pcc.c
> > > +++ b/drivers/mailbox/pcc.c
> > > @@ -345,6 +345,28 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
> > >       return IRQ_HANDLED;
> > >   }
> > >   +static int pcc_mbox_validate_signature(struct pcc_mbox_chan
> > > *pcc_mchan,
> > > +                       int subspace_id)
> > > +{
> > > +    u32 expected_signature = PCC_SIGNATURE | subspace_id;
> > > +    u32 signature;
> > > +
> > > +    if (pcc_mchan->shmem_size < sizeof(signature)) {
> > > +        pr_err("PCC subspace %d shared memory is too small\n",
> > > +               subspace_id);
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    signature = ioread32(pcc_mchan->shmem);
> > > +    if (signature != expected_signature) {
> > > +        pr_err("PCC subspace %d has invalid signature: %#x expected
> > > %#x\n",
> > > +               subspace_id, signature, expected_signature);
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > If the signature is incorrect, there must be an issue with the PCCT
> > table reporting.
> > So how about place this verification in pcc_mbox_probe?
> > We can mark the channel as unavailable so that other normal channels can
> > continue to be used.
> > And the impact is minimal.
> It can only be seen after being mapped here.

Indeed, we still fail to allocate the channel in case of invalid signature.

> Sorry, please ignore this.

No worries.

-- 
Regards,
Sudeep
