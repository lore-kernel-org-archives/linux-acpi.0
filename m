Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C643786F;
	Thu, 23 Jul 2026 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802002; cv=none; b=bu5fw8KCsC5gF7jngEnMYN2s1VyhSC6HPuRxDAFbPT2Vtt44tq3vFT6UPEcfzS3kagUfGmbPHI1n1Qba/Veocwf8GxrvmHm+AesNGFUML50aOxITpPgoi+PYdyV6NTY5Kr2GK0fAUpsaZy1JQBa+yvoXCaiylUSZdO69Th871EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802002; c=relaxed/simple;
	bh=903SBNKCqaGrmonmQPOiQhYV1a/dd2KJ8FsLFIMlpG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUd7uWW4jR5T7sycq5AYlT2od7ObzhzdGHv8kC+CZY9K2TMgDacsyp4U5mRhtdEDNyjDbAKdaKx9IVU81Am/q4o7d96nmpac4RztoPV6XpSvpwsTWDc1qvBPjWsH1hnFP0wUYELVt5OcbQVg+QmH+G1EopvoIf+WtIBYeSsH42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfC2vCPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfC2vCPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739F51F000E9;
	Thu, 23 Jul 2026 10:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784801999;
	bh=FOaupH3b7+ZGB1bnjUO8ZCZIba7PkWCwZuMUGXvitkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KfC2vCPnwcVx6DY/MaL3oz6MGa//6CFuoSb0fSPGZj0wNFcYDCdAS3wcg0GRwz2cs
	 WApFprq1p+PyNkItoOS5mn5ZbbeSHxGCO0Db1vEONVr0nYRhw0DDk+5KuHfbhVhm3p
	 79eyHvTf7jawPPo0IWNc6QRdq5RZN6TZgCV365jtkAe0XJI1bpmM363a0uwovbbz96
	 abva4/kq0JL2GaCEp+zjb+myHVNsPb/jHfqGQGBXKs43xEv8aV4P/e8bHB0a2WRCaf
	 0xd3FcNGUehGVtpOjAxPuNyKgfkKFGbzhgqOIPrR/+A5/iJJfRsRCtct4Wf88vxsYo
	 C03Se5Mebc47g==
Date: Thu, 23 Jul 2026 11:19:42 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>, jassisinghbrar@gmail.com,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mailbox: pcc: Fix command timeout due to missed
 interrupt
Message-ID: <20260723-terrific-shiny-skylark-16044a@sudeepholla>
References: <20260717075649.467172-4-sudeep.holla@kernel.org>
 <20260723031051.156890-1-admiyo@os.amperecomputing.com>
 <20260723-mastodon-of-simple-criticism-2bdcc9@sudeepholla>
 <9414edc2-f3af-44a6-9871-3a52429b97f2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9414edc2-f3af-44a6-9871-3a52429b97f2@huawei.com>

On Thu, Jul 23, 2026 at 05:47:35PM +0800, lihuisong (C) wrote:
> 
> On 7/23/2026 5:16 PM, Sudeep Holla wrote:
> > On Wed, Jul 22, 2026 at 11:10:51PM -0400, Adam Young wrote:
> > > +	/*
> > > +	 * Set chan_in_use before ringing the doorbell so a fast completion
> > > +	 * interrupt is not mistaken for a shared interrupt from another
> > > +	 * subspace. Use WRITE_ONCE() for the lockless flag update. The
> > > +	 * ordered MMIO accessor used to ring the doorbell keeps this store
> > > +	 * visible before the platform is notified.
> > > +	 */
> > > +	if (pchan->plat_irq > 0)
> > > +		WRITE_ONCE(pchan->chan_in_use, true);
> > >   	ret = pcc_chan_reg_read_modify_write(&pchan->db);
> > >   	if (!ret && pchan->plat_irq > 0)
> > > -		pchan->chan_in_use = true;
> > > +		WRITE_ONCE(pchan->chan_in_use, false);
> > >   	return ret;
> > >   }
> > > -- 
> > > 2.43.0
> > > iAt the end of the above code,
> > >   WRITE_ONCE(pchan->chan_in_use, false);
> > >   should be
> > >   WRITE_ONCE(pchan->chan_in_use, true);
> > > 
> > > In order to keep the original semantics.  The flag is cleared when the
> > > messages is ACKed, not here.  This version causes a hang.
> > > 
> > Did you run and seeing hang or just code inspection. If latter, have you
> > considered that modified code sets it true before doorbell is rung and
> > set to false only if there is a failure to ring the doorbell ?
> +       /*
> +        * Set chan_in_use before ringing the doorbell so a fast completion
> +        * interrupt is not mistaken for a shared interrupt from another
> +        * subspace. Use WRITE_ONCE() for the lockless flag update. The
> +        * ordered MMIO accessor used to ring the doorbell keeps this store
> +        * visible before the platform is notified.
> +        */
> +       if (pchan->plat_irq > 0)
> +               WRITE_ONCE(pchan->chan_in_use, true);
>         ret = pcc_chan_reg_read_modify_write(&pchan->db);
> -       if (!ret && pchan->plat_irq > 0)
> -               pchan->chan_in_use = true;
> +       if (ret && pchan->plat_irq > 0)
> +               WRITE_ONCE(pchan->chan_in_use, false);
> 
> 
> !ret -->ret.
> should set to false on failure.  I remember that I fixed this place when I
> tested. But I missed this when I sent it out.
> Sorry for my mistake.
> > 

Ah right, my brain was somehow wired to read it w/o !. My mistake as well,
didn't spot it. I will sent v2, so Jassi can pick that up instead.

-- 
Regards,
Sudeep
