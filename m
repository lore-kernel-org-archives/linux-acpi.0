Return-Path: <SRS0=DsGL=WE=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E24C433FF
	for <linux-acpi@archiver.kernel.org>; Thu,  8 Aug 2019 12:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C09E214C6
	for <linux-acpi@archiver.kernel.org>; Thu,  8 Aug 2019 12:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfHHMPA (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:15:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38010 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfHHMPA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Aug 2019 08:15:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so55715301edo.5
        for <linux-acpi@vger.kernel.org>; Thu, 08 Aug 2019 05:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3XH58oe3b9t1OK4zp9oXg6yL++7sd5XsM6HbIEdCObA=;
        b=DjI3sh/YqY09b+Lrg0IGfdx1ZmagKcLVhYi2bkdac/MJjNVFePjCrBtu3/ieDDZruI
         OZLFwljxOzWAgodSYzgwl2/7KfN+fixEX3su0NTnbhTqEDZNw2YPaaMk5EILoyBaxPSA
         n8jokHnSdIS4MebTv8AGFHpwU36z96zmrVd0NrxkAQ0gkuEonhKnI2GEA6e88lHEAiO+
         HZS7vF6sx9xQ5bdHBPM2Clv/QGyaa7WKjzLS9HjvCIqoFQ8a0GaRJPlGvdOJuKLYOfaL
         lFbJlm5yk6oGTi5qHMdd+Cqb3tKHVD5Cab184VxeWHh81AYFPQNjkCwRmkyipJBrzIVS
         UbGw==
X-Gm-Message-State: APjAAAWpMisMgI0wkJMTSzV6PcL4+ppw6RqP6+JrD7vIivOHcJenERz2
        v8RQbOLUWqcykf94fFCXdvFIAw==
X-Google-Smtp-Source: APXvYqyOkS6n7hpVdf4W7PVVLiuHAK954qcuqUs+vn7hlgIkI/3+iYgxVpJ4HMnXe4R1lXHqoN58Bg==
X-Received: by 2002:a17:906:4e95:: with SMTP id v21mr4939724eju.105.1565266498690;
        Thu, 08 Aug 2019 05:14:58 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s2sm8457858ejf.11.2019.08.08.05.14.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 05:14:57 -0700 (PDT)
Subject: Re: [PATCH 5.3 regression fix] pwm: Fallback to the static
 lookup-list when acpi_pwm_get fails
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        youling257@gmail.com,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
References: <20190730154848.5164-1-hdegoede@redhat.com>
 <31c3f15e-649e-a3c1-56e2-0c35fda24ae1@redhat.com>
 <20190808112122.GB24700@ulmo>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <71bc5280-46e8-77ad-004e-8a9b3befa7d1@redhat.com>
Date:   Thu, 8 Aug 2019 14:14:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808112122.GB24700@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 08-08-19 13:21, Thierry Reding wrote:
> On Thu, Aug 08, 2019 at 12:19:53PM +0200, Hans de Goede wrote:
>> Thierry,
>>
>> Ping? This fixes a somewhat serious regression in 5.3, can we please get
>> this queued up for merging into 5.3 ?
> 
> I've pushed this out. Let's give it a day in linux-next and then I'll
> send out a PR for v5.3-rc4.

Great, thank you.

Regards,

Hans

