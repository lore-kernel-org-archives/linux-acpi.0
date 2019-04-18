Return-Path: <SRS0=Z37m=SU=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A5EC10F14
	for <linux-acpi@archiver.kernel.org>; Thu, 18 Apr 2019 12:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE972183F
	for <linux-acpi@archiver.kernel.org>; Thu, 18 Apr 2019 12:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555591402;
	bh=QZfwcZDIbmk4mZWbV99BOnscLiGjJGgPSObYzPRKCH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pK/Vt6hXjMJ0C69dg95OLMrIROrI5mJRPslhGp0cdtZtuiTm3+/AE8svlZ/W5zXJd
	 EA7ZfyOGqlahrl8OKSnIGA6ecLslBK9neM9LSj6tuA1+20Xww87zJKfj1Edt2ibTEU
	 zEX6DoN03O9hDWxDBjTiOdEHYFwCIkneR/qHfYeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388991AbfDRMnV (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:43:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37807 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRMnU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Apr 2019 08:43:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id v84so1485614oif.4;
        Thu, 18 Apr 2019 05:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZfwcZDIbmk4mZWbV99BOnscLiGjJGgPSObYzPRKCH0=;
        b=gwY2J4nv9DR8GqCrNaeUGPNoY0OF+4gT4TiW+NZCHbjBcFAHUh9F1mp0nRuGJU0H1v
         exnKLS0ngQ+zIqHkQwUumxvFNlr2BDE7D8pjsvzkgFA8w8ZRCP2fk6w+fcW1qvNA74i4
         DdHzmR5XHMqvUpK+bVZETdqhmN7RGXlp5ZxQ4ymYIDVG9zs7w3hFAg+4qrVWW2ZPUazW
         4rut+0JyypNE1TUtXXysMO1rdx91zlWANBveui1iT4Ox6Bav2iPqok7KzgnAV/8+h1Mc
         CwLoqwf72bXUvZ6PzjTzBKCvhL7Qs8nN7bD4IX7nQ2QGMS/iXcc6UYtfEGQ8dXGDgLDL
         uogg==
X-Gm-Message-State: APjAAAXy6+J4zkZzBAZeENt5HjRIAjKX3Mahckkq44Nt+/kB269FWxhE
        PAQ0qTZcnf3OfeCMxKmdYNMbVR1dmwGG2ImMsmgPrQ==
X-Google-Smtp-Source: APXvYqwxh0/GRQUgkptbDe1vgPM8uIXk6g8ygd8XkUvSJJclzDXLPMxbbhSAgW77vTbChDt89jYC9+sk3PHO+kTUeig=
X-Received: by 2002:aca:ba82:: with SMTP id k124mr1951883oif.110.1555591399553;
 Thu, 18 Apr 2019 05:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190402103037.8517-1-sakari.ailus@linux.intel.com> <20190418121848.qdaoi6ibn5opjg6z@valkosipuli.retiisi.org.uk>
In-Reply-To: <20190418121848.qdaoi6ibn5opjg6z@valkosipuli.retiisi.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Apr 2019 14:43:07 +0200
Message-ID: <CAJZ5v0gr+iSmwdOBpZF1k9Xs0CE3pfJg_NZDRd326PN7_g3Ncg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] device property: Add fwnode_graph_get_endpoint_by_id
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 18, 2019 at 2:20 PM Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> On Tue, Apr 02, 2019 at 01:30:37PM +0300, Sakari Ailus wrote:
> > fwnode_graph_get_endpoint_by_id() is intended for obtaining local
> > endpoints by a given local port. fwnode_graph_get_endpoint_by_id() is
> > slightly different from its OF counterpart is
> > of_graph_get_endpoint_by_regs(): instead of using -1 as a value to signify
> > that a port or an endpoint number does not matter, it uses flags to look
> > for equal or greater endpoint. The port number is always fixed. It also
> > returns only remote endpoints that belong to an available device, a
> > behaviour that can be turned off with a flag.
> >
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> Ping?

I've been waiting for Rob to say something, but it looks like he has
nothing to say here, so I think I'll go ahead and take the patch as
is.
