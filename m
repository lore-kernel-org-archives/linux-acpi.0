From: Rodrigo Luiz <rodrigo@gus-mg.org>
Subject: Re: sony-laptop: ACPI Exception when a Fn-Key is pressed
Date: Mon, 6 Apr 2009 10:13:53 -0300
Message-ID: <7a3045780904060613x4ba373c6o7447e511d3841cfa@mail.gmail.com>
References: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com>
	 <20090406110154.GA25085@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f160.google.com ([209.85.217.160]:33021 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756278AbZDFNN4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2009 09:13:56 -0400
Received: by gxk4 with SMTP id 4so4602794gxk.13
        for <linux-acpi@vger.kernel.org>; Mon, 06 Apr 2009 06:13:53 -0700 (PDT)
In-Reply-To: <20090406110154.GA25085@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Mon, Apr 6, 2009 at 8:01 AM, Mattia Dongili <malattia@linux.it> wrote:
>
> Does booting with acpi_osi=Linux makes things any worse? (it should fix
> the above error but might make some other functionality behave
> differently).
> Or eventually also see if there is a bios upgrade available for your
> laptop.
>

Booting with acpi_osi=Linux does not make any changes. Kernel show the
same messages.

And there is no bios upgrade for my notebook :(

I forgot to say two things:

When I loaded the module, a new message appeared (booting with and
without acpi_osi=Linux):

sony-laptop: Sony Notebook Control Driver v0.6.
input: Sony Vaio Keys as /class/input/input9
input: Sony Vaio Jogdial as /class/input/input10
--> [Firmware Bug]: ACPI: ACPI brightness control misses _BQC function
sony-laptop: brightness ignored, must be controlled by ACPI video driver


And these errors show in any ACPI events (lid open/close, press power
button ...), not just in Fn-Keys.

-- 
[]'s
Rodrigo Luiz
