Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570C3CD8C3;
	Wed, 25 Mar 2026 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439634; cv=none; b=fofFATU7yQFPvHEI3/VLcCrOf2kp13B5y776g0T2zZFBGldJbqiCogwAM2eYVr9YGbWJSUgk7fQaclaAWMWCCamIa6s+HWYc3OKBlqcFFK+wR9KYRjJLTkcx3xof0fDbqtHID1uDn1yV6wT1/69gPry/3JR2GYI6og4G0qc1igA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439634; c=relaxed/simple;
	bh=q7sdXYTH6G0hCZF8EhZUSwX64woUGHD1B0KGCD2819E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwtVa1uXHmlKsOWgeOwXE7dHc68dHZ9+EMs8wzSPwNPVBhNxN63wJp4rdPZawNTJzjXFcRTczgBsnYvZdrAS8bg48BhpFJMzveu8LUX2NvRWuYDAHVI53pwhzbJkvAwMkt8S/h8en0lmmlm8EBWSTusZRmCMUsrsYNI+sJtVWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5p3H55w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5p3H55w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB62C4CEF7;
	Wed, 25 Mar 2026 11:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774439634;
	bh=q7sdXYTH6G0hCZF8EhZUSwX64woUGHD1B0KGCD2819E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5p3H55w91FEElEk86870641UUYkG5L5HPvw2yqk1g9VzQmA4iJnwlI/dmM6aEJws
	 MrlT37+dmAnM4srsLiljKxSbWqlzOCQlu05g+TtFa5wV2C1F5LSg+r+9UZoAedJOsE
	 28jV8Wz6rN7fx9ZvUvFBkbn+jlfB4aaL6iFHM2hW2Vjx/zanbe3Xzb5EiAVR7TsoNt
	 PDbJTfgx/VrzSm/mjG1/o/yH+S7MfBkixmsnb6OUazXfS+2o4JHafDRovJr73jA3kM
	 D8rPUEy7pIGMi7WuEToBp3p4uSCqMNVDULHgjkVFkuRxQi9c5MagRX62FJKNW1GF9g
	 HkmoVhlZDh6ng==
Date: Wed, 25 Mar 2026 11:53:51 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ben Horgan <ben.horgan@arm.com>, lenb@kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v1] ACPI / PPTT: Remove duplicate structure,
 acpi_pptt_cache_v1_full
Message-ID: <20260325-laughing-coot-of-piety-e2bdff@sudeepholla>
References: <20260324113300.1002569-1-ben.horgan@arm.com>
 <20260324-nostalgic-adamant-coucal-7afd8b@sudeepholla>
 <CAJZ5v0gn5NTdSj=i5iRpK03kT0V-UshADp=VaaEAO=wzLsjjUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gn5NTdSj=i5iRpK03kT0V-UshADp=VaaEAO=wzLsjjUA@mail.gmail.com>

On Wed, Mar 25, 2026 at 12:45:27PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 24, 2026 at 9:43 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> >
> > On Tue, Mar 24, 2026 at 11:33:00AM +0000, Ben Horgan wrote:
> > > acpi_pptt_cache_v1_full was initially added as a stop gap until the
> > > equivalent structure imported from ACPICA, acpi_pptt_v1 in actbl2.h,
> > > contained all the fields of the Cache Type Structure. Since, commit :
> > > 091c4af3562d ("ACPICA: ACPI 6.4: PPTT: include all fields in subtable
> > > type1"), acpi_pptt_v1 contains all these fields making
> > > acpi_pptt_cache_v1_full redundant.
> > >
> > > Remove acpi_pptt_cache_v1_full.
> > >
> > > No functional change intended.
> > >
> >
> > Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
> 
> Am I supposed to pick this up?

Yes please, IIUC we route only drivers/acpi/arm/* via arm64 tree in general.

-- 
Regards,
Sudeep
