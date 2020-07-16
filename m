Return-Path: <SRS0=m6m4=A3=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCECFC433E4
	for <linux-acpi@archiver.kernel.org>; Thu, 16 Jul 2020 03:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF0020775
	for <linux-acpi@archiver.kernel.org>; Thu, 16 Jul 2020 03:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir6YJTLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGPDF3 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGPDF2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2020 23:05:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A917C061755;
        Wed, 15 Jul 2020 20:05:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g20so3544969edm.4;
        Wed, 15 Jul 2020 20:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RRDR+ceHTFBQRo5p3XisKuy+YEua37ZwGLxEXz89DeE=;
        b=ir6YJTLFMBmEbjBdcIkFmjSozkPfj33ZYl7LEmxUxLIjn6rdlrrRpeLD/SBI6++c0o
         yjt5Uyhf2NGLcNSNrkPdNWE2NaxIWnaiEsxVRXlICSZlLXvpfRWz1tI6EtFMaDFMUJz0
         1xVQA5Ts88N4EqgvBjEm2niU2MUjUtZQ5mjIIHkFkLq+PjcGupFeEF03ToNLs4849xuy
         kU6BjKxWZIsvmgh4UaKcYMTwmH+NvtSZ3pLwsmIcHF3eW5nPzoX2iSHVE7VwckNEHiOC
         i/brFhoA7HD780Kr4OzIHn/E6V36dzpRRVeoLW5rwgct2v9YnMEuw10xN/cylc/KtVgF
         JX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RRDR+ceHTFBQRo5p3XisKuy+YEua37ZwGLxEXz89DeE=;
        b=rK4eLoASmnEXwfY97aZ5C18JV09LH0ZFRxl7uyTEt0OhI53+x1Q7s1OepHZDnN9k0d
         ZzfQiD/DotsGWWdUtz9JlLPjsIiWm1QbQPYn7kwR9KdwbkdE7N+4QPz5of0FJwEgtLvY
         uNCaN+pAyx74WF8uNgySo1z2TD944Q6b68qn4E7KLRIIBpnVz6Zw5Yd9485nlYs5ZTeg
         bwX1PikCn0IoByrxg8u3voA+GuuZbjhyT80fi+i6qvkI1u+j9miGoEpBGLl0T5jn09/2
         d/pwfwvmkpRqCPmwBGm38mfvEVq5hoZvJndtUG0KiqOOKhyf9ajOhvmftqWblZh6nQjk
         mhwg==
X-Gm-Message-State: AOAM5302t0pQCnbDuWyZ8ubVMTIoTKSq1tqHxMx404bT2nYHaP7teR9v
        +UZyRyLmqnKPHwoGbKULSovXrik5
X-Google-Smtp-Source: ABdhPJwswQMpCfvh6jyjAqjmku67zGcUnoVxir5SJXT0MwNCtNokam0JJnymGWf8y8AihcYTICTzJw==
X-Received: by 2002:a50:fd12:: with SMTP id i18mr2498832eds.371.1594868727008;
        Wed, 15 Jul 2020 20:05:27 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id z25sm3731101ejd.38.2020.07.15.20.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 20:05:26 -0700 (PDT)
Subject: Re: [net-next PATCH v7 3/6] net/fsl: use device_mdiobus_register()
To:     Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jon <jon@solid-run.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>
Cc:     netdev@vger.kernel.org, linux.cj@gmail.com,
        linux-acpi@vger.kernel.org
References: <20200715090400.4733-1-calvin.johnson@oss.nxp.com>
 <20200715090400.4733-4-calvin.johnson@oss.nxp.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d4e69289-733c-39aa-445c-e41b28a0a758@gmail.com>
Date:   Wed, 15 Jul 2020 20:05:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715090400.4733-4-calvin.johnson@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 7/15/2020 2:03 AM, Calvin Johnson wrote:
> Replace of_mdiobus_register() with device_mdiobus_register()
> to take care of both DT and ACPI mdiobus_register.
> 
> Remove unused device_node pointer.
> 
> Signed-off-by: Calvin Johnson <calvin.johnson@oss.nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
