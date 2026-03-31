Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04F4401A0A;
	Tue, 31 Mar 2026 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970301; cv=none; b=rWTVVY5GWsFoAP9bJFPzrE6VjxuVyt4LqKguuNuQFr0D5vlEe9V5UtcmNJLw72JMiVEUBdgDqDoblVbtF/Rgr4mL0cYCDW+BVpYo3TFjRErXX+yTMtS8pdQsefUgDWJaZM68ZSmAX9jScpge6rpucnLqfjgwwV3us4i/dUsvNqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970301; c=relaxed/simple;
	bh=VyTzyrxLj+KGvjgF3ugGOG6AOqnjvxWpFw7cTEiMl3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3NJTAXu+U8r5Oj2s8g//prlHWyC6/saKcidsmX8DlBntXTjxmjYMNUEpfI6wPUeIvjAWmp/eJ9c4H03grWF3DCZw8SLsQ6646275GKA03HoTLlLbajFljq2QpsCOHQbF+FXXvZzS+/zjPwlFGxJ+B22+AK/R51wgjPSzZ/1XDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Z17IberB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Z17IberB"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AF79F40E0140;
	Tue, 31 Mar 2026 15:18:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HEXG6Jv-8W3v; Tue, 31 Mar 2026 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774970291; bh=HIf8gyFX80uSQKCoWkQ5ZPo573gaG6x/O65jKZB5gh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z17IberBscI1nNIel2qnP2dKieE8Angtikowhd8wgkm/JnlHdoCe/RUlPPxw7dyJx
	 nePrSWXtzHAKzAfvLyykWFfOEc4+/vPcMwM83zNC9iYPdYwn4J/G1gLIuV/RRyLo8O
	 cXokxt/7rMbYC92jB+sn6IaCUTAlguzdNqi+suGBYj2LTjIp8LOIUEsS6VkHTlOttn
	 +Kfl7I0KBTYO3CNKi3E+67jkSbrLY9DzBReN2pt5hfiaiyBZYJxvjw4VDgD6JuDiuu
	 VX75wBEayTVozfxkP7Nz3nRP1pX2PzQGfdEoInEH4fKr77BsPqzflHTnYzZIAODdlr
	 qVNW01sIg3kDzj4b31WUQHkNONc5uCS5QF/cCOR9E1xGCBQ5pBM5oyvujNB9IgQFDn
	 wmBGHWcGc/hlxZcaU7CLUn/FMGLSPEvTifJrIBmTt7akASYYQqwSg5s07mxHhs/zLK
	 Rmq2uPj6IJn3SpucLkPXnqOI76PIlYGzikph8+AyYo5mDGoA2gYBZ/PpdtT47R8AW8
	 sWBNyZqnDW6r9nbzK/gx+wObyNPWhvBDnGmERN3AvphrNgw42Ydg5SnnXNxAEjMZ8T
	 LZ2X+A5zyhTvQfE6EvlE6gWGyoNKcj1HPsOUcu3s+EiKCpirb5e2x8HPrCPioSkR/d
	 pUSmm0Z9qeLeuqB79ERFpTCg=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9FCEF40E0032;
	Tue, 31 Mar 2026 15:17:35 +0000 (UTC)
Date: Tue, 31 Mar 2026 17:17:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Linuxarm <linuxarm@huawei.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>
Subject: Re: [PATCH v17 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <20260331151714.GFacvleugPydw71hxQ@fat_crate.local>
References: <20260311155518.1000-1-shiju.jose@huawei.com>
 <20260311155518.1000-2-shiju.jose@huawei.com>
 <20260312165247.GSabLvX5DjzhDtmyuh@fat_crate.local>
 <33a8a02f07184508bdff31e1053606a2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33a8a02f07184508bdff31e1053606a2@huawei.com>

On Mon, Mar 16, 2026 at 02:27:40PM +0000, Shiju Jose wrote:
> In v13, support for address range has removed for the code simplification
> requested with the expectation that a firmware will do the full node demand
> scrubbing and may enable these attributes in the follow-up patches.  I do
> not mind adding support for address range now or else later after first
> version of RAS2 code will be merged.

Right, that makese sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
