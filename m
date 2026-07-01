Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC862EC090;
	Wed,  1 Jul 2026 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915227; cv=none; b=avid6t4BaSvyEGo3XGzydndjEVXOlmDcjRjG3iGhxGwBGpUFYmf8gNxdy8TyVJS54gXIQ+BerWoQWjFyFH48zFuIuuPdUJpmmIA2p88eNOOsPqhqP/eZma0YViYu5ohANQ7ei3lU46KEcx4OC73bkrklpejYcSg08qYg97n7t7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915227; c=relaxed/simple;
	bh=1rGfPNcgNgC08hQ2F5jk2cvWGbZclzvEv3xWGAg52wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGB3TG54VkZKrnVsPyPbgK2/W6bTqdm8V1vj+L4Sg4/sNm28A0hkV4P7X8ptSSNA4dr6GQ+yKG8ui4Tm5LECSOEDc66jt582ZYjekFp4aYecga0161MCs/oTFbxfL99kb2YqKirxbgoABxzy9fiA1pAdTeY+3jUl3/OX7Sk1aK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUSdUeeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUSdUeeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA27A1F000E9;
	Wed,  1 Jul 2026 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782915225;
	bh=tsl5+Y0W94s1690IjyJ9sGmZ9YKV/kwrVr3A5WQ6PJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SUSdUeeBm1vfJqb7Ivn+nJS7y4blxTQV/noCSINhcvRVXxP6RP4+Ihf7gaLbjnJ86
	 Rkp7+k0XnarQao56N0UmpWlo7kPpoQepuYwtCHF8LSX+kjawdtwO/1cAmW4xIeK/Gc
	 x+eB8STWsajZOErr7/B7Lt7A6tPA9epPWlQdSqFEho0WLRq9LqqIHrsxvif12Ms1WT
	 Fm4hYE6cNhcmXo48dduxtxcdg85IU5vaa4B9mcEVrHDaoLTDhQBkBwwctuZ0Wd4mz1
	 AmH5Brhda3jDz0tmy5k1D8KuweTHs7cdh07yFdmu43NnswjxogfJoCWeJjxK8mbuk6
	 L96tumRw4VWBg==
Date: Wed, 1 Jul 2026 15:13:42 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>
Subject: Re: [PATCH 6/6] ACPI: PCC: Preserve shared memory signature in
 OpRegion handler
Message-ID: <20260701-predictable-dragon-of-emphasis-50e5dc@sudeepholla>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <20260627-acpi_pcc_signature-v1-6-c1b7268d4fdc@kernel.org>
 <CAJZ5v0j5RtaadVjTLm7rghNiz_9b4_Rs4PPQZgAinud7tssgEA@mail.gmail.com>
 <20260630-thankful-organic-foxhound-a991a0@sudeepholla>
 <CAJZ5v0gt5OsgUHXDyt1D=090ZMoxWg_s+Cwjs-M5AkC8e806ig@mail.gmail.com>
 <20260701-hopeful-cuddly-bobcat-6a8cf6@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701-hopeful-cuddly-bobcat-6a8cf6@sudeepholla>

On Wed, Jul 01, 2026 at 02:34:10PM +0100, Sudeep Holla wrote:
> On Wed, Jul 01, 2026 at 12:44:30PM +0200, Rafael J. Wysocki (Intel) wrote:
> > On Tue, Jun 30, 2026 at 7:00 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> > >
> > > On Tue, Jun 30, 2026 at 02:33:08PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > > On Sat, Jun 27, 2026 at 6:39 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> > > > >
> > > > > ACPI defines a PCC OperationRegion as the shared memory fields that
> > > > > follow the PCC signature. The OperationRegion length is likewise the
> > > > > total size of the fields that succeed the signature in shared memory.
> > > > >
> > > > > ACPI 6.6 adds clarification that the PCC shared memory signature is
> > > > > populated by the platform and verified by OSPM.
> > > > >
> > > > > The PCC address space handler currently copies the OperationRegion
> > > > > buffer to and from the start of the PCC shared memory region. That can
> > > > > overwrite or expose the signature at byte offset 0, and it also misses
> > > > > the last 4 bytes of the actual PCC OperationRegion data.
> > > > >
> > > > > Offset OperationRegion copies by the size of the signature and reject
> > > > > regions that do not fit in the shared memory after that signature.
> > > > >
> > > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > > Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
> > > > > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > > >
> > > > Does this depend on anything else in the series or is it independent?
> > > >
> > >
> > > It is independent. This just fixes the issue of including the signature in
> > > the opregion data. It can go independently as all other patches as well.
> > 
> > So I've looked at Sashiko's feedback on this change:
> > 
> > https://sashiko.dev/#/patchset/20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc%40kernel.org
> > 
> > and I'm a bit worried.
> > 
> > Of course, the preexisting issues found by it will need to be
> > addressed separately, but what about firmware released before the
> > clarification in ACPI 6.6 and the possible misalignment issue
> > mentioned by it?
> 
> I haven't analysed all the report from Sashiko yet. But unlike other patches
> in the series, this one is not strictly to validate the signature.
> 
> Even before v6.6, the PCC Opregion didn't include the signature which is
> at offset 0. The code always started copying to/from offset 0 missing the
> last 32-bit field(word). Since v6.3 when PCC Opregion was added we have
> this in the specification:
> 
>   | <section> Declaring message fields within a PCC OperationRegion
>   |
>   | For all PCC subspace types, the PCC Operation Region pertains to the
>   | region of PCC subspace that succeeds the PCC signature.
> 
> So, this patch addresses that issue of wrong starting offset used by this
> driver.
> 
> Other patches I agree, it is more likely we just need to warn and not
> reject absence of wrong PCC signatures.
> 
> I will take a look at the other issues reported by Sashiko soon.
> 

Forgot to add that let us wait at-least until I go through the report
understand and conclude it is not fatal/critical before we can merge this.
Indeed a quick read concerned as much that I would like to spend time
analysing it carefully.

-- 
Regards,
Sudeep
