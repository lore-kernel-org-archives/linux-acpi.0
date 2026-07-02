Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3247CC69;
	Thu,  2 Jul 2026 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994766; cv=none; b=o0glvQqJtoOGX3WRelpeDgzvz1i69tjYxvyZ28GiW5Anb8GOhxZgPa8PASk/QKIB5gwykC4ll5q3Ytj4S2EIUL30qk0vsvjlMgebHXy41rlugtK9HZ3ldjRFnGioUPiEvD39Bcl1EytiEG6BI7mVYu+8KuLZEfzS+Bziy3HDlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994766; c=relaxed/simple;
	bh=xJqhSBb+jDfSTAt4v2CBOJtHb9k/pH3XjmE7x8zTYf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVE18xSLEidBe9Cat6KhwU8Q4ND0cAWhFVKEoFfbqM70m/7ML/SzDuVunz13zmzcu89OfLl1vbzREMns9lq7f98idcENwNeuwLNpRA/181+vmDgqSZSeKGE9AWMnLIPqDnMS8XZ7bfioA8aKIzfEednZD0XfHVYu5clc17e4c50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzJLmE+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzJLmE+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40531F000E9;
	Thu,  2 Jul 2026 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782994764;
	bh=lfLtMWf+BFQEw4fSsvcro34I6pGXvppcn+EFKF/CaSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UzJLmE+d/HEk7p4wikkLKuYCkqPkilhoZDJKsozz8Etuw+dIZT/LvyZGC1PVaR2gu
	 Nxt+hso+JcTDB41PxKbWu+7pa59oGspwp0qZqJQH+b1kan+hI1mp9wXVv2Fzm9qK3A
	 1eGdOBBV0zdOEn8dXkaosk3lJ9GeGF1o3bbzwnVVV+F3bCFUfdMrBGX8EMQU8eN20p
	 2Pgps9DDw6UP6mgB0NeToOskNEmRkvxu88NXT48p5BSaLRp8pxeJ9QRjZLzEbZb3T0
	 4Ozin5mzTptAQES3L1i+2hHSL30p9ubXSqRaOuk/gDiRp1hZ3iWIdDzEX1sioQcuJn
	 Twgrv5XGSdBAQ==
Date: Thu, 2 Jul 2026 13:19:21 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>
Subject: Re: [PATCH 6/6] ACPI: PCC: Preserve shared memory signature in
 OpRegion handler
Message-ID: <20260702-sexy-jasmine-bulldog-1392b0@sudeepholla>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <20260627-acpi_pcc_signature-v1-6-c1b7268d4fdc@kernel.org>
 <CAJZ5v0j5RtaadVjTLm7rghNiz_9b4_Rs4PPQZgAinud7tssgEA@mail.gmail.com>
 <20260630-thankful-organic-foxhound-a991a0@sudeepholla>
 <CAJZ5v0gt5OsgUHXDyt1D=090ZMoxWg_s+Cwjs-M5AkC8e806ig@mail.gmail.com>
 <20260701-hopeful-cuddly-bobcat-6a8cf6@sudeepholla>
 <20260701-predictable-dragon-of-emphasis-50e5dc@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701-predictable-dragon-of-emphasis-50e5dc@sudeepholla>

On Wed, Jul 01, 2026 at 03:13:42PM +0100, Sudeep Holla wrote:
> On Wed, Jul 01, 2026 at 02:34:10PM +0100, Sudeep Holla wrote:
> > On Wed, Jul 01, 2026 at 12:44:30PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > On Tue, Jun 30, 2026 at 7:00 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> > > >
> > > > On Tue, Jun 30, 2026 at 02:33:08PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > > > On Sat, Jun 27, 2026 at 6:39 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> > > > > >
> > > > > > ACPI defines a PCC OperationRegion as the shared memory fields that
> > > > > > follow the PCC signature. The OperationRegion length is likewise the
> > > > > > total size of the fields that succeed the signature in shared memory.
> > > > > >
> > > > > > ACPI 6.6 adds clarification that the PCC shared memory signature is
> > > > > > populated by the platform and verified by OSPM.
> > > > > >
> > > > > > The PCC address space handler currently copies the OperationRegion
> > > > > > buffer to and from the start of the PCC shared memory region. That can
> > > > > > overwrite or expose the signature at byte offset 0, and it also misses
> > > > > > the last 4 bytes of the actual PCC OperationRegion data.
> > > > > >
> > > > > > Offset OperationRegion copies by the size of the signature and reject
> > > > > > regions that do not fit in the shared memory after that signature.
> > > > > >
> > > > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > > > Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
> > > > > > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > > > >
> > > > > Does this depend on anything else in the series or is it independent?
> > > > >
> > > >
> > > > It is independent. This just fixes the issue of including the signature in
> > > > the opregion data. It can go independently as all other patches as well.
> > > 
> > > So I've looked at Sashiko's feedback on this change:
> > > 
> > > https://sashiko.dev/#/patchset/20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc%40kernel.org
> > > 
> > > and I'm a bit worried.
> > > 
> > > Of course, the preexisting issues found by it will need to be
> > > addressed separately, but what about firmware released before the
> > > clarification in ACPI 6.6 and the possible misalignment issue
> > > mentioned by it?
> > 
> > I haven't analysed all the report from Sashiko yet. But unlike other patches
> > in the series, this one is not strictly to validate the signature.
> > 
> > Even before v6.6, the PCC Opregion didn't include the signature which is
> > at offset 0. The code always started copying to/from offset 0 missing the
> > last 32-bit field(word). Since v6.3 when PCC Opregion was added we have
> > this in the specification:
> > 
> >   | <section> Declaring message fields within a PCC OperationRegion
> >   |
> >   | For all PCC subspace types, the PCC Operation Region pertains to the
> >   | region of PCC subspace that succeeds the PCC signature.
> > 
> > So, this patch addresses that issue of wrong starting offset used by this
> > driver.
> > 
> > Other patches I agree, it is more likely we just need to warn and not
> > reject absence of wrong PCC signatures.
> > 
> > I will take a look at the other issues reported by Sashiko soon.
> > 
> 
> Forgot to add that let us wait at-least until I go through the report
> understand and conclude it is not fatal/critical before we can merge this.
> Indeed a quick read concerned as much that I would like to spend time
> analysing it carefully.
> 

Looking at the comments and digging ACPICA in more detail, I found the issue
exist there as well and that is the reason why we hadn't observed it in the
kernel. I will first post the fix for that and follow up here.

Thanks.

-- 
Regards,
Sudeep
