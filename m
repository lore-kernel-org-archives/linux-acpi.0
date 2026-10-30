Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372156;
	b=Hc4JZ/wNx7+gRtUrmPP4GPlS1gid4VDVf4pIg6fKPdDSWKH322YLxJEkYYt0V2DNtc1J
	 aiPZRqbgcgH+ad3+F9UErMIdq2SAQ3mgknttb0770WAZDoedYvSwLg781CVWYomKgb6hN
	 s6SFEIM5W28b3z55hSif9BzC2yQsoEkmNY0ip0B/pTRRVyoEgxaQU8k9MnW5ywnpu+96U
	 Klqk54ThqRw8vtH6bu/f7F4XpjK4gg+BWv5tRbnAQwKum0+0PUwkpBDO4+nzOKg8L7Ngx
	 TPArqTcUi7Aqpbl349HGARHvZM7gcl9ypYdbd0l/UCs55W8E4EoAdzv2kMyatlTpYEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372156;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=UPDjS3wz2FnEuT+HHl36XN/pNdhynLSDtb+o3kgPntE=;
	b=y+5UzHJjMR6UHbDu3VYBF3UBhbX2otxF99ywegvKYp34L+jkxQ7jOxTlDzbg4do3Xw0E
	 oykdt+Ib3oFBFmgXyH4vaKKfEd35t6uobd/ooQPmv7PgAEe24EAVkzSypJ4L2xbeTPgxm
	 w+61QHas6PlKy4KG39CIGP9N3oOye4KR3YSzT9XsHK6RegxxkD5D9z8/t3DVIFQCY3Urf
	 cFZXhcSjjM8UtTyNODA3QtuTdI14mlJkYyiAYGRDM6DZYoLB2NBVldR3ETlsz9eXlCpKe
	 DUTLMXg3ZZOKaxTi1rQV5yhzTZp0hwdHuSqxsarQQUAtsyfA3fiXhJSIikUJhyCBVUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEDO1U0A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FCE606A31A;
	Fri, 30 Oct 2026 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEDO1U0A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A541F000C1;
	Fri, 30 Oct 2026 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793372155;
	bh=UPDjS3wz2FnEuT+HHl36XN/pNdhynLSDtb+o3kgPntE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OEDO1U0A9019x18y1u9ZJ2cuYYEETpk74W//i7K8221GcVf2WSzoUg1t8nIOE4w4i
	 x6vTbaac+4XzUTlgecLH8JjgDdRhpVry/XWyabbeXOwKh7l1GMffT/bWaNHZsY4xT2
	 25nrsrEVMMEjlZ+DgEDboae2tDZvS1edWH9Tnb5NUg279jXWVYJWBjKNFlW8f7yFP5
	 k+r6tiJAZVzid1VKKI1b/QxqjVWLu4O+KdQV5vppDpw+6j6D6KNJMEHAe523zY3Rds
	 O+uoWMoPPkWdyBGyvkIB6bdyvmf6kIYQgOaznzxb40nPnwffHXKjSWQ2EXJAXuNKCU
	 4hRZgu+kQ1sZw==
Message-ID: <320e0bd0-fc6b-4b71-9024-55a6af558fa3@kernel.org>
Date: Fri, 30 Oct 2026 09:55:52 -0500
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: handle broken dGPU hotplug GPE on ASUS
 ROG Strix G513QY
Content-Language: en-US
To: Mike Lothian <mike@fireburn.co.uk>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261030075743.356835-1-mike@fireburn.co.uk>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261030075743.356835-1-mike@fireburn.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 02:57, Mike Lothian wrote:
> On Thu, 29 Oct 2026, Mario Limonciello wrote:
>> Can you please get an acpidump and put it on a kernel bugzilla or drm
>> bug?  This generally feels like an ACPI interpreter issue to me.
> 
> Done: https://gitlab.freedesktop.org/drm/amd/-/work_items/6061
> 
> It has the errors and the tables from /sys/firmware/acpi/tables, minus my
> local override SSDT.  I haven't got acpidump or iasl installed so it's the
> raw files in a tarball rather than a real acpidump, I can redo it if you
> want the proper format
> 
> On the interpreter question: _L05 is only Notify (\_SB.PCI0.GPP0.VGA,
> 0x81), and \_SB.PCI0.GPP0.VGA doesn't exist on this board, the dGPU is
> under GPP0.SWUS.SWDS.VGA_.  I don't know what the interpreter is meant to
> do with a Notify to a path that doesn't resolve, which is why I put the
> question in the bug.  Rafael, if there's a better place for it I'll move it
> 
> Mike

I posted another approach for patch 2/2 to the bug where it's a quirk 
outside of amdgpu (since this looks like a BIOS bug).

I guess test that and then we can see where a quirk would best live.
