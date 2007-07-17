From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] ACPI: Add reboot mechanism
Date: Tue, 17 Jul 2007 07:40:46 -0700
Message-ID: <86802c440707170740i30ed2110l130dafbec8e4d4a5@mail.gmail.com>
References: <20070716180019.GA5112@google.com> <200707171331.59414.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:42821 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759911AbXGQOku (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 10:40:50 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2003385wah
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 07:40:50 -0700 (PDT)
In-Reply-To: <200707171331.59414.ak@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Aaron Durbin <adurbin@google.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org

On 7/17/07, Andi Kleen <ak@suse.de> wrote:
> On Monday 16 July 2007 20:00:19 Aaron Durbin wrote:
> >
> > Add the ability to reset the machine using the RESET_REG in ACPI's FADT table.
>
> Why? I had such a patch at some point as experiment, but it never
> helped actually fix a box.
>
system without superio, should still have SMI to simulate one keyboard
controller. So the key board reset still works.

YH
