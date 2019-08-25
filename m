Return-Path: <SRS0=QXrF=WV=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523E9C3A5A1
	for <linux-acpi@archiver.kernel.org>; Sun, 25 Aug 2019 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E051020870
	for <linux-acpi@archiver.kernel.org>; Sun, 25 Aug 2019 15:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="h3w704K+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfHYPMA (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 25 Aug 2019 11:12:00 -0400
Received: from canardo.mork.no ([148.122.252.1]:46837 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbfHYPMA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 25 Aug 2019 11:12:00 -0400
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id x7PFBfoP008235
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 25 Aug 2019 17:11:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1566745902; bh=PP4n2fz6UQQ3js15df5WuXJSQb7K9QHAw7vvTMC4fx4=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=h3w704K+CqbdZ9tuslGWqESg2qEHf5Y2qUH/tdOPqQmOaPpLCpMljkpbq8M3cKUP2
         IbDPjsViu0ORGw05rvSs+Ghmmvn3pVCjjuZ/DgDiHBX2WbHxi5nlBgy3LyGmQDXbts
         ZIq3rPnLRI9VmKTsIy4aHYBtMVSCUn1WxV5m+lhQ=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1i1uBA-0005OO-T6; Sun, 25 Aug 2019 17:11:40 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     <Charles.Hyde@dellteam.com>
Cc:     <linux-usb@vger.kernel.org>, <Mario.Limonciello@dell.com>,
        <oliver@neukum.org>, <nic_swsd@realtek.com>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [RFC 3/3] net: cdc_ncm: Add ACPI MAC address pass through functionality
Organization: m
References: <6db7de30d5584018adf169638e956626@AUSX13MPS303.AMER.DELL.COM>
Date:   Sun, 25 Aug 2019 17:11:40 +0200
In-Reply-To: <6db7de30d5584018adf169638e956626@AUSX13MPS303.AMER.DELL.COM>
        (Charles Hyde's message of "Fri, 23 Aug 2019 22:29:29 +0000")
Message-ID: <87h865xosz.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.101.2 at canardo
X-Virus-Status: Clean
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

<Charles.Hyde@dellteam.com> writes:

> +static int cdc_ncm_resume (struct usb_interface *intf)
> +{
> +	struct usbnet *dev =3D usb_get_intfdata(intf);
> +	struct cdc_ncm_ctx *ctx =3D (struct cdc_ncm_ctx *)dev->data[0];
> +	int ret;
> +
> +	ret =3D usbnet_resume(intf);
> +	if (ret !=3D 0)
> +		goto error2;
> +
> +	if (ctx->ether_desc) {
> +		struct sockaddr sa;
> +
> +		if (cdc_ncm_get_ethernet_address(dev, ctx)) {
> +			dev_dbg(&intf->dev, "failed to get mac address\n");
> +			goto error2;
> +		}
> +		if (get_acpi_mac_passthru(&intf->dev, &sa) =3D=3D 0) {
> +			if (memcmp(dev->net->dev_addr, sa.sa_data, ETH_ALEN) !=3D 0) {
> +				if (cdc_ncm_set_ethernet_address(dev, &sa) =3D=3D 0) {
> +					memcpy(dev->net->dev_addr, sa.sa_data, ETH_ALEN);
> +				}
> +			}
> +		}
> +		dev_info(&intf->dev, "MAC-Address: %pM\n", dev->net->dev_addr);
> +	}
> +
> +error2:
> +	return ret;
> +}


This is wrong.  dev->net->dev_addr will hold the correct address, and it
does not have to match any USB descriptor or ACPI table entry. It's a
user managed address.

You should simply make sure the device is syncronized with the
dev->net->dev_addr field.  But you probably want to avoid doing that if
it failed initially.  There is no need to issue control requests you
know will fail.

Why the dev_info()? It logs info the user can retrieve with a simple
"ip link" or similar.  Seems pretty useless even as a debug statement?


Bj=C3=B8rn
