Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B0F4FA;
	Sat, 28 Mar 2026 01:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774661390; cv=none; b=W54VHsbyAb1rfLmrfXlghnThKbJYb7bwpOK5mk8pDmlrV56ha2V2m7hwqBDQLSJ/C1nK6VYeW9VbbJaADqoUT80u42Jt9+/tMbUZujKCXATQL/PLSYyvltjzhiQjCjQr0kOb95A+1jhz6w6udArKTHE3z94Ed3/F3hqnUwcFgwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774661390; c=relaxed/simple;
	bh=BvcGuc4I1KCE+LFTx85eOT2hFq1ul16MkebdjvqFhHE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YPOeX9WX/pa3SIRRKmlkXGBQHI6TyD1hGtnhXms3cB4Sxn8AvaFxI3MwMZM76y10ldyKkEjsJkmBcrOjgmUbPBoaHBhOsDVivKp68bCNO/ldmmNju3fbTEQViLvAC//uvgAKONHy+EL+YRjWCVL4078diylZZ85YsX2M2nsVrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=pTQvinE5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0viywai; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="pTQvinE5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0viywai"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3295FEC0203;
	Fri, 27 Mar 2026 21:29:47 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Fri, 27 Mar 2026 21:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774661387;
	 x=1774747787; bh=RE6Z5TFp0wFLK1grHrLXT+7E4LF2z0gm/Ttg7WCsC2Y=; b=
	pTQvinE53NdfdhGACGs4LehRqEwOnK/5FhMWqMmGr1HDbh4IIcD22+ReuUyTsR0R
	jCZym2Qg5xXzjB3/5nN9+CHu7Fq8Lv8QUgaRk5GxYAapQ20gOHkJDKh2+DpQ47QY
	CkL1NfmuZteWqYSJFcd2cc2SXk38wTi6E14z1JCMqvdWw2xk5KN8UzpqpPP35tMG
	LDKTE6E6gPJno6cKmrgIAFAigB2MNZejH1DUYIggLJ97iUoAiFIR9mDKaEKs01X8
	9WU1oSWtTjDql7vJhXkBG9cYgn3lps8GGW0P+tgaOgC5vGIKtoRMYubfnYkPMAIP
	JsYsTlsSFEpXOz5NUu+vDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774661387; x=
	1774747787; bh=RE6Z5TFp0wFLK1grHrLXT+7E4LF2z0gm/Ttg7WCsC2Y=; b=I
	0viywaiT796PaPHcbGIwhqKt+50l5IOJWi7xU03Kp7A0K7j5/int561NwZx0lu44
	OO+YesalKorCPL0dlNisQTayB/2WKvKldrnPaS65yqsRBQY5JvMfmtMeKe0GPwkL
	TKhVYBLDpzeQ55z5gWkox2AQiDEloJlb7cgD1+AfcsuI1imgvgZEgdhCjbhuxoV4
	gARcfmoHVJqw/dSU2z0sD+K+pwP57FE6ktH1g+1BJ9EHUYZy47a3+JIsXNWCPMxe
	LeLWJy5loXiK9zs9AU2Xnc/QaUffIq11Mv8IYqcAibyDYIuSYMv1vEhv6MWqECvU
	PWe6qtSWwdDIYTC1us53Q==
X-ME-Sender: <xms:Ci_HaSPuAjvlA26m7gP6mSR3DvMsFCOaKXg68VFWDUG90VU1Yfh33A>
    <xme:Ci_HabyqBYB_uDT6V27GbhMGcpbvvTcEov8e3UR1jv0OqWwbjPWAsR9x-aha0cIp7
    mzf_glLDLt_4fzlRIyAyHOrCZU9Muxk6BhfIn09YXRab8KQeLiXifPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedukeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdehtdevheduvdejjefggfeijedv
    geekhfefleehkeehvdffheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghrvg
    hkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhmhheshhhm
    hhdrvghnghdrsghrpdhrtghpthhtohephhgrnhhsgheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehilhhpohdr
    jhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepihgsmh
    dqrggtphhiqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhr
    tghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:Ci_HaYyYCjV--6CaIml2yWD7aCBuxOyDFdMT8Xbh2jsUTxL9Gfrjeg>
    <xmx:Ci_HaUfMEubwL6qN0sjjRvsQstjw2p5pQ5iDJggwyXqGxuhIrkjqEA>
    <xmx:Ci_HaV6Gd0aTAdlzF_GpKhSTyO4C_hxB0X0ZtVVH8PyJNYSAEfPaEw>
    <xmx:Ci_HaRIwvSjIiPyV935wq_CuvI7gv2HsscKJp5-VV6hp55GX3cCjMg>
    <xmx:Cy_HabWpkk9YkuU0oQTqbDbamX26cf2h78KAzEEMEOl_lIaFs58xUuhK>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2D2AD2CE07BC; Fri, 27 Mar 2026 21:29:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Av_tymGQ9vDF
Date: Fri, 27 Mar 2026 21:29:25 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 ibm-acpi-devel@lists.sourceforge.net
Message-Id: <cd671e41-9f36-409d-97b4-f696935b1efe@app.fastmail.com>
In-Reply-To: <3949487.kQq0lBPeGt@rafael.j.wysocki>
References: <3949487.kQq0lBPeGt@rafael.j.wysocki>
Subject: Re: [PATCH v1] platform/x86: thinkpad_acpi: Drop ACPI driver registration
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Rafael

