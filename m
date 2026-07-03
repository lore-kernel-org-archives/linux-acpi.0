Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F1F3D093C;
	Fri,  3 Jul 2026 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081147; cv=none; b=KjYY5AqeYPi+CItLxqnhSKMTo0BcCxar4vFZZQzUqJGUjL7T2/rrmq3avJPCy4VlM4PmbRZGtxWY/0LQUiXOfT//Xn0Ji2eMTWCdZxgpsou7uKz93DYz6BkwTsPPGS7irz3pvSCg1WHAV0FEJ3iKExg5LbrQN/Mg/wZNQLIO03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081147; c=relaxed/simple;
	bh=12YlXocD6vwGtLm7pWmY+UOrOE22PEGR03PpYQCuas8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Pqn5AWPHleZqumM24hVzYuDSzxz2Xi1GeqxBqd77FFzehRHkqrIyIytn9+46Ygs7u9VHFJzZnW8aHUIWMPDYgneQCJ9oW1RcX6XKFkmlw/IyWIHmMVRYSPmwbyP/uQZOWcMJPX4sp0mJMKEmbS2KiuVqYAcvaQAD8AoFMHhAfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=JZC/GuCV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kwZiR96q; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="JZC/GuCV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwZiR96q"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 559A414000BB;
	Fri,  3 Jul 2026 08:19:04 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 08:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783081144;
	 x=1783167544; bh=2L4znT/R1HXo95o/f9BGeTnIQ6jE7mQJd3UaZND8lQo=; b=
	JZC/GuCVlTG3pDv8ia/5arSP3aIMT+bMGA1s31uRgjPgFIxnXmFHqkK/1yFI6xDM
	AXtk5UpHBhIK53G2kPi89W0iBmfS9aOQZyceJno19qRq8HnQ6QddSwVUzPQMBg+s
	mZ7IXG7OLf3UnjX3BZSd49ALsCgGkdkO9Cji4018iWIwuDVDcF0IMdGmyNEi65Yd
	s0UqNBtVLdgDnLwIqz6C4natTcA5/HuY9+YBeQaSpzekcmmEELl8cGj4rW7OIlo3
	FmYXR8UDfY0klcZv9/Q7LSIGp1pJkb2FY+CgSENzMyx0Jd8p4fJ5VWr8h377nyHY
	SbbtPKsdzWe+aJ+sfhPYbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783081144; x=
	1783167544; bh=2L4znT/R1HXo95o/f9BGeTnIQ6jE7mQJd3UaZND8lQo=; b=k
	wZiR96qWvXq9WyZhRHgJdtvRLb7BvLiQSvFPr2f8mL9kVw0IGIcBfJEGOWHUNCGZ
	HrzROZjChq8zjO8vS/lyv8oMD8VI5OVZ/ARYcpCvLV+uxifKX73Jl5ap7bVgc8fo
	sbEjzcbl0EVZIpnl0LKLttbh56cTynHfhXS/+u9Wj3xhOZ9ZXSi6hzW1EVXGot8P
	Rgz80LXBqnSRREyBhpt6WAbXSKuJUXQkwEO+1Q7/w5KFryz39gPUFDMbCzxYr2Pm
	Wqt1FLNx3yPNBowqL0UFmsYyPpt05aQDacIU1V2kG95Zi+CI9/U9X3++ph4PTScY
	zgq6Bw2gkDWCEA/9ns1AA==
X-ME-Sender: <xms:tqhHakSS3BMyaSL9-PJqT9_ZmOr7TqP1jx0rIw_7_NTHlFWwsASZgg>
    <xme:tqhHaskykkqKH1JfPIWWq_8ijtUn8_PFLGQwfIKymCCgVcAvMBqb4_XVAT18xv-8A
    AvJPG5QA_AKWKlKUQo-sQSa7z99SNk66-lGFFOYeL8xRuUfuivggQ>
X-ME-Proxy-Cause: dmFkZTGfBWPTO9NEMiWR5NWTf2oMv9G+s5CCu0Nt/ZL56jR0AM6sowOSaXS/sxhaUZq3Cb
    qvwcSo5UW/3ohcySTJ44vHXWonknhPSqoxYY+mYhIN/3OD7jBClIPraQswu+nA75vL1z41
    Rlc4QQ0kYdfzQpYRoIBL05cEvpV/w/NatwdzoJw6CnzoVZxXuuvxRClG8iTid2fzxL4rpp
    G1sPZ2sFDr+XP288R+UFxRL7Ejwv6BACWPLOR/1Wo6+abEkh1x2F84buhHoa+4YBHpTj0i
    sqpfQtZBE2rYkx7S7qiuxtYfbjAkGMcte4yMPvz0zeFS2cc4poZShKjFwGVYvhtNQcXKp/
    docDjObd03BjZWfwJNOtgF/sMo1sMJQLNvtNDIgret6fw/YBJ+kbqDB3bjb4+1Cw8sObeF
    +BmzqU48O18Fw23xoPX/ic4h/paMowDywYT5USFAmRJCYnj+KcWbc/dZp2r4UYA4Coa81I
    XS59jEjfuP/DiTyHvq+/DjHwIqnlMiAazE3IZY40PD8zJYus9eF/Jv6UbuBL6XBapjb0yw
    rV4PxALYHKerAR7QkHRTrBNrdYWTkpI+gWmEtlrfn7bScHzcPALNNjuQcouWnCDD6qIWtr
    QPMpj+ZBn9waWXmct0vuxyyRN4NaGnJA7+6k0Y++qiEEWBVdm8ixMuP1tMVA
