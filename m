Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801520;
	b=Ild8Z1iZz1NERTw6OKIb7rNr20XIeG3OE8fTd2XwYyesHYxs/E/bV9RFHga1Ztf3O+RP
	 ulJRTni7rXu0bBdbEwhe0cfo13J7KgXHqmyA1B+BwrAXsAbKxfA+vK3WypgNJdK77cZ29
	 NeoDL16o+hfCA6C008ptF7kco1kVhBaLfsYDWfFudHzECmWfiU9wMDHfQArWSVOefkJaD
	 NGo+xHJvljcQ/mhlKbdShQR8IVgn740HalFdsrB2SNR5HLtMP7UE/6rIvKsrSR/XF5htu
	 X4EV2sTvHKDswFn6kufG0MWeLi6thH19z8Q/vGpdW2/p51+taKA3bvn8RYr+S7YFIGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801520;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=MMWVTiYySN/YnHLhPrOXJNVaMw6URBgOauzzaoHSZEs=;
	b=rMpNLxPdebvTFtEULYuK2BLFwIn5F+9SPEegg4uhr/5pDprT6FMP3Sf0yiks9ERK8jPQ
	 V0zAtojZKFTbNxXpIqNgtaNb6hRM+qpTEoyFs+qIPlN+8ERO4YSvtIDpVNMnwd/NwAb1v
	 qduWOQ51l+UPHk7bSzPIfinbYZHwxBBXf4mx9GusZmJKkKo3xx5mH/cupmHvziW+GWcgg
	 uuvzb1P8XnuJx/NYCn7Gcre6mit3uRw/0eqvWj2ekY1YAbUfbg2O9Aup1ndtGWs/Lji+D
	 /5dUsNeguHYfW/4X3evTsz306FJKvkPomVq3sU9f68MMv/yqkkzI9YrcW4lKHDyM2Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=T3XKdcIZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="L/94LFZU";
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516FA606A337
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 14:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 516FA606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=T3XKdcIZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=L/94LFZU
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 44B291D00124
	for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2026 09:11:59 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 04 Nov 2026 09:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793801514;
	 x=1793887914; bh=MMWVTiYySN/YnHLhPrOXJNVaMw6URBgOauzzaoHSZEs=; b=
	T3XKdcIZwfdA4MhJKZo5U6IeN0CN8DPPaHbire/z4sny2f2c6/LbuonClcj4MLCX
	8su/bxZitxSI4h/RgpJbkx5RK/w9Jq4Av1A3OnbA/75AgY2ngT1hvjRkWtrA7dm4
	5FLO0GmUR54IztVe441xKmqZ2mXdJwcAniW07wU/pRVJ07XSSDdz8ADxkpuJquC2
	Ze3dBct3QEzeBPGSxS+7lVvR8/jL4iziRKnrNd2KAZ1A1c8jrEwRdvJ5iselm/5n
	Sr7sFD198qk78z4pgHnnhMATIFLQgfRbCu+Gz4GL+/rcgi5mJFPQV8DOeIxveLdj
	wlkalKfMdBQ7/f3GECTA2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793801514; x=
	1793887914; bh=MMWVTiYySN/YnHLhPrOXJNVaMw6URBgOauzzaoHSZEs=; b=L
	/94LFZUrxjmzKBlc2Kh6HMCliQh3SnVtG8c6PGX9uRbw06gE/3qrDefTPPxR9glL
	OISzglksdQNJInSspjW/OVnDuV7XWe1h8mUei/Lq3XmsGKcqLdaYRpmTQniPBL9U
	/WJKSoBVDR6ZhY0gW8lzd6lAog5dEcheH1F5tP7SvNcUPMdfTRN3iNewEuqxJKMj
	NyAzKGTYhsYcjF8K7WOxNQkpY5VVrZmXscT4F/BtFgsZH2CbGxahE1uVcLSGrsF3
	As/o/AHnQaiB+XZ0M/Wyadzb/R7+3fv0bp2lUXhcyQbVJRRE5f0G9zAINnmj8y7T
	lqmAxqEAVKrZQRtsvU0wA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793801514; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:RNAsxYsI7fXQtU1vra30D1OIssn+sesApw1xEErCQctiXrB
	PDqUf8d2QTsBevcy/nnDMJdfpeFQL/6bk+tZjwpzzT6cS7SI95hsF1Jf94od9eUM
	H6SOTzgJaBzVmoLxVmfg/FShGFpLeOqvSSQg+EpzvuX6H5/nKqCczRH+7N4mJCyY
	aoaSt0Onlk1zRCTqOUiqj/vtWuetuRtEX+k39sZMMqcZpjSi8riDvzm1FDaiq6zy
	aoHjRd1+Qd6a12dGLtIp5xTSMHGlGKEXTtQMbsOIFWzPnmCW6KtxP6+drMtBrs1f
	PdHThSRc7E5AR21wq+efZBPXSsy72rlpfRfB6hg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rZnK72iMjvv6jIjMEqduetaZvti3oRxlCUbvStSJr9Y=:1obgZage1BwKsFYqKNxIw0FZOWu36x89nMtVfUAEpCs=;
