Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926F3ADB98;
	Fri,  3 Jul 2026 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071801; cv=none; b=eoeMWn+EeW/LeVbr84iMDKjEgo2/++2ZQL64LSn4VAior3/FxqXXR+9IwN2VyEoyzPkEZMolPrCHukhDcqbjPyDkHQYbfGdlHiM98NjxG7DpaplWmBqngWOSSgBjI88+8AZkHo7igf8SDK8CTHTLU1wCNyR4xJ44sNzZK5jASt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071801; c=relaxed/simple;
	bh=VReNymzo98m7Fji3HDXDZ67V0GqnFqJYQX18Kxdj35k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0PgD/aZj5P6ASoAc8UrC/CbG739aYxX1Xl3h2ZixDadnIYtx0MlUjoTfi3tjO3czw9SCaZPa9uad4DknTOdpP33iG4N0EfL+ERPW8XRYh+MbfPv45sW+XYMTOl5cW2Hnd3qtbif+nflmjJOdPDly+mdYFsRnha95y4xGDwXobM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9D7+C5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9D7+C5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4711F00A3A;
	Fri,  3 Jul 2026 09:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783071799;
	bh=Jl/LNX0F9c5ZLakltcdxkRYciVZAqidRH+eUQNM3t2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C9D7+C5Q0gdfl7m1VND10s22intgyJT3XKAN5kYdO7kL73GTDOwJ07LLmRW7PTGo3
	 VuIc3B4pB5Kd2Pe6zqvT0nQAqhufTgiAVt9dBuPgW2b8CXfuZs+fJUaDatfPjdc6Ae
	 dhi7jYRLUfGyXSynFyKiHDGNlizp20A4aXwQxQxkGSnkhdlYsg1b0rR0H0MkxI4zVC
	 QLgbV48qSBbz5kIJHncusJ4IM0y3FvhkUdfE5N3MlYePRfsQzuz3mAal5FYXOOgNmV
	 z4ioTcAU9v94PJpLh6iiCxTaLsx8mHaLD63VXpWGExklA3P+ItS+u1hI2W7AaMQ9CJ
	 zwMP7vo3Bn1Bg==
From: Mike Rapoport <rppt@kernel.org>
To: akpm@linux-foundation.org,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	devicetree@vger.kernel.org,
	driver-core@lists.linux.dev,
	"H. Peter Anvin" <hpa@zytor.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	WANG Xuerui <kernel@xen0n.name>,
	x86@kernel.org
Subject: Re: [PATCH v2 0/9] treewide, numa_memblks: remove redundant work during NUMA init
Date: Fri,  3 Jul 2026 12:43:09 +0300
Message-ID: <178306815065.2173096.9480193260074524906.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703041329.2797584-1-ekffu200098@gmail.com>
References: <20260703041329.2797584-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri,  3 Jul 2026 13:13:20 +0900, Sang-Heon Jeon wrote:
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
> [...]

Applied to numa_memblks-redundant-work branch of memblock.git tree, thanks!

[1/9] mm: numa_memblks: set numa_nodes_parsed in numa_add_memblk()
      commit: abdbd8329281f40afd381346410d6d43604af82c
[2/9] ACPI: NUMA: remove redundant numa_nodes_parsed node_set()
      commit: 7cbdade40fb8f440c13ccd7a02d104bf32285187
[3/9] of/numa: remove redundant numa_nodes_parsed node_set()
      commit: 3b1e5d902dfa832e4b175cb1f5a000236d45ceb5
[4/9] x86/numa: remove redundant numa_nodes_parsed node_set()
      commit: 63fa742bae02f0d2ffe95ff540a51837815abc5c
[5/9] arch_numa: remove redundant numa_nodes_parsed node_set()
      commit: 8b9cecbdc78c5a6cfaaf3b00ce7ebe05cf5417e7
[6/9] LoongArch: remove redundant numa_nodes_parsed node_set()
      commit: 3aeac07c5b1c3399487f4b38182f8cfbc3dbbd53
[7/9] mm: numa_memblks: remove redundant numa_nodemask_from_meminfo()
      commit: a9bafc1832d2db97813069823821ed333b8ecda6
[8/9] arch_numa: remove redundant node_possible_map assignment
      commit: f5a77a50a14dffb659ee8f550c824f8280e37fce
[9/9] mm: numa_memblks: use numa_add_reserved_memblk() in numa_cleanup_meminfo()
      commit: e55424c84afd48aa2f0f761ae0c006128ef541cf

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: numa_memblks-redundant-work

--
Sincerely yours,
Mike.