X-ME-Proxy: <xmx:tqhHai2iin20r47wjPmXHoIVlLWrq8cc1_vojK4F8NeMYd7pXO8Gdg>
    <xmx:tqhHat0WYCaXYcYQJPcmtVqvJ0DXcqbX9Bg61FNFXOVi40xA4rRGpA>
    <xmx:tqhHaplpz6_KqH3vdsosoh3_vPMCT7YTExEDVMzFWBpVgXV7plR9AQ>
    <xmx:tqhHamMDVp2GJEl5Kmk1vcAYXevyp4ZL7FYqOENC04RwIpqfqrREZg>
    <xmx:uKhHah2oGQPomM86V2uDi2BLvSoihURcu3anzQbT3e2RycmcGrMunxDl>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9BCF02CE0072; Fri,  3 Jul 2026 08:19:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APtYGyCKnsow
Date: Fri, 03 Jul 2026 08:18:42 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Hans de Goede" <hansg@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Corentin Chary" <corentin.chary@gmail.com>,
 "Luke D . Jones" <luke@ljones.dev>, "Denis Benato" <denis.benato@linux.dev>,
 "Jonathan Woithe" <jwoithe@just42.net>, "Robert Gerlach" <khnz@gmx.de>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Kenneth Chan" <kenneth.t.chan@gmail.com>,
 "Mattia Dongili" <malattia@linux.it>, "Azael Avalos" <coproscefalo@gmail.com>
Message-Id: <c88257d0-1302-4d7b-a6ac-91281a48d7c5@app.fastmail.com>
In-Reply-To: <23182921.EfDdHjke4D@rafael.j.wysocki>
References: <5135166.31r3eYUQgx@rafael.j.wysocki>
 <23182921.EfDdHjke4D@rafael.j.wysocki>
Subject: Re: [PATCH v1 05/10] platform/x86: thinkpad_acpi: Stop setting
 acpi_device_class()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jul 3, 2026, at 7:30 AM, Rafael J.  Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> To facilitate the removal of device_class from struct acpi_device_pnp
> in the future, make the driver store the device class string used for
> generating ACPI netlink events in a new device_class field in struct
> ibm_struct.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/platform/x86/lenovo/thinkpad_acpi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c 
> b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> index 445e1403308e..f614b2701d48 100644
> --- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
> +++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
> @@ -309,6 +309,7 @@ struct tp_acpi_drv_struct {
> 
>  struct ibm_struct {
>  	char *name;
> +	acpi_device_class device_class;
> 
>  	int (*read) (struct seq_file *);
>  	int (*write) (char *);
> @@ -838,9 +839,8 @@ static int __init setup_acpi_notify(struct ibm_struct *ibm)
>  	}
> 
>  	ibm->acpi->device->driver_data = ibm;
> -	scnprintf(acpi_device_class(ibm->acpi->device),
> -		  sizeof(acpi_device_class(ibm->acpi->device)),
> -		  "%s/%s", TPACPI_ACPI_EVENT_PREFIX, ibm->name);
> +	scnprintf(ibm->device_class, sizeof(ibm->device_class), "%s/%s",
> +		  TPACPI_ACPI_EVENT_PREFIX, ibm->name);
> 
>  	status = acpi_install_notify_handler(*ibm->acpi->handle,
>  			ibm->acpi->type, dispatch_acpi_notify, ibm);
> @@ -3869,7 +3869,7 @@ static void hotkey_notify(struct ibm_struct *ibm, 
> u32 event)
>  		pr_err("unknown HKEY notification event %d\n", event);
>  		/* forward it to userspace, maybe it knows how to handle it */
>  		acpi_bus_generate_netlink_event(
> -					ibm->acpi->device->pnp.device_class,
> +					ibm->device_class,
>  					dev_name(&ibm->acpi->device->dev),
>  					event, 0);
>  		return;
> @@ -3949,7 +3949,7 @@ static void hotkey_notify(struct ibm_struct *ibm, 
> u32 event)
>  		/* netlink events */
>  		if (send_acpi_ev) {
>  			acpi_bus_generate_netlink_event(
> -					ibm->acpi->device->pnp.device_class,
> +					ibm->device_class,
>  					dev_name(&ibm->acpi->device->dev),
>  					event, hkey);
>  		}
> -- 
> 2.51.0

Looks good to me.
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
