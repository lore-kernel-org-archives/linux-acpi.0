From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [PATCH v3 4/8] i2c: add support for ACPI reconfigure notifications
Date: Wed, 15 Jun 2016 13:30:10 +0300
Message-ID: <CAE1zotLFtzfOrfmiRaewzdctD4UDPa8pJ6fVC34C8XRrArb5UQ@mail.gmail.com>
References: <1465917446-14043-1-git-send-email-octavian.purdila@intel.com>
	<1465917446-14043-5-git-send-email-octavian.purdila@intel.com>
	<20160615062724.GB1344@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38488 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbcFOKaM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2016 06:30:12 -0400
Received: by mail-wm0-f41.google.com with SMTP id m124so29272317wme.1
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2016 03:30:11 -0700 (PDT)
In-Reply-To: <20160615062724.GB1344@tetsubishi>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>, Mark Brown <broonie@kernel.org>, Joel Becker <jlbec@evilplan.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-efi@vger.kernel.org, linux-i2c <linux-i2c@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Irina Tirdea <irina.tirdea@intel.com>

On Wed, Jun 15, 2016 at 9:27 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Tue, Jun 14, 2016 at 06:17:22PM +0300, Octavian Purdila wrote:
>> This patch adds supports for I2C device enumeration and removal via
>> ACPI reconfiguration notifications that are send as a result of an
>> ACPI table load or unload operation.
>>
>> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
>
> What happened to Mika's reviewed-by?
>

Missed that, I will send a new series soon to correct a bisectability
issues reported by kbuild and I'll add with Mika's reviewed-bys.
