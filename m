Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0619C432BE
	for <linux-acpi@archiver.kernel.org>; Fri,  6 Aug 2021 13:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A557061179
	for <linux-acpi@archiver.kernel.org>; Fri,  6 Aug 2021 13:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344411AbhHFNov (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344412AbhHFNot (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Aug 2021 09:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628257473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUNCaljoh6zNjohyhM8u6lXSLeXe2hyYUThfCWY505I=;
        b=KqY9RmX4+ljommeFqdQwC5T+xZt+izV1rTISlDb5FDhyiLgVV9lb3QLWaVj4tx3zzHTAKD
        2UPgdpGeaiTTqQWGTGkm3hQ1A89G8XxMMSFYVO8UC1GH1rwIIbrHG06eWQ7noq8gS/BJOk
        zM0kxh7nn8ieceSFIltMDXBXVUTIQHo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-FEqRg1lEPVGTBj7Owfhdfw-1; Fri, 06 Aug 2021 09:44:32 -0400
X-MC-Unique: FEqRg1lEPVGTBj7Owfhdfw-1
Received: by mail-ed1-f69.google.com with SMTP id d12-20020a50fe8c0000b02903a4b519b413so4948712edt.9
        for <linux-acpi@vger.kernel.org>; Fri, 06 Aug 2021 06:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LUNCaljoh6zNjohyhM8u6lXSLeXe2hyYUThfCWY505I=;
        b=OQFugKi9cNgQ7roCQXx4rDOaw3NjPK8Id+VHKfTDzYS/yhRcqKSXpSYjzeRlnCIpV6
         /3DUrCDckJpLna0ao5OnXQiz5eJs/acTPaBcsYykMTm5r4UlIcxJdrCZixSJ3cEaf66j
         xH83Q8eTC00tYWmEOT9dIT+WkWvUlsnXRkyo6T+vq60wWo65+MgvJCEXTGktWxhF+VBu
         oxQHTZTOk5EpatPmoUcaM8CjzZEmF2xOnP5G043qWSGt9intGs/pVLoZtPk2o3f/8Cnq
         eTbUShai40817SxWP0xRcogMkVEE5AgW5+JouqzmF9H8NQZvvOCJG4bP3QxyehugjTRQ
         jXZw==
X-Gm-Message-State: AOAM531pq2SKXG9di/AWJm3O1hRARQ7hoPgcPR2XvnIpbgedPTAZ+4Bf
        VzapXTKgbp8Gmk06Qr1B+5k42sQqNGlLJcTEzZX2BAjkp3Yai7JnEd1+SDkT31fPyXbtoOR0Epy
        3dFIhojaaGN2TZ8BZpP92Cad5wOLKnH9wgOt+nTmLj7y8MqcSDuNdANcHlGBNV3Qev7j+qM/WjQ
        ==
X-Received: by 2002:a05:6402:d7:: with SMTP id i23mr13112215edu.291.1628257471238;
        Fri, 06 Aug 2021 06:44:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL7vlaTOy3c5YZFIfiw2sjAwyw1MSYfWQwVF2pH8QLK/4mhX/K1TBAPijCqcDV0hx7gFIzdw==
X-Received: by 2002:a05:6402:d7:: with SMTP id i23mr13112187edu.291.1628257471004;
        Fri, 06 Aug 2021 06:44:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id f9sm3693201edy.57.2021.08.06.06.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 06:44:30 -0700 (PDT)
Subject: Re: [PATCH 1/4] i2c: acpi: Add an i2c_acpi_client_count() helper
 function
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20210803160044.158802-1-hdegoede@redhat.com>
 <20210803160044.158802-2-hdegoede@redhat.com> <YQlzzy933V9XMHqt@lahna>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9fbf0d6a-2df3-4765-ccf5-788b86994d71@redhat.com>
Date:   Fri, 6 Aug 2021 15:44:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQlzzy933V9XMHqt@lahna>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/3/21 6:50 PM, Mika Westerberg wrote:
> On Tue, Aug 03, 2021 at 06:00:41PM +0200, Hans de Goede wrote:
>> We have 3 files now which have the need to count the number of
>> I2cSerialBus resources in an ACPI-device's resource-list.
>>
>> Currently all implement their own helper function for this,
>> add a generic helper function to replace the 3 implementations.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you, Wolfram are you also ok with me merging this
patch through the pdx86 tree?

Regards,

Hans

