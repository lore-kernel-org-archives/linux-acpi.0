Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22653C433E0
	for <linux-acpi@archiver.kernel.org>; Tue,  2 Feb 2021 14:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D9764F4D
	for <linux-acpi@archiver.kernel.org>; Tue,  2 Feb 2021 14:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhBBOn1 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 2 Feb 2021 09:43:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234504AbhBBOlX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 09:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612276796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XwLM1qr8Fq0WkUl5xjaI4hjLYikgWJiraoZrsEvsnpU=;
        b=B6fmJ8Jw9V9seIEYLi1ZzbPYkac6gLxtG3rNoiBJzVRrqwcVGsr1W+xzU8bX2YVcX68jFq
        RwLkYy8vC+UhXudrvDDb94qseNqKgNj/FPLWTb9LrkH53EMA9uVzJAdKFGMGMgc2gM3GQt
        M90BW4s49mr0AOWVBDo/Glo51CRNa5o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-cNc06EX3MEipN8DMSFcp-A-1; Tue, 02 Feb 2021 09:39:54 -0500
X-MC-Unique: cNc06EX3MEipN8DMSFcp-A-1
Received: by mail-ej1-f69.google.com with SMTP id ox17so10047514ejb.2
        for <linux-acpi@vger.kernel.org>; Tue, 02 Feb 2021 06:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XwLM1qr8Fq0WkUl5xjaI4hjLYikgWJiraoZrsEvsnpU=;
        b=iDCgiIGMjzOsLu5/qFVUPqLUiM1uRbNEp764SNhWtT3EEyDwFFwwmDDe4zPAb66feJ
         7AUAGhTVDJnIQz7GfeI85TGDroXXCkoWRaHs4CYkAETvI0xxm1C+OqXtkKNAN5mJpp1h
         Ym0L51lb9aLjsXWmb4JwUK3BUZx+S8VTCPm7G9ZMW73Zi6WZF/YipHIqIlBQlBWpX/pD
         C7DH1LAvI1+SLqXRbaG2sXE4h/W76r44i1Q3QzvaxG+czTYxvb9+kOMBGEZn24QiLAgq
         mnXJGs+YjeL68mGizZBkTU1ZwWH1790tzj8LPXTwT+zQGA6ASMGpgC2lnvf5jmxaR0w4
         XReQ==
X-Gm-Message-State: AOAM532fHqf+yezpBK9eBVqF68IjsBTU0ZC+RER8BoR5b2WQeVhrasc5
        tW+/KA2RLfA/kAqbSe4Wawp6xkELaLcJk8lLZLNwNaUocJLrVOKnJYJyAD3ig2N8HIOamAxvV3b
        SWmbXAxfBnGe0ngTMf1ab4g==
X-Received: by 2002:a50:8466:: with SMTP id 93mr12131983edp.55.1612276793209;
        Tue, 02 Feb 2021 06:39:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwATqBa2bC9fPDIzxTOmTh2LWCs80TuPFub0bxqt9MpNy54OydCvXDdUc7w1r93lUAiocEdVw==
X-Received: by 2002:a50:8466:: with SMTP id 93mr12131965edp.55.1612276793017;
        Tue, 02 Feb 2021 06:39:53 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id i4sm9441404eje.90.2021.02.02.06.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 06:39:52 -0800 (PST)
Subject: Re: [PATCH v2 2/2] ACPI: platform-profile: Introduce object pointers
 to callbacks
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20210125115957.3292-1-hdegoede@redhat.com>
 <20210125115957.3292-3-hdegoede@redhat.com>
 <CAJZ5v0iVGpUxUVMAO4R9bz8dogFRoYun-9-4G_Mgzq0_WP305Q@mail.gmail.com>
 <CAJZ5v0iCWXmtAApSvVwmWT_p8QXoK9oivTFkxynf3LPEjCE7+A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <054e36fc-edeb-043c-7842-cfb29bf6f98d@redhat.com>
Date:   Tue, 2 Feb 2021 15:39:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iCWXmtAApSvVwmWT_p8QXoK9oivTFkxynf3LPEjCE7+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/1/21 2:55 PM, Rafael J. Wysocki wrote:
> On Wed, Jan 27, 2021 at 6:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Tue, Jan 26, 2021 at 6:58 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>
>>> Add an object pointer to handler callbacks to avoid the need for
>>> drivers to have a global variable to get to their driver-data
>>> struct.
>>>
>>> Link: https://lore.kernel.org/linux-acpi/6a29f338-d9e4-150c-81dd-2ffb54f5bc35@redhat.com/
>>> Link: https://lore.kernel.org/r/20210114073429.176462-3-jiaxun.yang@flygoat.com
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Applied on top of the previous platform-profile patches, thanks!
> 
> And the entire acpi-platform-profile material is now available for you
> to pull in the git branch at:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-platform
> 
> which is not going to be rebased going forward.

Thank you. I've merged this into pdx86/for-next now.

Regards,

Hans

