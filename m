Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634BD3BB674;
	Tue, 22 Sep 2026 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078896; cv=none; b=h+8QO4ZjBOFC/+qwj9dF5ubuFtDJ+qrKeLxb810T05mtEb/z5AS2p/cEUhWdY+XAgPiRvLRS16g8+b40wjh+71dirioxaDw/jPRnFG8hA7mHvOAyQCINdL9hEEQjGGUABRyMZ5CEZDFQYTndMqIrunUpQ/Nxde0C5kofSygwx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078896; c=relaxed/simple;
	bh=0V9QC5n66fxyrdOYIu3O1xDoMNMpJyxrUXQCyoLIADk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5JHj1NOR2xh8zAXLB0zE2fyAhqJ+HredLU1wCUTttWcAxJSBHiSMn/zUVQI2TsZ2WkLtdnBiVzzmVBa1yUNXoxVSGTa93v3rm9iOBI1nW/b32a0E81PnbItbQZXsM1k2hGbr4eU4Zw+Td+ilyPu7bVvzOzQWpXvUvihtgkq/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+HMGv5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+HMGv5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD921F000FF;
	Tue, 22 Sep 2026 12:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790078895;
	bh=kXoL83CqDwawCQcGd4wj6mNy8UhWSLsG+qfCKX0fOHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e+HMGv5ypUo6olYaLz0UQBOEuJmYWFktyjpLYyVxtunfS2ShuLKW3M2avb+9GO4qO
	 BKbLeXBR0bQG5aX2pmlrtqwolsUVcvH3h1tJrs/xgpVvYMupyMmBFZgKxcaGqCYGqj
	 gIWpyV8+OLTyuG+L7VR5geeSdWZxMIwhEHRJblSj9WSaTrRuv6sOpHMQmkHz1GbWP4
	 zCKSW0zQxv+keerFrmN/YQkBdX6247xt9EgtXRechlKXX4GcuHHmReSMHF4CzmznE5
	 gOVnHxvn7dlE04/t7VCGZ2ZpMcpK7zAVU/o9ykkcj2WmsGxEUn74+LUPSSLG07Vo6+
	 iCb/9VqJp9NZg==
Date: Tue, 22 Sep 2026 13:08:11 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	acpica-devel@lists.linux.dev, Saket Dumbre <saket.dumbre@intel.com>
Subject: Re: [PATCH v2 1/4] ACPICA: Fix PCC OperationRegion command offsets
Message-ID: <20260922-lime-hornet-of-culture-5a1fff@sudeepholla>
References: <20260722131553.2117835-1-sudeep.holla@kernel.org>
 <20260722131553.2117835-2-sudeep.holla@kernel.org>
 <CAJZ5v0hdxtuEbFQdwRe=T+Q2xRki+uN9PP7PPw7AdW4Obe3fqA@mail.gmail.com>
 <20260813-demonic-athletic-manul-e1d7bb@sudeepholla>
 <CAJZ5v0gMU1NjMKgEUMW6cmU7uquPyES2TejZVQqkwDH5C6FWvw@mail.gmail.com>
 <CAJZ5v0gqo_n39PGnBkB-5ozE_dQyau4t=5OxvdnZxu4D+ivhHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gqo_n39PGnBkB-5ozE_dQyau4t=5OxvdnZxu4D+ivhHQ@mail.gmail.com>

On Tue, Sep 22, 2026 at 01:50:46PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Thu, Aug 13, 2026 at 11:13 AM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Thu, Aug 13, 2026 at 5:00 AM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> > >
> > > On Wed, Aug 05, 2026 at 06:46:15PM +0200, Rafael J. Wysocki (Intel) wrote:
> > > > On Wed, Jul 22, 2026 at 3:16 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> > > > >
> > > > > ACPI 6.3, section 5.5.2.4.7.3, states that the PCC Operation
> > > > > Region is associated with the region of shared memory that follows the
> > > > > PCC signature.
> > > > >
> > > > > The generic and extended PCC shared memory layouts include the 4-byte
> > > > > signature at offset 0, so their raw shared memory COMMAND fields are at
> > > > > offsets 4 and 12 respectively. Since AML field offsets for the PCC
> > > > > OperationRegion are relative to the region after that signature, ACPICA
> > > > > must look for those COMMAND fields at OperationRegion offsets 0 and 8.
> > > > >
> > > > > Adjust the generic and master subspace command checks to use those
> > > > > OperationRegion-relative offsets. Otherwise writes to the COMMAND field
> > > > > can fail to invoke the PCC address space handler at the offset described
> > > > > by the PCC OperationRegion definition.
> > > > >
> > > > > Fixes: aa6ec56b574d ("ACPICA: ACPI 6.3: add PCC operation region support for AML interpreter")
> > > > > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > > > > ---
> > > > >  drivers/acpi/acpica/exfield.c | 11 ++++++-----
> > > > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
> > > > > index 9a55524ed8f4..a7fac63938b3 100644
> > > > > --- a/drivers/acpi/acpica/exfield.c
> > > > > +++ b/drivers/acpi/acpica/exfield.c
> > > > > @@ -45,12 +45,13 @@ static const u8 acpi_protocol_lengths[] = {
> > > > >
> > > > >  /*
> > > > >   * The following macros determine a given offset is a COMD field.
> > > > > - * According to the specification, generic subspaces (types 0-2) contains a
> > > > > - * 2-byte COMD field at offset 4 and master subspaces (type 3) contains a 4-byte
> > > > > - * COMD field starting at offset 12.
> > > > > + * According to the specification, the PCC OperationRegion begins after
> > > > > + * the PCC signature. The raw shared memory COMD offsets of 4 for generic
> > > > > + * subspaces (types 0-2) and 12 for master subspaces (type 3) therefore
> > > > > + * appear at OperationRegion offsets 0 and 8.
> > > > >   */
> > > > > -#define GENERIC_SUBSPACE_COMMAND(a)     (4 == a || a == 5)
> > > > > -#define MASTER_SUBSPACE_COMMAND(a)      (12 <= a && a <= 15)
> > > > > +#define GENERIC_SUBSPACE_COMMAND(a)     ((a) < 2)
> > > > > +#define MASTER_SUBSPACE_COMMAND(a)      (((a) - 8) < 4)
> > > > >
> > > > >  /*******************************************************************************
> > > > >   *
> > > > > --
> > > >
> > > > Can you please see the corresponding upstream ACPICA pull request?
> > > > There are concerns regarding it.
> > > >
> > >
> > > Sorry for the delay in response, currently I am on vacation and don't
> > > have all the setup to validate anything. I will follow up once I am back.
> > > It is OK to miss v7.3
> >
> > OK, I'll wait then, thanks!
> 
> A new version of this has been applied upstream:
> 
> https://github.com/open-acpica/acpica/commit/57a2afa78dbe3580e19307aedd19f32388512094
> 
> so can you please rebase and resend the series?
> 
>

Sure, I will do that. Thanks for the reminder.

-- 
Regards,
Sudeep
