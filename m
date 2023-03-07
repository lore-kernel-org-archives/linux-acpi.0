Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0655C6FD20
	for <linux-acpi@archiver.kernel.org>; Tue,  7 Mar 2023 19:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjCGTnr (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 7 Mar 2023 14:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCGTnb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 14:43:31 -0500
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1463BB71BD
        for <linux-acpi@vger.kernel.org>; Tue,  7 Mar 2023 11:31:50 -0800 (PST)
Received: from mail.panix.com (localhost [127.0.0.1])
        by mailbackend.panix.com (Postfix) with ESMTPA id 4PWQYd35NCz4J3V;
        Tue,  7 Mar 2023 14:31:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1678217509; bh=aMd3ipWpBb3PC6WrlIG90R0vVu7K8FSIwXT6anhs+xg=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc;
        b=GaEcJVlRAlny7PF05s4SVooUOPqVhj/fhuyAeLXfkH8Xpo+ckPksszcKCVcb4JAL1
         Ki61DhK/Dc2QyQllfuIpXQWgLWeBBOx2IAYkRtdZBjO8heGZaITf/nW+zMWTenrQDw
         0efGNlHHLSEAPt1UXxq70ZJh0XwWDdc5RaBpK4eQ=
X-Panix-Received: from 166.84.1.1
        (SquirrelMail authenticated user pa@panix.com)
        by mail.panix.com with HTTP;
        Tue, 7 Mar 2023 14:31:49 -0500
Message-ID: <6d97df76de719871c90fb59726f2d6b0.squirrel@mail.panix.com>
In-Reply-To: <20230307161005.6m6fpi3oxa3jn2wg@pengutronix.de>
References: <9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com>
    <20230307093308.m5enhuegm3r4qwvo@pengutronix.de>
    <220898e2276e4cae2572eb8f006f3a7b.squirrel@mail.panix.com>
    <20230307161005.6m6fpi3oxa3jn2wg@pengutronix.de>
Date:   Tue, 7 Mar 2023 14:31:49 -0500
Subject: Re: [Regression] acpi: laptop panics early in boot
From:   "Pierre Asselin" <pa@panix.com>
To:     =?iso-8859-1?Q?=22Uwe_Kleine-K=C3=B6nig=22?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Pierre Asselin" <pa@panix.com>, linux-acpi@vger.kernel.org,
        regressions@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
User-Agent: SquirrelMail/1.4.23-p1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> Maybe the following patch helps (on top of v6.3-rc1):
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 9531dd0fef50..a5a8f82981ce 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -518,7 +518,7 @@ static void acpi_bus_notify(acpi_handle handle, u32
> type, void *data)
>  	if (!adev)
>  		goto err;
>
> -	if (adev->dev.driver) {
> +	if (device_is_bound(&adev->dev)) {
>  		struct acpi_driver *driver = to_acpi_driver(adev->dev.driver);
>
>  		if (driver && driver->ops.notify &&
>

It does indeed "fix" 6.3-rc1.  Modulo locking issues, which I am
not qualified to evaluate.


