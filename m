From: "Fabio Comolli" <fabio.comolli@gmail.com>
Subject: Re: 2.6.27-rc1: critical thermal shutdown on thinkpad x60
Date: Thu, 7 Aug 2008 15:05:10 +0200
Message-ID: <b637ec0b0808070605o38ac0b73q14753a6b7e3e061f@mail.gmail.com>
References: <20080806090246.GA1572@elf.ucw.cz>
	 <20080807113400.GA18297@nb.net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:35342 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbYHGNFL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 09:05:11 -0400
Received: by yw-out-2324.google.com with SMTP id 9so262298ywe.1
        for <linux-acpi@vger.kernel.org>; Thu, 07 Aug 2008 06:05:10 -0700 (PDT)
In-Reply-To: <20080807113400.GA18297@nb.net.home>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karel Zak <kzak@redhat.com>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

Seems not only limited to ThinkPads as my HP laptop started to shut
down for thermal events with 27-rc1 too. It happened twice (one with
-rc1 and another with -rc2). Never happened before.


On Thu, Aug 7, 2008 at 1:34 PM, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Aug 06, 2008 at 11:02:47AM +0200, Pavel Machek wrote:
>> Hi!
>>
>> Aug  6 11:00:10 amd kernel: ACPI: Critical trip point
>> Aug  6 11:00:10 amd kernel: Critical temperature reached (128 C),
>> shutting down.
>> Aug  6 11:00:10 amd shutdown[24414]: shutting down for system halt
>>
>> ...and machine went down at that point :-(.
>
>  It seems it like a bad day for ThinkPads:
>
> Aug  6 20:05:36 nb kernel: ACPI: Critical trip point
> Aug  6 20:05:36 nb kernel: Critical temperature reached (128 C),
> shutting down.
>
>  Kernel 2.6.26-136.fc10.x86_64 on x61.
>
>    Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
