Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652DF35F165;
	Thu,  2 Jul 2026 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988767; cv=none; b=bCW3n5Iz3Y99Ifs4kMyr8QWo6F4MDCCgSXROBK1wTt1icXEd2Mj2bc5EOAsfRhEP80ggwFnLWJRszpUA8RUqsP32d6jB0DnalbzhfcvjZ0ZChRK9Q6z4jSmHHYvZVBYC+N5rcRQEbFvMnn/l2jPDo7zjOaabCq6hGkECiJpgrtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988767; c=relaxed/simple;
	bh=M3zCXTiKd0xTuXuc/XyUnoJt84FG38wsL6zfIQOJbSI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=H31IQYqibjc+jyzHZ0H+aLl9MHnUXK2TS8XILhPmKFiY/YSp3bnFLOyYVW47pzGxSnXLWSu5eFKQ7BGNMcgHnCYoGSL/ps4naXjo/PSAIEAewUWLxPQSRjgYyQ/qIHq19YUH9CMVQhPw72+hNtEfLpvXQ86nwbVfRJQjUpo55bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNF+9+zi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNF+9+zi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9430D1F000E9;
	Thu,  2 Jul 2026 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782988766;
	bh=qB0O4+vj8xCBDUmgP9F3sg9bDprAJ1KugUxJjWFYxW8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ZNF+9+ziJrQ/6Oo+8v3bgxvCQyRZ8P1F5iaOuNZ/uKew2EQ+sAZngVvWED4ce4fwF
	 Fe/abxroPGxbacye/03crZyJam9aGojqEZLXIIvXnjY0JJJEK26BBnj62LJbSolewG
	 bIujxYUL3dG+0T0ZRQ4PQFyp0s8mnMJSX/4KtdJ+CaplU3ABVFxEX5mA3Xq04xKWRf
	 EidbKv9svobjGJn03LvNx5x19jaiLuT+NUxvuN7zuZQ63krup2Jog8lpagtxX/d8dg
	 yhEfKlSXj/9LUMD7BjcE/glgXumuJIe0V/Zr9f9VtScxxmNwpwYgEiJY6YzdWZLaH7
	 iOwN/tvumnjdQ==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/9] treewide, numa_memblks: remove redundant work
 during NUMA init
From: Mike Rapoport <rppt@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Mike Rapoport <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 devicetree@vger.kernel.org, driver-core@lists.linux.dev, 
 "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, 
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, loongarch@lists.linux.dev, 
 WANG Xuerui <kernel@xen0n.name>, x86@kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260628135828.1393120-1-ekffu200098@gmail.com>
References: <20260628135828.1393120-1-ekffu200098@gmail.com>
Date: Thu, 02 Jul 2026 13:39:17 +0300
Message-Id: <178298875725.1436291.12024708198343441997.b4-review@b4>
X-Mailer: b4 0.16-dev

Hi,

> Every existing numa_add_memblk() caller passes a valid node id and
> separately marks that node in numa_nodes_parsed with node_set(). In
> addition, numa_nodemask_from_meminfo() recomputes the same "nodes that own
> memory" set from numa_meminfo, which numa_nodes_parsed already contains.
> 
> This redundancy implicitly depends on the callers' node_set(). So, before
> removing the redundancy, make numa_add_memblk() set the node in
> numa_nodes_parsed explicitly. Then remove the per-caller node_set() and
> numa_nodemask_from_meminfo().
> 
> Also, since the generic numa_register_meminfo() already sets
> node_possible_map to numa_nodes_parsed, remove the duplicate assignment in
> arch_numa's numa_register_nodes().
> 
> Patch 1 adds the node_set() to numa_add_memblk() itself, so every memblk's
> node is set in numa_nodes_parsed on add.
> 
> Patches 2-6 depend on patch 1 and remove the redundant per-caller node_set()
> from all callers.
> 
> Patch 7 removes both numa_nodemask_from_meminfo() call sites and the unused
> function itself.
> 
> Patch 8 removes the duplicate node_possible_map assignment in arch_numa.
> 
> Patch 9 is a minor cleanup, using the existing numa_add_reserved_memblk()
> wrapper in numa_cleanup_meminfo().
> 
> No functional change.

Looks good to me.

Can you please address the small comment for patch 1?

-- 
Sincerely yours,
Mike.

