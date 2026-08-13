Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B5B25A640;
	Thu, 13 Aug 2026 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786590046; cv=none; b=g+HVeFm4KsX9M8orzVCRj8nAVCSx+9Zyp/bvD0Y8CJ+TUQ3yOIb564JvYuV17O0aYoXc4KbBNJJgOk2R9gxmJUuurFI14yCTBVw+vov17ngUN2xwIhcUYo6z61VO0ehshkve5rCvIrzLqmcENH7nk1WkrsJ1gbS/qSRjwJaKcN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786590046; c=relaxed/simple;
	bh=akamRC5Khxl6juDPwoOhx1uQZAT00MUA0MLHl8xlD7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv88PpP39znBZMzf1C+zVRfO1BbMZSpM/nUBa5rAr+3UTfbfkaSnCQZ72gcIBpsDd1XvgEDa84UWOgukxYyv68PPrN1EPP+g9bj4NIJY6Ur5CCjXRGNqYbfP5oeq21hOtxp52WVGpbek+RcluyKB/h8oRABkUZ57/i0EU5qnE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1j8ad9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1j8ad9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56F01F000E9;
	Thu, 13 Aug 2026 03:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786590044;
	bh=HEqetFvLREVhBbA07DY/wNWM99zEIDUxIhyrlONiBuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j1j8ad9tu5BafBc/MHkedDvlGUvnMzqZXWy5aHTcwcD+HoDqOhgrxn+DTQbNH5S0+
	 It5NUFqfSkY4YxZgkRiLFo5DHIvhfO1gVCHPZ4/zvB7jo2TEoVMLMj7e8e/4vHFTUT
	 JHglu+1vDbFKpMdykNHmpMnFByvLBuPYuLT75B3xdD8qOxpM+G7cIRg4usLVauXdgf
	 LXIqOMbGHNgBkcncBGg0Bc0x4U7P+OBwDDGMXrgl1HHnIEY2EbLxGm3WEXeTGuAkim
	 D/Y7+AypjUi4A26hG4MMKfxbai0+MuN4pbGf/q1jOs5dICij8LNmHsrbv1PAy9Z+cx
	 9no8i23vc1OpA==
Date: Thu, 13 Aug 2026 04:00:41 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, Saket Dumbre <saket.dumbre@intel.com>
Subject: Re: [PATCH v2 1/4] ACPICA: Fix PCC OperationRegion command offsets
Message-ID: <20260813-demonic-athletic-manul-e1d7bb@sudeepholla>
References: <20260722131553.2117835-1-sudeep.holla@kernel.org>
 <20260722131553.2117835-2-sudeep.holla@kernel.org>
 <CAJZ5v0hdxtuEbFQdwRe=T+Q2xRki+uN9PP7PPw7AdW4Obe3fqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hdxtuEbFQdwRe=T+Q2xRki+uN9PP7PPw7AdW4Obe3fqA@mail.gmail.com>

On Wed, Aug 05, 2026 at 06:46:15PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Wed, Jul 22, 2026 at 3:16 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> >
> > ACPI 6.3, section 5.5.2.4.7.3, states that the PCC Operation
> > Region is associated with the region of shared memory that follows the
> > PCC signature.
> >
> > The generic and extended PCC shared memory layouts include the 4-byte
> > signature at offset 0, so their raw shared memory COMMAND fields are at
> > offsets 4 and 12 respectively. Since AML field offsets for the PCC
> > OperationRegion are relative to the region after that signature, ACPICA
> > must look for those COMMAND fields at OperationRegion offsets 0 and 8.
> >
> > Adjust the generic and master subspace command checks to use those
> > OperationRegion-relative offsets. Otherwise writes to the COMMAND field
> > can fail to invoke the PCC address space handler at the offset described
> > by the PCC OperationRegion definition.
> >
> > Fixes: aa6ec56b574d ("ACPICA: ACPI 6.3: add PCC operation region support for AML interpreter")
> > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > ---
> >  drivers/acpi/acpica/exfield.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
> > index 9a55524ed8f4..a7fac63938b3 100644
> > --- a/drivers/acpi/acpica/exfield.c
> > +++ b/drivers/acpi/acpica/exfield.c
> > @@ -45,12 +45,13 @@ static const u8 acpi_protocol_lengths[] = {
> >
> >  /*
> >   * The following macros determine a given offset is a COMD field.
> > - * According to the specification, generic subspaces (types 0-2) contains a
> > - * 2-byte COMD field at offset 4 and master subspaces (type 3) contains a 4-byte
> > - * COMD field starting at offset 12.
> > + * According to the specification, the PCC OperationRegion begins after
> > + * the PCC signature. The raw shared memory COMD offsets of 4 for generic
> > + * subspaces (types 0-2) and 12 for master subspaces (type 3) therefore
> > + * appear at OperationRegion offsets 0 and 8.
> >   */
> > -#define GENERIC_SUBSPACE_COMMAND(a)     (4 == a || a == 5)
> > -#define MASTER_SUBSPACE_COMMAND(a)      (12 <= a && a <= 15)
> > +#define GENERIC_SUBSPACE_COMMAND(a)     ((a) < 2)
> > +#define MASTER_SUBSPACE_COMMAND(a)      (((a) - 8) < 4)
> >
> >  /*******************************************************************************
> >   *
> > --
> 
> Can you please see the corresponding upstream ACPICA pull request?
> There are concerns regarding it.
> 

Sorry for the delay in response, currently I am on vacation and don't
have all the setup to validate anything. I will follow up once I am back.
It is OK to miss v7.3

-- 
Regards,
Sudeep
