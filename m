From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Wed, 11 Oct 2006 15:08:43 -0400
Message-ID: <d120d5000610111208h6b6f2e49se771be4e50568f54@mail.gmail.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
	 <20061010212341.GA31972@srcf.ucam.org>
	 <200610102320.13952.dtor@insightbb.com>
	 <200610120048.19953.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:41413 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932473AbWJKTIq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Oct 2006 15:08:46 -0400
Received: by ug-out-1314.google.com with SMTP id o38so178947ugd
        for <linux-acpi@vger.kernel.org>; Wed, 11 Oct 2006 12:08:44 -0700 (PDT)
In-Reply-To: <200610120048.19953.luming.yu@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yu Luming <luming.yu@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alessandro Guido <alessandro.guido@gmail.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

On 10/11/06, Yu Luming <luming.yu@gmail.com> wrote:
> > > It would have to be DMI-based to some extent - not all Sonys use the
> > > same keys for the same purpose. Misery ensues.
> >
> > Then we need to add keymap table to the sonypi's input device so that
> > keymap can be changed from userspace.
> If some key is physically broken, I agree configurable keymap is the only
> solution. But, I don't see any other benefit of doing so, if we expect
> platform specific driver report meaningful key code to input layer.
>

As Matthew said different Sony models use different mapping. DMI-based
keymap solution requires kernel upgrade every time new model is out
whereas configurable keymap can be loaded easily form userspace. Also
user might want to remap keys to do different stuff. For example I
never change brigtness on my laptop now that I found settings that I
like. So I could map one key to start kmail and another one to build
kernel for example ;)

-- 
Dmitry