X-ME-Sender: <xms:Jz3ratQP7KqKhADeRJgt7TiR88GIE0sNKmHL7xp0ulxWAu9MRB8OOQ>
    <xme:Jz3rahkJuicp_MW9tBer0d5mNQM1qV0xdan7bhFdbODDe-oad9XFf2owQkaWSrXi1
    BDN2gSjWEgRDT5Zm_0Qaqmsf8T8NVjJkQQcDFOizpbPyIwZ3p0619I>
X-ME-Proxy-Cause: dmFkZTEi3naGj3W1tsqJOxV/o/Q+r58Q70IZIQekMXN4Ud/y+F4BJx0mjacTd5VN+HMz0O
    vJ61+nEZTTcgo94iEs7TVSgvLcgzVjqOXThKpPWuLjGvyU43s/tMfhd5vayjfAXVbNtBHX
    CUXCOdxBw444qJYRt5R1sgkCysRJqjcBsX4z6o08D3dmteiKYAqf67vKmHq1/Lb7DcD/Qa
    uskEUNupOzaxnrmG9Jmb5Ku4FoTJzln5hkkMz00xrCRTOR81ooo5+Nl7qoA9h9J3uEKYIt
    5tvihw0HWvbxa9jTRU+0z2XExZqlTJ5nGekh76WPRNgT4CVjosTiGS+5Y/xrPiOjWFDCp9
    IIVZxbwpTekcL0BGoTNvlry7SoM1xpDE8Dra+u7LOvhmgy5LghRUgN2TyZnSNkFi4jBMB2
    DxXo01rYlM0QXlLHS4MBSFcb/ibrpDvICChOVBuWe39tnR7pLnw3QqUiZxFBO6vB472vdr
    iK7L1+gmgi2exPhID1ed/FKKjFtCioEwJcmN7ex6TTGtFmEpw0b47f/WwvqsSIKwbkJnrf
    IxOwxyCR8sAXA2cvccsnBbw4Ja5JtGf+gvE0mCbrHDj5n9xO42tj49VHEt4k+MMRaPJYiQ
    snJsVHGvwFqtzc3UkuLVlV3J+/q/3w6iLU4K61ISSZgsGRgX7/J2lecEgGBA
