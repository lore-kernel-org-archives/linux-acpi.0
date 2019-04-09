Return-Path: <SRS0=ifiZ=SL=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A78C10F0E
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 16:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC54B2084F
	for <linux-acpi@archiver.kernel.org>; Tue,  9 Apr 2019 16:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Td2OyzsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfDIQfn (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:35:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50510 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbfDIQfj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Apr 2019 12:35:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so4393501wmi.0
        for <linux-acpi@vger.kernel.org>; Tue, 09 Apr 2019 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kVY6gm93IxOicC2fEC0J47/R327+OQXdPKJ+Wc5c6E8=;
        b=Td2OyzsETjXiNxxyrCwZCh3GbsO7MDlHuRiQ/LCapEbezj4Hggno5+xpcDaZgiNDU7
         7ZHOZ7L+MOlC53rlvf7uQTEyC+QcKwTd5nOa9f85wD5IHJeIQcCu31tcM1m9Wf+0D59p
         4M/UIZo39IezGeCUHRWuy6fi3FLj/3toP4epYwKypwg6zoJHcGhuUkJ9LxNvUJUK7ASg
         QN5SCQksYWRlv2/2Rl6ciZs1ix1L/tDleCBGaba4mCGgKjnx9y6RMzftBak1rdnkl4Ww
         d0Kkbu2YoiFrGf5Bg6EZKlihq4BXkwLFZIoK5+gOsl2HO04KXXvvCm/DkfYlhdDkJWSv
         anJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kVY6gm93IxOicC2fEC0J47/R327+OQXdPKJ+Wc5c6E8=;
        b=uBdbzGKMTDKHCANVRkgpgBMYbEaqna815/B6sYmR28w5c/9Vt90OWK0IrwYgE5u/gG
         f9Ry2/2CTVXVYile7YoRSqUryItA/+OkzNxrFbPo2v0+W+A1Mi+XqKvQKDlTO9ISgnHr
         yVLVskUgJKjlOSObHs2gWw1l7qSncWpLC1ph60La3y6eF/iAxEdr9pXn5mL9Rm9o+dkb
         jgMU23nJyYnoVIAm/CZmSUkYd9MqLr2YpXH5hLwDDWPgqxjvWCyPuY8BWCiP+vd9x30i
         5h2ATN0r86fM32K5T2reuF7XXS+KUlozqjyzK+HFBwRuNjR7rLv+jFCASWZq2JJbSHXH
         TeBw==
X-Gm-Message-State: APjAAAXMj0Nc9hZPwR33tMKSmW/44B5G7OX+aIVvi9PGdIBpQEsUbhhR
        ir9Isrm0i3Qck98GLvdCPycLzw==
X-Google-Smtp-Source: APXvYqz2TDdi7UCDhvoeR1eOs1eAO1vnYR+6NdJrUCh3mNN3DAxteX/OYqTz3dLe2c+WXCh8QLRMVA==
X-Received: by 2002:a1c:a7c5:: with SMTP id q188mr15353008wme.126.1554827737361;
        Tue, 09 Apr 2019 09:35:37 -0700 (PDT)
Received: from [192.168.0.105] ([88.147.54.190])
        by smtp.gmail.com with ESMTPSA id j11sm44523040wrw.85.2019.04.09.09.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:35:36 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Thinkpad X60: regression with 5.1-rc1 and 5.1-rc4
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190409163304.GA23829@amd>
Date:   Tue, 9 Apr 2019 18:35:35 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, rjw@rjwysocki.net,
        lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6306562-0022-4043-BBF8-13FE4872CA31@linaro.org>
References: <20190408173914.GA13260@amd>
 <678ab058-986c-9727-58d7-d3f5283e2225@kernel.dk> <20190409163304.GA23829@amd>
To:     Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190409163535.DQu_JpY1a1kRtWs9SQQe5yRQ7lqKq7uWRbKk8Syf-dk@z>



> Il giorno 9 apr 2019, alle ore 18:33, Pavel Machek <pavel@ucw.cz> ha =
scritto:
>=20
> On Mon 2019-04-08 11:41:18, Jens Axboe wrote:
>> On 4/8/19 11:39 AM, Pavel Machek wrote:
>>> Hi!
>>>=20
>>> For some reason, Thinkpad X60 now crashes during boot. I see some
>>> weird backtraces, and it may be bfq related... or maybe ACPI idle.
>>>=20
>>> Does x86-32 work for you?
>>>=20
>>> Weird thing is, 5.1.0-rc3-next-20190408 boots here (but later has
>>> problems during resume, making it unusable, too). They may not have
>>> 100% same configs.
>=20
> I now noticed it said:
>=20
> EIP is in bfq_bfqq_expire
>=20
>> Can you try and revert:
>>=20
>> 9dee8b3b057e1
>>=20
>> and see if that helps?
>=20
> Yes, I tried and yes, it helps. What are the next steps?=20
>=20

Try my fix:

=
https://lore.kernel.org/linux-block/20190409191420.3f56d493@fire.localdoma=
in/T/#m30a14045e710b870f00f7c51cdaa7c403977b767

and cross your fingers :)

Thanks,
Paolo

> 									=
Pavel
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) =
http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

