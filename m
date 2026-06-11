Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E442C21D9;
	Thu, 11 Jun 2026 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168433; cv=none; b=MtpNFaOkakRBgILT6HvW55h0ujxxUDEA2J863N7w2Os6VArStQnN2jm+vwCllbxY12OivNqqYT6XswQYttnTzf9wEEwWfVSrvJfLrfrfK3x0DIkBbWM03RHHVM5i3+CYmcJaPfWikB8j7WQqPzvByhr0Eukb4yWsxBfraPAXzxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168433; c=relaxed/simple;
	bh=1M5gUjbpW3qDXO5PZ4+Xq+o9JfPpWnNpLMac6opNScg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcJtuHw+w655DmWuSJIQAR/tjYBWgLsFQqyft52tKyNvdtOrzgFowjpr3uJ3NjLHMmTmT/mhSvSHQwwiEdsbnab9LJ3qoTyCtTDVI7WfN54LunliUk8/2E4criybcUuwGYu/XcfpvN6x3gmiGMjQ98o4WgVwwJSMKfr4r0qlYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf9ub8+B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf9ub8+B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186571F00893;
	Thu, 11 Jun 2026 09:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781168431;
	bh=dBiQEyPYgAL0tseH1DOFeKLkbItEWq0+K9vLt73dVTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kf9ub8+BMhfxHSSrYb31ZlyIkUI00iNanropMQakz2F7cdTEYJwi4BZyIu9g2qLzT
	 NAzAyfORVXc/VXPhIsLPZXcp5qYByR74xf7Y/hXstMtTZ9jSnUasCvvbLXj/odVkjk
	 zC+1Fz5dQN88PaAMa8fHTvZf6DzVXfKzdg3/OWkWEYONwhzBNeTTHD8DtWsV1pVz5i
	 f2tC8HgeZRr+znQr5qhxeT4IdkKGvmCJJJoOQDZ2WQrpygnIc1i3Ut7P5XcPLp3UWn
	 SMs+XyHVH9UBKPfyJcs05y1kBY44Dm2+Mj5fwnqDVrCwIxbk4o4eG5Cg/UkxaQZ1Mj
	 c2BmaPxzet9qA==
Date: Thu, 11 Jun 2026 12:00:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, kernel-team@meta.com, corbet@lwn.net,
	skhan@linuxfoundation.org, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org,
	akpm@linux-foundation.org, rdunlap@infradead.org,
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
	elver@google.com, kuba@kernel.org, ebiggers@kernel.org,
	lirongqing@baidu.com, paulmck@kernel.org, dave.jiang@intel.com,
	jic23@kernel.org, xueshuai@linux.alibaba.com, kai.huang@intel.com
Subject: Re: [RFC PATCH 1/3] mm/numa: add exclusive node pool and
 numa=standby boot parameter
Message-ID: <aip5IWmxg9CWg8hQ@kernel.org>
References: <20260610014517.253609-1-gourry@gourry.net>
 <20260610014517.253609-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610014517.253609-2-gourry@gourry.net>

Hi,

On Tue, Jun 09, 2026 at 09:45:15PM -0400, Gregory Price wrote:
> It can be at times preferential to logically split up hotplug memory
> capacity into more nodes than are described by BIOS at boot time.
> 
> However, if nodes are not described at __init time, they are not
> possible to add later on.

...
 
> 1) Can we do dynamic addition of nodes?
> 
>    Not Trivially
> 
>    Some services utilize num_possible_nodes() as a static value to
>    calculate the amount of resources to use at runtime (bpf, md/raid5).
> 
>    Example: futex_init uses num_possible_nodes() as part of its
>             hashsize calculation during __init.

AFAIU, we don't add the additional nodes for generic hotplug memory but
rather for exclusive use of by drivers/applications that are aware of these
nodes.
Wouldn't adding them to possible nodes actually skew the calculation of the
resources by the services utilizing num_possible_nodes()?

With the futex_init() example, won't be hashsize scaled down two much
because we've added these special nodes to the possible mask?

-- 
Sincerely yours,
Mike.
