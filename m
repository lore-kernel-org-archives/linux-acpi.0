Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872533;
	b=f04JoGdp1XBXG+YB+fTIXWj4IN735gBG7+VM07JwdC38o7jIIVEvdPSfudXXoBMqi2iQ
	 vonV8ROGX/t4QDuOZLqCxYFnYQdVjl2dHqBisQ08SK4gKXF0Wf/d0BAq88fPbrpXJ0fj+
	 cgsPumcsOAQqdXHGWwMHAF2ZLOSkyikGTdH+g28dS5FFFuNSuXDHa4Isiz5W19Itjh84X
	 Bn7J+R4ooib5/XmW+sTl2lWXhbEI/kaNfcXd3FVGiU7teJewmVR0hO7Be//yCKnRoSfDv
	 jsRfcmIjz9fr/bD+KP1qMEi6iBWkrtevmj4sUWN58IVhHWARaHPRXHTB3zbrjRMHn6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872533;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=yYe6CIEzHHIU5GeXhJHljatRQTHK1/buaPUEJDpwMkg=;
	b=f4v0oex2fQ5QlSDkDwG0rqILQs5eXeqmTp68xeJfQQCTvs5ymi7w9LDzKqFUfEb371JH
	 5ewn74pCbup5jcSgkE47wFM32ET9N/UbxJ4r/eq2nuIjjyaxqoYv2BMvkTxBHpfp8d4z0
	 02NJcmRFMERw2uXz3XNEUjNQJFT7//77sJVKelOtEdQZyF6YYEhXrxYziduaRryPE+hwr
	 hBtfuBysHCOslUFMxqx7xu/8dI7rRzCWjd++3PwbHMqTt+kHZg7Snzzg8JCXGQ29E3Wwo
	 1kzJL2gjhd9DI6hzBqPG2w667+uuAZNx9Q1YJsrRg0mn7X3LufMqLpX/LHmM4XFB1TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=KDs36gqI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BwAB4lVo;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48625606A339
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 09:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48625606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=KDs36gqI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BwAB4lVo
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 3FA9F1D0017A
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 04:55:31 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 05 Nov 2026 04:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793872519;
	 x=1793958919; bh=yYe6CIEzHHIU5GeXhJHljatRQTHK1/buaPUEJDpwMkg=; b=
	KDs36gqI3uiWbSo5Nq9ioN7evjZ6TcDxqEJJ2uFOVOZFaEWZu2riXOj793mSnSXW
	xCXBwKkiE1r96MCzEPA1Eoyk7rSNPF2UqnxP43vbJxPc3UEo7xPrFaEEOvR6i9Ug
	pxqixVIo65QLZYGCT+JIs1CzBBlmuydRpFOSR2tdIRpgnCVKUlfctmuib90ERZkw
	Id9PxNAs55xhYT6fAWZlNezQFasWf0nxcVjEyiVN6R2M6eaqjQaWp7tj6cKTf1s/
	vcJH455QbYD7/+ML/3QjAwOvnhBkOlaNqDbY9biqzpM4rVfP9Nft0sF4tHsYWHAO
	ssrgnJ5CZ+pYHq6gKe8R5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793872519; x=
	1793958919; bh=yYe6CIEzHHIU5GeXhJHljatRQTHK1/buaPUEJDpwMkg=; b=B
	wAB4lVo2hy1QNhQ78Cm9AX0hg+SnCZ4foAEUota4c2DUNe7kFUMmJ3VR8DVrEHHQ
	4mvMquylkKwyVJFqAaYcOV01zgE+awwLSKHHHPA3yAeUSjW1jcY/cxp5bQb6EXhz
	K+RKOaAA0wl8eqmUp8l5Y+rUkwif9pEo2mw39Q01DT6mceUYasfS32p9xvTN1JY8
	IZ6GECymD1zc2ozfspJH1LQujNAwe8r0cRy6a9ZB+XPdu0EwW5QUQkFub4ZYsR16
	Fk5+i5r9OfsYqsv/c4ZobqpIIJuOhh78fJD2k7z4p7M5eReU243QEZU2cTz05aw4
	4vHue3vEba6VFXs4ZWkaA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793872519; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:SGrYOLQyuL5yRv1AOfwK8z2XDjS7zFliGeUR6NzWiSk6adG
	4bOGadnJEcYFCiPNXD9Lx3Datiopcj9yoZAhBshOqQpIPDnrju1Ysc8o5g9+l7Ii
	YhQSuYdjOhUkLDRp5nTLXDvvGkloLfMih2VhDlKdvkAt6YqA4R5LeEfG3PR61GOs
	vZd2ibT2P7STaFqrsGrPFyv/nNBNaQuj5joQgk9RdTk2LheSx+mH5diRfnGYoCun
	QPvRFnsEsSurII/mpbfc/FrCmNg3AWm/J+ROSQFLqDDR2homnJA3yienvuAljhn1
	ScrDRD8Mk+oD67O1x/54L+qy016i9lHb16oMpmw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:P8Kh0SV27nFzy5+qlPgzS0dQZrOaPuYkmuY2IvHDwAQ=:uYdk09vuVwBFCmYlcqg2fixxKgonfy3RDZ+Q6EFVc9k=;
