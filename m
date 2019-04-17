Return-Path: <SRS0=8JUk=ST=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6439BC10F12
	for <linux-acpi@archiver.kernel.org>; Wed, 17 Apr 2019 10:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342642073F
	for <linux-acpi@archiver.kernel.org>; Wed, 17 Apr 2019 10:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfDQKPV (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:15:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44543 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbfDQKPV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Apr 2019 06:15:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id i13so9784932edf.11
        for <linux-acpi@vger.kernel.org>; Wed, 17 Apr 2019 03:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fl5I4IhsegfAfYhYg7yGpZzu65bju11pI6HhhderbX8=;
        b=ASG/E2AM/aVFC8KivfN6FI78O/+WZCVoDWhqTMiwHXxBFDrsCsPQEfgjY7viJIn7+e
         FQIWicPEdgKTBIk0Qs+U07NgrYNErdDxDoZGloUPFJUsw1ehuhvbV4erh0n3MnGyFX7T
         DFrxdel482LGsw5Uhr1nXGl/Xv4FAsF+jN22BYOVBFo+VIclSUEI+oq8bjux53kYN+s2
         a57peemLWSU6lxhdoL+DfMBFH5wCGdb1jaPdigImzyZ88kvLDiPRtuiVR7PUIPeFJGGV
         Ty6wTNJzc7fLHwNWL7eCBqavp5q0n0bixgQJ30EHIITNyODw4kvzQHF+FQBL5F2F//3+
         LU4w==
X-Gm-Message-State: APjAAAXw7cUw3tTj3WtlsviFaIHiLMp18bhEeQMxHkVXvy6Pv5dJ9ULn
        YZC2zmqPS8/B1pjn0ttjTMAAD3ttdr4=
X-Google-Smtp-Source: APXvYqyPw7z+jXLieQdseap8u5P9jYpx6tTPQdsSrnQmEbRKDKKSZ0jSnMryatOZQ0UNJhEodbQAvQ==
X-Received: by 2002:a17:906:a311:: with SMTP id j17mr48588209ejz.269.1555496119888;
        Wed, 17 Apr 2019 03:15:19 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id g11sm1379557eda.12.2019.04.17.03.15.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 03:15:18 -0700 (PDT)
Subject: Re: [PATCH v3 13/13] platform/x86: intel_cht_int33fe: Replacing the
 old connections with references
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <20190412134122.82903-14-heikki.krogerus@linux.intel.com>
 <a91a1d75-f224-9c9d-873a-f80467d2fb0c@redhat.com>
 <20190417063918.GI1747@kuha.fi.intel.com>
 <76d9ab79-a1d0-f3cd-ba5d-2325740c72ff@redhat.com>
 <20190417093252.GO1747@kuha.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2fcb2e2c-c390-1b49-7228-197f23401271@redhat.com>
Date:   Wed, 17 Apr 2019 12:15:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417093252.GO1747@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190417101518.c1XEwD_ZOldXg5FH5MJHzZ1xQ12RN8dpA477yQqi1Ug@z>

Hi,

On 17-04-19 11:32, Heikki Krogerus wrote:
> On Wed, Apr 17, 2019 at 11:19:28AM +0200, Hans de Goede wrote:

<snip>

>> That is not going to work since the (virtual) mux / orientation-switch
>> devices are only registered once the driver binds to the piusb30532 i2c
>> device, so when creating the nodes we only have the piusb30532 i2c device.
> 
> It's not a problem, that's why we have the software nodes. The nodes
> can be created before the device entires. The node for pi3usb30532
> will just be the parent node for the new nodes we add for the mux and
> switch.
> 
>> I've been thinking some more about this and an easy fix is to have separate
>> fwnode_match functions for typec_switch_match and typec_mux_match and have
>> them check that the dev_name ends in "-mux" resp. "-switch" that requires
>> only a very minimal change to "usb: typec: Registering real device entries for the muxes"
>> and then everything should be fine.
> 
> I don't want to do anymore device name matching unless we have to, and
> here we don't have to. We can name the nodes for those virtual mux and
> switch, and then just do fwnode_find_named_child_node() in
> pi3usb30532.c for both of them.

Thinking more about this, I have a feeling that this makes things needlessly
complicated, checking the dev_name *ends* in "-mux" resp. "-switch" should be
100% reliable since we call:

         dev_set_name(&sw->dev, "%s-switch", dev_name(parent));
         dev_set_name(&mux->dev, "%s-mux", dev_name(parent));

When registering the switch / mux, so I believe doing name (suffix) comparison
here is fine and much simpler. Anyways this is just my 2 cents on this, I'm
happy with either solution, your choice.

Regards,

Hans