X-ME-Proxy: <xmx:KD3raiy6hv_L9Kmb6PMV30-m4bbqAp9D_q2T6kPxKpTr8dHDyMYtbA>
    <xmx:KD3raq2z_Bf4P6w8v75VFZvHTiC9zoV578CeBF3MDD1p3Ifb2O9Skw>
    <xmx:KD3raownKF2o-rFi4p7A5CS-eLKE_jv4W0mLbBGAftJvjtj-jMscPA>
    <xmx:KD3ravWfJcuTluYfKFEljwHYJEoriVFPdFxbYdKD39ZC_qT0brN10w>
    <xmx:Kj3ran7B0IUHmoM7hDKO_SPrkuLHDGT-ZbVuMZXcLod9YxaeLtHr56oa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0CAFA32A0097; Wed,  4 Nov 2026 09:11:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: Ar0hN4MWufik
Date: Wed, 04 Nov 2026 15:11:09 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: arm <arm@kernel.org>, soc@kernel.org, "Jon Hunter" <jonathanh@nvidia.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>,
 linux-acpi@vger.kernel.org
Message-Id: <bcad1d7e-387d-4251-8974-7f0dcd2f9734@app.fastmail.com>
In-Reply-To: <auslF5pwDHtcNoCy@orome>
References: <20261003095924.1370238-1-thierry.reding@kernel.org>
 <20261003095924.1370238-4-thierry.reding@kernel.org>
 <928b3eaf-32da-43a9-9ca5-d59ef8a3b330@app.fastmail.com>
 <auslF5pwDHtcNoCy@orome>
Subject: Re: [GIT PULL 4/7] firmware/tegra: Changes for v7.4-rc1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 4, 2026, at 13:42, Thierry Reding wrote:
> On Tue, Oct 13, 2026 at 07:22:23PM +0200, Arnd Bergmann wrote:
>> On Sat, Oct 3, 2026, at 11:59, Thierry Reding wrote:
>> 
>> Where is the ACPI binding documentation for this driver, and who is
>> responsible for reviewing it?
>
> Hi Arnd, Rafael, Len,
>
> Sorry for the late reply, this fell through the cracks.
>
> Admittedly there's not much of a formal process here at all. Anything
> I've received up to now seemed to be fairly straightforward support
> extensions like this where the ACPI tables basically provide the same
> information as the DT via standard resources like register ranges.
>
> I suppose for anything beyond this, we'll want better documentation and
> broader review.
>
> Is there anything in particular that you're looking for? Should I guide
> people internally to always Cc linux-acpi for anything that concerns
> ACPI?

I don't know, I'm also still learning about how this is done, I
was hoping that there was already an established way.

Having a review done by the ACPI maintainers would definitely
help from my point of view, but I'm not sure whether they are
set up for that, in case there are a lot of new drivers.

I assume there is a knowledge gap in both subsystem maintainers
regarding ACPI (certainly this is the case for me for drivers/bus,
drivers/firmware, drivers/soc, etc) and ACPI maintainers regarding
many of the subsystems that we support with DT.

> I'm not very familiar with ACPI, so I'm probably not the best reviewer,
> but I'm sure I'll get the hang of it over time. Generally I think the
> same principles that we use elsewhere apply: use ACPI standards where we
> can (standard interfaces, resources, etc.) and if device-specific
> configuration is needed, use _DSD key-value pairs to mirror what we've
> done for DT (and also mirror back any new properties needed by ACPI to
> DT schemas). For anything that isn't (and can't be) documented as part
> of DT schemas and still custom descriptions are needed, we probably
> should have some documentation in Documentation/firmware-guide/acpi.
>
> One problem that I see with ACPI, and which we successfully side-stepped
> with DT, is that we usually get "baked-in" ACPI tables, meaning we don't
> have much of a choice but to accept whatever is provided. In a way that
> is a step back for Linux, so hopefully we can get better practices in
> place and avoid this turning into a big mess down the road.

Hopefully there is a process in place to amend bindings in a backward
compatible way. I would always expect issues to come up during driver
review that lead to firmware binding changes. Since in this case
both the firmware and the driver are provided by NVIDIA, I don't
think we should treat the firmware as an opaque blob that can't
be changed as we might for other machines.

       Arnd