X-ME-Sender: <xms:gVLsaj0sbFfE7q-z85_VG37V1N-9GAI68Z5wFUuJMYYZTLKRCJPQvw>
    <xme:gVLsas53mPKtRA_S4BIa_NQfLvB1kxOBSjVhzJxh4g6z7ZQEXchKmKAhGLLiw-Cbb
    kTgjARPTyMi_ArTQMVe1bXjiTERHxBKS91Tj52UoJX0uxRCupwTg3I7>
X-ME-Proxy-Cause: dmFkZTGPZKrpK5u23rORwwLT4VcYjpOGZf3598mqc5qOQMCBzaafa8Wy9yw28dXD8b1Z5T
    BgrdmYNHuIX42ZpBNE+ClLn/OyWCusOaI+18SMDwzRoinwpq/yxS3TOrzxLu5FFRs/lz6p
    9DxH/iqqZ8vrPgnc0wkHjaW+VjgtHRLStx/jdwKMTtPgPdJ5JwwjQw63HXILQS84TNn/kb
    6l4x6O3QdVWX3fZtkZbX9w3Lf6RHr3xqZY+/QESgnfLLhr47EWqmjfdbDxM9E/QD3qKNoA
    tK5npRZx09cl7kB2b0YMP9gm8f5/PeyrmdlXxPTXNbH3SkME6rLQE+QHfp+a6MAERjnVt3
    qpDeivDWHrTolLr0rANMg8uEwtmRGE1Uux5+t2HMGMTYXcFHaJC01/9kXx7ltQ1ggnQHGf
    WsKMf/HRlPLUeEANPNHdHvBwqY62i9kxY7cUy599e5PW+YBm9k0wxzjjOCsGs1sKIiLRM0
    Mur46/M8P/uatm7Q9qGPYqVetGBXQyEhmUv3KITfgfxM2gm0gZtd/bt5/+r8XDIAxCMZTn
    ZopY865rZ7ieF7sc6TYmzyYO8GztgJHC23M6TOfeof+LzVc9M4N9AhfFDiPojnKO7HPXKb
    /ppbr3a+Tk8kZ5Ld0mQyOQgOkCeJbQwRGRFZJY8W2YUVpaSXZiM6+lPm5gmg
X-ME-Proxy: <xmx:hFLsaoMygJZEtNhr4I2XHpP_ye6aFV380_3Mte1cJTLnO4JVCVUihw>
    <xmx:hFLsavXnyTbzWl7xvLzoQg15tZKu1J8kDPiuVvPWZVPDmsiADGzD_A>
    <xmx:hFLsagbv84RL1yQWdoTVZQbHx9R4vrJtmuamqMSgtuhN2wRJ57XWJA>
    <xmx:hFLsasva9e8PnvS2O-DWbc7k-SeL-2JeR908j6V24eJtdnuBRbEDXQ>
    <xmx:h1LsajVXGhqXW5KkG2wi3Bh6LRcA_rB0wM-ZxI1qIqOMdnJwwMKsfP7d>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 31C9232A0099; Thu,  5 Nov 2026 04:55:13 -0500 (EST)
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
Date: Thu, 05 Nov 2026 10:54:42 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sudeep Holla" <sudeep.holla@kernel.org>,
 "Jonathan Cameron" <jonathan.cameron@oss.qualcomm.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Thierry Reding" <thierry.reding@kernel.org>, arm <arm@kernel.org>,
 soc@kernel.org, "Jon Hunter" <jonathanh@nvidia.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Len Brown" <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Hans de Goede" <hansg@kernel.org>, "Jonathan Cameron" <jic23@kernel.org>,
 "Mika Westerberg" <westeri@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "James Morse" <james.morse@arm.com>, "Ben Horgan" <ben.horgan@arm.com>,
 "Sizhe Liu" <liusizhe5@huawei.com>
