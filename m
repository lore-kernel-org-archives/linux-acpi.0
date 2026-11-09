Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239738;
	b=hU/YZEs+9S7oEaM3adTCu7QH4h7wXVAEekX3BSvt6m7Ekq2WTnYdCo36QG6qv8ajaQqy
	 39j9u69nF80c77AXrGNjPw8C3AJBW+38zSr7emJs/Pij51bMmQ8+gDNnzUY9dnL4U5BCE
	 1yBaX0DIjJx0MxwOW29XENxCW8N8LBHAc7o1ogGmeWmGf5wGkCvpmUfM742iGnl+y9VPl
	 giTK8E5H7DWKloxdCpTZRl/bKlhnZQ0YKxV1X5agoVwgkLyvJ55xBdtEElSqlpbQPivkO
	 gblXyuehE2pj/mQgluBvxb9Gu4tD8DmiiPvQt4LTU4G22eVG7w5xNWsYJTybqagj+DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239738;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/2hDZvu5IDKTr5dLPiIf2Oa0od0qY863w2cYiK9JPBE=;
	b=pMm1KcY8kNbZRJ62bvPslnlKoTMgFDjgM5xvD/VGc4GS5OXaH1rsv+VXrQdijLEm3HqO
	 Dn9ChDJ4D9P87QVqCG16e2z8SLDKKy7DjBDwm9DagsqfSLpKad+51SpoxaXIQV9dppi7z
	 44Pp94d/CZ8lwl/Y5rvWtF+cqCA8t3139c0r+noX1NXpG2QMGym1fsZkie3M1L68MPvp3
	 sd7c/CTaHUfU8KHSE2zefqrmP9NST0NyRs5lgbz1cDAOKZ82AX0YCCE3IdvqPZ/SlNxMB
	 gPm2REEYRnLqBPDFNF1k/ZgNVtbDoDeFWubUoj8wyOVJJnufkIFAJSQYuA0iMo9/wFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZU1k5P5r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C359C606A31C;
	Mon,  9 Nov 2026 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZU1k5P5r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDF71F008A1;
	Mon,  9 Nov 2026 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239737;
	bh=/2hDZvu5IDKTr5dLPiIf2Oa0od0qY863w2cYiK9JPBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZU1k5P5rFOrwyhMK6/lmpmmiLCcf0AIa74/fZns7V5SeIhdN7EreZ6Z4dxyOPCGZU
	 KXqociUOfKJdxYOLzOHPn/Py4Zh0dwUKCCF3VolpA66bcrZANrgwFGnCmtECHKeTy3
	 AyfQakXBn0N7/sIR+DwAyJr/VdcmDh0t4yujO35Wn/YSKonkEPGAG17igeOxa9I4ul
	 C+H90bJ5k08l5YYXUMO7rURDZ5BEr602IBYoofQodDgbV/018iQYfu9B+DY17zTyKj
	 pjeWuacr+M7i/bUlBfmijMdT0vUXb8767lK23Q0ieCMs3kPVW5hE5IUEr9JZkwu1Hd
	 6i8nmtvODhOHw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQRiY-0000000AHHl-2f2c;
	Mon, 09 Nov 2026 16:55:34 +0100
Date: Mon, 9 Nov 2026 16:55:34 +0100
From: Johan Hovold <johan@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Subject: Re: [PATCH] software node: only let the owner release a managed node
Message-ID: <avHs9hKOc3QVLM4x@hovoldconsulting.com>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
 <avHMhh8ChrFE_b_e@hovoldconsulting.com>
 <DMQQO3DTZE66.1Q2XGGDGN3WUP@kernel.org>
 <avHZ5U_YR9QSqd0G@hovoldconsulting.com>
 <DMQREV9DFQST.1Z4ZFOFTS0Z7W@kernel.org>
 <avHfx80pHRPwtqRt@hovoldconsulting.com>
 <DMQS3EURP5MB.2DY989AOI0CSD@kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMQS3EURP5MB.2DY989AOI0CSD@kernel.org>

On Mon, Nov 09, 2026 at 04:17:33PM +0100, Danilo Krummrich wrote:
> On Mon Nov 9, 2026 at 3:59 PM CET, Johan Hovold wrote:

> > So I think we can just go ahead and fix this in driver core directly.
> 
> Ok, then I agree it is fine as is. :)

Good. :)

I've updated the commit with the missing Reviewed-by and Fixes tag. I
also decided to drop the reordering of releasing the swnode references
as that is arguable an unrelated change and the current code expects
users to hold a reference unless it's a managed node.

End-result is here:

	https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/commit/?h=driver-core-linus&id=f8623ce596492d2e96ca57eeec992938d3d79f00

Johan
