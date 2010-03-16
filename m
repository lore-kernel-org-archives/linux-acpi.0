From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI spam
Date: Tue, 16 Mar 2010 22:48:53 +0100
Message-ID: <201003162248.53820.rjw@sisk.pl>
References: <a36005b51003160819p21871af4t48a08a502afb67b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42141 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027Ab0CPVp5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Mar 2010 17:45:57 -0400
In-Reply-To: <a36005b51003160819p21871af4t48a08a502afb67b5@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ulrich Drepper <drepper@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

[CCing linux-acpi]

On Tuesday 16 March 2010, Ulrich Drepper wrote:
> On one machine I've used using a recent kernel I see tons of messages like
> 
> Mar 16 10:54:52 intel-d3cf1-01 kernel: ACPI Exception: AE_NOT_EXIST,
> while evaluating GPE method [_L01] (20090903/evgpe-568)
> Mar 16 10:54:53 intel-d3cf1-01 kernel: ACPI Error: No handler for
> Region [ECF2] (ffff88013b69c978) [EmbeddedControl]
> (20090903/evregion-319)
> Mar 16 10:54:53 intel-d3cf1-01 kernel: ACPI Error: Region
> EmbeddedControl(3) has no handler (20090903/exfldio-295)
> 
> This is reported hundreds of times.
> 
> Shouldn't these messages be rate-limited?  Aside from the reason being fixed.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

