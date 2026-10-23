Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795240;
	b=M/bHWXwSQN2gwSJaNY/T4bazmtwl0m/hvonBaJjQ05aEWcjUgIgwBt77lbwDC/nj0cfh
	 GbQjr0w14UVoI4XT/ABClyOG+4k1fgW4WYl0bSFePA4wUkitglpawl8SCMErQd+xpVe+s
	 WR4txDs4CQ6wnU4DrViwQhnR6FIruJmz8kCocvnZyNN3dOC3XxyX6qCAlUauad8iyYY9i
	 PwTEnvfBHDP4Wu8SgYmKWe6KezFex7UqjBqq6SAOsGTLNJMdgglvkhXHlGBIcB8bSXJZF
	 e2N1lVSGIbVcpczPkbd6PQb8HmENhm0DvW2daO11DRlZRkiUJha/KFU6etAvqw79Vgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795240;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=toaJDSs62ZHNYBOfBOHKWkIdx7+IHlsjRBQrBLBAFDE=;
	b=w7N14hWB6sArk9MZef5FZldr2Mv8BPinIevxQALssaXWGXiNMf++Hb9zNtmwWQmrtcAU
	 9XgygK9Y3jqgg7+zfV5yVLj1vbLvuoniYt495NbyP0tw4wfOH7ChI2pBwY0BB/ewRmjmK
	 uIp5UUmLflFdN98x8xwDBh3oGjhXJ+zMQdle1ClSaH47fAGcEQVZMeVb4dTmfMsrNVlxd
	 /Zl2bR1pD+avxwrwI8LEdQwLNA6KIswYaOCBAVWxjrLaWu7ZiWQ6svlZ361SmmxqW+ViU
	 AMTNJbmYNYAvgMuH4J6KJS5u0BdO02GZHQdhD/aD5DoGBGMp4DcKAIXbY/gst54b/AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ea3kK4WE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F960606A31A;
	Fri, 23 Oct 2026 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ea3kK4WE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBD81F01825;
	Fri, 23 Oct 2026 22:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795240;
	bh=toaJDSs62ZHNYBOfBOHKWkIdx7+IHlsjRBQrBLBAFDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ea3kK4WEjuDq3KDnc9t7CEhlvCJXCApwvtLbMUVJUoMYUvWGbI/udd7sr5Z+v7YQc
	 vO4HhHEK5qgz7080ok/JUUcQozb2i307NRB9LszUvd0/D/RFWI5RBNDhztb2ajOy6G
	 PlpWuwh2E/uzjh8aYLbkp93svf7TTvBr+aj38yRSjze1pTCVqdoxHSJPHgMAyVijzv
	 RP58s3+3UxJWyS7IG/OHY9jGDytD9zJIwbNxg46mX9qPZPkAkdWJJPTGPDO4SXlWq5
	 8yp8jXgwLgHM/J/7qORCeGUN1qdHqbM2zyzwEZXKK5bNPzLuL3RWMVWCYjVTIRO0Nu
	 s6PgQp7Z46EOQ==
Date: Sat, 24 Oct 2026 00:40:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, Tony Luck
 <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, Mark Brown
 <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue
 <xueshuai@linux.alibaba.com>, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Breno Leitao
 <leitao@debian.org>, Dan Williams <djbw@kernel.org>, Terry Bowman
 <terry.bowman@amd.com>, Ard Biesheuvel <ardb@kernel.org>, Morduan Zang
 <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev, Ashok Raj
 <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/6] CPER: Add Memory Error Section 2 support
Message-ID: <20261024003917.283b890d@foz.lan>
In-Reply-To: <20261023142621.00007051@oss.qualcomm.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
	<20261020101048.00000186@oss.qualcomm.com>
	<0817615d-5e96-4a3a-b39e-3e5d1b88e716@arm.com>
	<20261023142621.00007051@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 14:26:21 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> On Thu, 22 Oct 2026 09:07:25 +0200
> Pierre Gondois <pierre.gondois@arm.com> wrote:
> 
> > On 10/20/26 19:10, Jonathan Cameron wrote:  
> > > On Mon, 19 Oct 2026 22:38:39 +0200
> > > Pierre Gondois <pierre.gondois@arm.com> wrote:
> > >    
> > >> The support is mostly duplicated from Memory Error Section handling.
> > >> Other than differences coming from the content of  Memory Error
> > >> Section 1 and 2, differences in the support are:
> > >>
> > >> - v2 do not rely on a compact "struct cper_mem_err_compact" struct.
> > >> This structure was used to support older versions of the Memory
> > >> Error Section (1). This is not needed for the new structure.
> > >>
> > >> - The compact version is also used by the tracing framework.
> > >> To avoid relying and propagating a non-standard record format,
> > >> through trace event (cf. extlog_mem event) the new trace event
> > >> prints each field individually.
> > >>
> > >> The last patch of the serie was only build-tested due to the
> > >> absence of relevant hardware. apei_mce_report_mem_error() and
> > >> arch_apei_report_mem_error() implementations were also removed since
> > >> last version.
> > >>
> > >> It will also require a proper handling from the rasdaemon. Applying
> > >> this last patch without rasdaemon support will silent the reports of
> > >> Memory Error Section 2 error, cf. ras_userspace_consumers() check.    
> > > Hi Pierre,
> > >
> > > I'd slow down a bit.  We are mid merge window and convention is normally
> > > one version a week or so anyway.  Better to gather up feedback from
> > > a number of folk and spin only one revision to cover it all.
> > >    
> > Hello Jonathan,
> > 
> > Ok sure, as the v1 was reviewed quickly I thought there was a chance
> > of having the serie accepted quickly aswell. I ll wait a bit more.
> > 
> > Thanks for the review,
> > 
> > Pierre
> >   
> 
> A general question that came up in a related thread with one of
> our RAS architects. How does firmware decide what to send?  As far as
> I can tell firwmare has no way to know whether the OS understands the CPER
> Memory Section 2. 
> 
> So options that come to mind.
> 1. Firmware must send a CPER with both Memory Section and Memory Section 2.

Please don't do this: this would require either Kernespace or userspace to
discard one of the reports, only if the other one is there, which can be
tricky. Could be done more easily at userspace, but only if some database 
support is enabled, but, at least on rasdaemon, this is an optional module.

> 2. For whatever other reason a platform knows it doesn't work with old kernel
>    so can assume support in kernel and hopefully userspace got updated too.
> 
> 3. We propose some additional discoverability (quickly - code first) to ACPI
>    so that it can be a negotiated contract between OS and firmware.
>    Until the OS confirms it understands Memory Section 2, firmware has to send
>    the older one (or risk the record not being understood).  After that
>    negotiation it can do what it likes - probably send the Memory Section 2 form.
> 
> Option 1 and 2 are ugly at best.
> 
> Obvious path to me for option 3 is an _OSC like the one for generic initiators
> that we discovered a need for whilst implementing that years ago.
> 
> Anyhow have a better idea?  The above doesn't solve the end to end problem as
> maybe userspace still has no idea what this new tracepoint is, but at least gets
> us past hop 1 (so through the kernel). 
> 
> If we conclude _OSC plan works I'll draft a code first proposal.
> 
> Jonathan

Regards,
Mauro
