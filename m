Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92247AF6D;
	Thu, 13 Aug 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628828; cv=none; b=q3LuRNoyT5w5m0vcI4SjOljjdGwwKlHkQry9p5NTo9UlRUMJa5NYQSJWLH2kAJ/BeNpnEPnoDeOaZ8/SzyQ01kc7l1X3+Im/Y0zbumtYNaLvC6HAoMNimGhv+Js5Yr4wqk+tt+neYmW90Ao70gYEgdMgU8x7eKFseYpZOu4GC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628828; c=relaxed/simple;
	bh=t4gwTXbKOa3d6d1IbiyhWTHm4k2wZ+WZSKUzzEMygzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDjboPcWPsSLExb0HoGfGOx59PXnGIVKoBM1fSA2WmZoJ5vzRExYfg4pNUv04AkgbHEUVZr73I5hFH8QyFo5aP4JlnhnBMNzSUmrb4QQb6fQEdSchyAfC1gVAFZpv8/CEU40QlnzQzmcOgKPGeDMmSaQfMlNVyL3QyZLOPO3qWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OOwWXTv/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OOwWXTv/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UDH74oYvqeDV9mh6r27tpGk1J6b++832lVnfnB6EKPQ=; b=OOwWXTv/j6LkNKfdMEy+Zdhvs3
	f808oZkgok4FagaoUlT36dw8nE93HbnD0jpdN3ezHFD7KZnhUKmvmikhFR3lgTTko1864Fzy5OYLN
	gzrNCasQNz9k1T7Nrt/n03HBh631ZKbI2wwG4O9OzakWXrMn8ic35CJr/whnnyAsCdX6tMhiigexc
	ElYIrYAm8zOu+Tvc0zSdG3ud4jC4BO3iIaHV13O/scjBMNoSzldIZzW+fMOYxy6VB3njO/wIBYkvD
	9kyZXfUPY9dpJR1Meh9JrI9YJr4GOP1p+i/xpSpnMC/Jcoh/FW03E2w11eDYxm48NwP3BRdi947k/
	LDA1OH5g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wuVlo-0059Ui-1h;
	Thu, 13 Aug 2026 13:46:56 +0000
Date: Thu, 13 Aug 2026 06:46:51 -0700
From: Breno Leitao <leitao@debian.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Saket Dumbre <saket.dumbre@intel.com>, Len Brown <lenb@kernel.org>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Bob Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, catalin.marinas@arm.com, kernel-team@meta.com
Subject: Re: [PATCH] ACPICA: Fix memory leak at acpi_ds_create_field()
Message-ID: <an3KsfqHv9GirRb7@gmail.com>
References: <20260813-acpica-pcc-field-leak-v1-1-3d6c5f0eb557@debian.org>
 <CAJZ5v0isQYRN9aZCmWty-kZpjHvZWyJT2AnRXs9RDszy7b5TkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0isQYRN9aZCmWty-kZpjHvZWyJT2AnRXs9RDszy7b5TkA@mail.gmail.com>
X-Debian-User: leitao

On Thu, Aug 13, 2026 at 03:39:37PM +0200, Rafael J. Wysocki (Intel) wrote:
> > Do not allocate a region if it was previously allocated before,
> > preserving the current design, but, not leaking memory.
> >
> > Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special context data")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> As per Documentation/driver-api/acpi/linuxized-acpica.rst, please
> submit a pull request with this change to the upstream ACPICA project
> on GitHub.  The Linux patch will become applicable when there is a
> corresponding commit upstream.

Ack. I will do it. sorry for the noise.

--breno