On Tue, Mar 24, 2026, at 4:08 PM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> There is no point in registering an ACPI driver that only has an empty
> .add() callback, which is done by the thinkpad_acpi driver, since
> after binding to an ACPI device it only sits there and does nothing.
>
> That binding only effectively causes the ACPI device's reference count
> to increase, but that can be achieved by using acpi_get_acpi_dev()
> instead of acpi_fetch_acpi_dev() in setup_acpi_notify(), and doing
> the corresponding cleanup in ibm_exit().
>
> Update the code accordingly and get rid of the non-functional ACPI
> driver.
>
> No intentional functional impact beyond altering sysfs content.

Just curious - where would I see changes?

>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/platform/x86/lenovo/thinkpad_acpi.c | 62 ++-------------------
>  1 file changed, 4 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c 
> b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> index 8982d92dfd97..9e1614754cd7 100644
> --- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
> +++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> @@ -299,7 +299,6 @@ struct ibm_struct;
> 
>  struct tp_acpi_drv_struct {
>  	const struct acpi_device_id *hid;
> -	struct acpi_driver *driver;
> 
>  	void (*notify) (struct ibm_struct *, u32);
>  	acpi_handle *handle;
> @@ -322,7 +321,6 @@ struct ibm_struct {
>  	struct tp_acpi_drv_struct *acpi;
> 
>  	struct {
> -		u8 acpi_driver_registered:1;
>  		u8 acpi_notify_installed:1;
>  		u8 proc_created:1;
>  		u8 init_called:1;
> @@ -832,9 +830,9 @@ static int __init setup_acpi_notify(struct ibm_struct *ibm)
>  	vdbg_printk(TPACPI_DBG_INIT,
>  		"setting up ACPI notify for %s\n", ibm->name);
> 
> -	ibm->acpi->device = acpi_fetch_acpi_dev(*ibm->acpi->handle);
> +	ibm->acpi->device = acpi_get_acpi_dev(*ibm->acpi->handle);
>  	if (!ibm->acpi->device) {
> -		pr_err("acpi_fetch_acpi_dev(%s) failed\n", ibm->name);
> +		pr_err("acpi_get_acpi_dev(%s) failed\n", ibm->name);
>  		return -ENODEV;
>  	}
> 
> @@ -859,44 +857,6 @@ static int __init setup_acpi_notify(struct ibm_struct *ibm)
>  	return 0;
>  }
> 
> -static int __init tpacpi_device_add(struct acpi_device *device)
> -{
> -	return 0;
> -}
> -
> -static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
> -{
> -	int rc;
> -
> -	dbg_printk(TPACPI_DBG_INIT,
> -		"registering %s as an ACPI driver\n", ibm->name);
> -
> -	BUG_ON(!ibm->acpi);
> -
> -	ibm->acpi->driver = kzalloc_obj(struct acpi_driver);
> -	if (!ibm->acpi->driver) {
> -		pr_err("failed to allocate memory for ibm->acpi->driver\n");
> -		return -ENOMEM;
> -	}
> -
> -	sprintf(ibm->acpi->driver->name, "%s_%s", TPACPI_NAME, ibm->name);
> -	ibm->acpi->driver->ids = ibm->acpi->hid;
> -
> -	ibm->acpi->driver->ops.add = &tpacpi_device_add;
> -
> -	rc = acpi_bus_register_driver(ibm->acpi->driver);
> -	if (rc < 0) {
> -		pr_err("acpi_bus_register_driver(%s) failed: %d\n",
> -		       ibm->name, rc);
> -		kfree(ibm->acpi->driver);
> -		ibm->acpi->driver = NULL;
> -	} else if (!rc)
> -		ibm->flags.acpi_driver_registered = 1;
> -
> -	return rc;
> -}
> -
> -
>  /****************************************************************************
>   ****************************************************************************
>   *
> @@ -11532,6 +11492,8 @@ static void ibm_exit(struct ibm_struct *ibm)
>  		acpi_remove_notify_handler(*ibm->acpi->handle,
>  					   ibm->acpi->type,
>  					   dispatch_acpi_notify);
> +		ibm->acpi->device->driver_data = NULL;
> +		acpi_dev_put(ibm->acpi->device);
>  		ibm->flags.acpi_notify_installed = 0;
>  	}
> 
> @@ -11542,16 +11504,6 @@ static void ibm_exit(struct ibm_struct *ibm)
>  		ibm->flags.proc_created = 0;
>  	}
> 
> -	if (ibm->flags.acpi_driver_registered) {
> -		dbg_printk(TPACPI_DBG_EXIT,
> -			"%s: acpi_bus_unregister_driver\n", ibm->name);
> -		BUG_ON(!ibm->acpi);
> -		acpi_bus_unregister_driver(ibm->acpi->driver);
> -		kfree(ibm->acpi->driver);
> -		ibm->acpi->driver = NULL;
> -		ibm->flags.acpi_driver_registered = 0;
> -	}
> -
>  	if (ibm->flags.init_called && ibm->exit) {
>  		ibm->exit();
>  		ibm->flags.init_called = 0;
> @@ -11587,12 +11539,6 @@ static int __init ibm_init(struct 
> ibm_init_struct *iibm)
>  	}
> 
>  	if (ibm->acpi) {
> -		if (ibm->acpi->hid) {
> -			ret = register_tpacpi_subdriver(ibm);
> -			if (ret)
> -				goto err_out;
> -		}
> -
>  		if (ibm->acpi->notify) {
>  			ret = setup_acpi_notify(ibm);
>  			if (ret == -ENODEV) {
> -- 
> 2.51.0

Changes seem good to me (but not an expert).
I did try them out on a system (X1 Carbon 13) and didn't find any problems. Let me know if there's anything in particular I should look out for or check and happy to do that.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Mark
