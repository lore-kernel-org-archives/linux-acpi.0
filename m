Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241241;
	b=nqhXW0plQtxJ7XhI1djcLuLl73bfP1J5XremKp8LIRqVhWBzMe8nixecrBUITIitg+Hz
	 e00yaPLAW1t9ZQyoW1EXQN08ddoR23rZYbdijsAQYyMcuZhMvm4V3KMVkotpiJAr3DLrG
	 kmxwK0WTB1wVpNCAYfc1Y3RHUtgOx41kkl4TjyDnq9PaMbsYzbXeFFkwwNXHhu9Uc69L/
	 giacZQzT5iTIbOgcQWZxYtWAPtnx0SfpDAcpIBYYWvMr2LjbzenYWKktJ0fDD3QAnOJ6c
	 pQNraXPoLIpk6hcwfmDs8vYIX661D000d2G03uHKEmn4chQJ8dzSSoQsSCVhqz76+fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241241;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/0Dk0uPlaTG6qaR2nzgxnAMSKVBZP51BhonP6B1XqbE=;
	b=PYOvJbmmuz/oyxhspAoTXnaFa4y+aIqBuw2jtAGqM7GO0x0NcD1BMe9ZuslOyU8N/lCK
	 qWY09+Gv08fcKPeQad+z2m2I7SItw42Tt6qK7n9DQ8qpLx+HH1VuWHk4xA23Rr7H8e88G
	 4cdymxgBqAA0w+TOqFJA3vtqJxz0O1NL2yJfyZSBtunuV1UDqmSjzNGNVo6u9PhfZt8B0
	 wjYqCkDQZnf85WG2gFwNZKTLMzlfPJG/3Eyc0dsuQbBOGJNfBcglqvnBObF2c3WBlwHTJ
	 10ToFCGBOtBpO979u/bfzegd85JwROaJjOladmEsXb7GcKw8j9ksu0EVnw4NQNfLlEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3gPrwc2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81014606A32A;
	Mon,  9 Nov 2026 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J3gPrwc2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6221F008A1;
	Mon,  9 Nov 2026 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794241241;
	bh=/0Dk0uPlaTG6qaR2nzgxnAMSKVBZP51BhonP6B1XqbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J3gPrwc2WmZto8H3leOdSAf9aaa7knSkZ51KnpOtMRNDpWI4sa+BSXjQe8vo+yFmx
	 hAVE6gMXu08EgqAj3+/Wwgng/DVvmYXGrQ5JSA9LzOEMCHAhDVxn9SPTfokOhN0oA4
	 LjaYI1E+pE7elf+ZABfzGIoeNavYDk7itmkBs3ourYwPEjEJU+SqsMJjaqpzI7Gn0m
	 cYkw7wZpukvfygJleF8B3jU1Ih0YDEGiNqX7WauppcyKRXqSs1xsdUzLwhghruBXZZ
	 rs+iNShfkvubFMqO3sIJo0dbZVbGwPo1y0g+cTsyufxObEe9gFMxV73yt2lUh832jo
	 XodiEzsVS/mVA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQS6o-0000000AXLe-2q7n;
	Mon, 09 Nov 2026 17:20:38 +0100
Date: Mon, 9 Nov 2026 17:20:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Subject: Re: [PATCH] software node: only let the owner release a managed node
Message-ID: <avHy1rt0Qb_IgpSs@hovoldconsulting.com>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
 <avHMhh8ChrFE_b_e@hovoldconsulting.com>
 <DMQQO3DTZE66.1Q2XGGDGN3WUP@kernel.org>
 <avHZ5U_YR9QSqd0G@hovoldconsulting.com>
 <DMQREV9DFQST.1Z4ZFOFTS0Z7W@kernel.org>
 <avHfx80pHRPwtqRt@hovoldconsulting.com>
 <DMQS3EURP5MB.2DY989AOI0CSD@kernel.org>
 <avHs9hKOc3QVLM4x@hovoldconsulting.com>
 <lhljpce4lyhuggmfyaq4c4g2mxqe5z3gwmqyrnxptlub3bahff@vdyh47ms5ua3>
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
In-Reply-To: <lhljpce4lyhuggmfyaq4c4g2mxqe5z3gwmqyrnxptlub3bahff@vdyh47ms5ua3>

On Mon, Nov 09, 2026 at 05:08:50PM +0100, Bartosz Golaszewski wrote:
> On Mon, Nov 09, 2026 at 04:55:34PM +0100, Johan Hovold wrote:

> > I've updated the commit with the missing Reviewed-by and Fixes tag. I
> > also decided to drop the reordering of releasing the swnode references
> > as that is arguable an unrelated change and the current code expects
> > users to hold a reference unless it's a managed node.
> >
> 
> Ok, I won't be sending a v2 then.
> 
> I'm not sure what the workflow is exactly among the driver core maintainers
> but the commit that ended up in tree looks quite different from what
> I submitted and what Link: references.

Right, and the three changes are recorded in the commit trailers (and
the rationale is documented in the Link thread).

> Such in-tree modifications from maintainers have caused problems in the
> past[1]. I would have preferred to apply changes myself based on reviews
> and send a v2 which could then be queued as it appears on the list. Just
> my 2 cents.

Since I've already done the work, and have the context fresh in mind,
another round-trip would just mean even more work.

If you think it differs too much or you don't agree with the end-result,
I can update the authorship.

Johan
