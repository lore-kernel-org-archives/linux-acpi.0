Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6A2D837C;
	Tue, 30 Jun 2026 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838855; cv=none; b=a5lBbX89mn2Khx5xsO4OnAmB2TK+BPwT9+/9icdH5WFpqLfvr7/Kk7Xeh1c6sbaKKhBDjvkH5PcP6cOhdp2EUkOW1ZEndBqrzC2zcPeg4feZWrom6V0aZfOHcCWQJJilLgkZnfWZJehLEp9zZx0pJQ2QUViO8qn9lbQu7zuehz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838855; c=relaxed/simple;
	bh=80ZF9ktzme3dHtQ+FRS6xVF/5lD+9DYskzTzHvjq84c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzYKwboRdXQDmP1ZnxBcdXiMQzeaANrBP8sv6OvREh5liJV7Z5/ASEy3foDJU2gM+6zfkwxQIm6u4zyYAJ1y177qfgWNp8e21PTHO+u8aFhMG1N6hj+OyunMeH+DFcJTiz/UEBy4LDB4DYb2ndeTMQTtwFi7ug6HqakX/jj6qQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3LBMfXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3LBMfXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1571F000E9;
	Tue, 30 Jun 2026 17:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782838854;
	bh=LJZUc/LPxt4hmacYCfiJlkWHR6rwA2I/k/EPyXnwNlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E3LBMfXdSOjlbvNGPKr/jWF0mRVQxuC0hO/p0inIbn7B/Do4J3qTn/zHxjvbuUkkG
	 FgA1q7AWtcAxduI6b/wuX/jQ9FzMrTkB8w15uzfaorK0IFx9Z8U7kLZse6uBPzSyV9
	 zCZ4AY5/F3zN/rnLLxb+ZCWdMuiqFNKBbAwgsHxcRr/zHS9etXXTJB3sd3wa61Vxtc
	 P7yub/09U/29F/uHOTAG6gAr8gYG2K1+YacmXaYdo5b3Oggrcm83rr3LgEv8/l+FPg
	 l7val0WPiRxuoWdumpaExcc1iZPA0swPVpCxMC7S5rpgwig0/F9FFTRe2+0NLub0kP
	 2IG8Za2rTBzOw==
Date: Tue, 30 Jun 2026 18:00:51 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>
Subject: Re: [PATCH 6/6] ACPI: PCC: Preserve shared memory signature in
 OpRegion handler
Message-ID: <20260630-thankful-organic-foxhound-a991a0@sudeepholla>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <20260627-acpi_pcc_signature-v1-6-c1b7268d4fdc@kernel.org>
 <CAJZ5v0j5RtaadVjTLm7rghNiz_9b4_Rs4PPQZgAinud7tssgEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j5RtaadVjTLm7rghNiz_9b4_Rs4PPQZgAinud7tssgEA@mail.gmail.com>

On Tue, Jun 30, 2026 at 02:33:08PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Sat, Jun 27, 2026 at 6:39 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> >
> > ACPI defines a PCC OperationRegion as the shared memory fields that
> > follow the PCC signature. The OperationRegion length is likewise the
> > total size of the fields that succeed the signature in shared memory.
> >
> > ACPI 6.6 adds clarification that the PCC shared memory signature is
> > populated by the platform and verified by OSPM.
> >
> > The PCC address space handler currently copies the OperationRegion
> > buffer to and from the start of the PCC shared memory region. That can
> > overwrite or expose the signature at byte offset 0, and it also misses
> > the last 4 bytes of the actual PCC OperationRegion data.
> >
> > Offset OperationRegion copies by the size of the signature and reject
> > regions that do not fit in the shared memory after that signature.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
> > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> 
> Does this depend on anything else in the series or is it independent?
> 

It is independent. This just fixes the issue of including the signature in
the opregion data. It can go independently as all other patches as well.

-- 
Regards,
Sudeep
