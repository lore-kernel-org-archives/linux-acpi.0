From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ZPODD ACPI _PRW method support
Date: Wed, 28 Nov 2012 11:18:41 +0100
Message-ID: <1804754.cgLN50ubYg@vostro.rjw.lan>
References: <CANh5a1wN-vsYSAtWXWR2P5C=4kVeVj94UZPPbMGGXxHMJyzDew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35057 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638Ab2K1KN5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Nov 2012 05:13:57 -0500
In-Reply-To: <CANh5a1wN-vsYSAtWXWR2P5C=4kVeVj94UZPPbMGGXxHMJyzDew@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Jeff.Wu" <chping@gmail.com>, minggr@gmail.com, aaron.lwe@gmail.com

On Wednesday, November 28, 2012 04:52:17 PM Jeff.Wu wrote:
> Hi aaron,ming,linux-acpi
> 
>  Is it  whether need support ACPI _PRW method for ZPODD device ?

Yes, it is.

>  If BIOS had implemented _PRW method for ZPODD ,
> but Linux kernel doesn't support  ZPODD _PRW method,ZPODD will can't
> run into suspend state.

I'm not sure what you mean.

If we don't use _PRW, the device won't be able to signal wakeup events.

> Is there any stories for ZPODD Linux _PRW method ?

All threads related to ZPODD are about that indirectly.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