Message-Id: <8f45711b-d415-4694-a47a-12d4b7427e0f@app.fastmail.com>
In-Reply-To: <20261105-inventive-partridge-of-maturity-793a2e@sudeepholla>
References: <20261003095924.1370238-1-thierry.reding@kernel.org>
 <20261003095924.1370238-4-thierry.reding@kernel.org>
 <928b3eaf-32da-43a9-9ca5-d59ef8a3b330@app.fastmail.com>
 <auslF5pwDHtcNoCy@orome>
 <bcad1d7e-387d-4251-8974-7f0dcd2f9734@app.fastmail.com>
 <autADOKsSVVMn6r9@orome>
 <CAJZ5v0iyaHGj2b7H8g0nqrxvz8GpXiE6hkVp9RM7KF+KDckjrA@mail.gmail.com>
 <autmcaraWcXIoRfZ@ashevche-desk.local>
 <20261104161125.00000523@oss.qualcomm.com>
 <20261105-inventive-partridge-of-maturity-793a2e@sudeepholla>
Subject: Re: [GIT PULL 4/7] firmware/tegra: Changes for v7.4-rc1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 5, 2026, at 10:30, Sudeep Holla wrote:
> On Wed, Nov 04, 2026 at 04:11:25PM -0800, Jonathan Cameron wrote:

>> 1) Basic stand alone driver stuff.  Mostly that's all pretty standard
>>    and follow the specs where possible.  If there are gaps start asking
>>    questions. Linux definitely  doesn't support all the stuff that has been
>>    added to the spec in recent years.  So this covers things like register
>>    addresses, interrupts etc.  All fine, hopefully a subsystem maintainer
>>    can take a look and will have enough of any idea.  If not ping the folk
>>    on this thread for help.  Things are a bit flexible for consumer type
>>    devices where fixed and bodges are common, generally less so if it is
>>    server grade hardware.
>> 
>> 2) Stuff that is an ACPI spec gap or place where we'd expect generalization.
>>    There are several examples of this on list this week and a few more in
>>    my inbox.  The particular series here might fall into this category.
>>    I've not figured out enough of the details yet to say definitively.
>> 
>
> Nicely summarised or categorised Jonathan. Nothing much to add.

+1

>> I'd also expect a driver using AML as the target interface to either
>> point at a published spec doc, or to include some snippets
>> of the AML - that can be a lot easier to read than the driver code
>> (imagine reading DT by only looking at how drivers parse it).
>> 
>
> Ideally, it should be just HID that any vendor needs to publish unless
> they make use of any custom methods or something device specific like
> DSD/DSM. I would expect most of the devices to use standard methods and
> properties that are already well defined in the ACPI spec.

>> Given that has new ABI etc, I'd expect that to have gotten broader review
>> as well.  Probably keeping it to linux-tegra and lkml alone wasn't
>> going to result in anyone noticing!
>> 
>> https://lore.kernel.org/all/?q=20260929095915.2215685-1-anrao@nvidia.com
>> 
>
> Agreed, it shouldn't hurt to cc linux-acpi for such driver ACPI enablement
> patches.

Is the "BMRQ" in
https://lore.kernel.org/all/20260929095915.2215685-3-anrao@nvidia.com/
a custom method then? 

How does this relate to the EC and PCC interfaces in ACPI systems?

In current mainline, I see that the bpmp driver is used on DT systems
by the tegra specific cpufreq, memory and pci drivers, but I would
expect that on ACPI those all use shared drivers. Are there any other
users that are not already covered on ACPI?

     Arnd
