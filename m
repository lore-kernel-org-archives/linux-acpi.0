Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317E3F12EB;
	Mon, 27 Jul 2026 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192258; cv=none; b=V5xOfIGA/GOpRhuNv48wR9nGtG01ik+Nh6BznEJOswotqECr0y9oVjfIsZc6SzvgT9lpg9nVptIamEQVLSmZPSxs/9dlo1Mdeal6e0d4rqVfQWfeDpgML0cBD4E30c1hI/fCVu3wjj0b13wDjCUlsUqDBvmWWDLRN9TuO+vKWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192258; c=relaxed/simple;
	bh=Vf9fD7HxvKRTMbdNFC1G1LowpHEoAf5FN+j4R6hgf4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+3FImYmd24/R4OddKRdWIYqy/YFa66wlvwyjmifXUxa6oIzmfE2gJ0HhzGbcrQjTjmfEQBOlW/3Yfs0C8b7ot09ZYqUFIdEorVoCvX/Z3GySzfu/i1ArJHGcfeX93372wxOXHRRdmRe0DwMDb4C8gPKVYxP4BuE5fhPuRBTHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/Hl7HGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/Hl7HGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FA61F000E9;
	Mon, 27 Jul 2026 22:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192257;
	bh=pr+yXJ1zx4RlPju5kOdUktz6qmzd6euktFiv0KaUpN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i/Hl7HGk8uQM91MvyyJgoBz/+ijmz5VmWHNnyYAUxYfXSkPKivRVEtRp8KInZVDHJ
	 3dH+pGFf+0jF7UOdNnzXswVqjt+Obi3JRbngQO/50UxhyvEGQqAHSpdzCjE/U0e0w+
	 jgu3g17VdveCbqK80mQqEb+DC+XwmQmAeCIyCJWtCLkLpc2j912Rq0UvBRiVD8uH3x
	 zJrcUxjL5xvS+LHaumTjKdshPtp/obqVRtRBxQWhVf1NrsU3KTj1WdbyQQEVN4Ujou
	 AQHF+eHQYP+HVMfmnSYW/ypgFxvJaF+KumIMzGPQLdDUe9lzYDPZvM1I66Ovh701K3
	 +UVuX8HxM/3xQ==
Date: Mon, 27 Jul 2026 23:44:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
 <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>, Srivathsa L
 Rao <srivathsa.rao@oss.qualcomm.com>, Ganapatrao Kulkarni
 <ganapatrao.kulkarni@oss.qualcomm.com>, Trilok Soni <tsoni@quicinc.com>,
 Srinivas Ramana <sramana@qti.qualcomm.com>, Niyas Sait
 <niyas.sait@arm.com>, Lee Trager <lee@trager.us>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/10] arm_mpam: propagate MSC access errors for
 __ris_msmon_read()
Message-ID: <20260727234410.1504cfff@jic23-huawei>
In-Reply-To: <20260723155454.1760823-6-andre.przywara@arm.com>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
	<20260723155454.1760823-6-andre.przywara@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 17:54:49 +0200
Andre Przywara <andre.przywara@arm.com> wrote:

> Allow the function for RIS accesses to return an error, and propagate
> read and write errors from the lower level up.
> This function is a bit special, since it can be called via an SMP
> helper, so the prototype must stay as void. So propagate any errors
> using the "err" field in the struct passed in as the sole argument to
> that function.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

