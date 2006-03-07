From: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Subject: Re: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Date: Tue, 7 Mar 2006 11:09:28 -0500
Message-ID: <756b48450603070809i65a08b3aga99c72509f736c3f@mail.gmail.com>
References: <3ACA40606221794F80A5670F0AF15F840B22A242@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:63583 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751221AbWCGQJa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Mar 2006 11:09:30 -0500
Received: by zproxy.gmail.com with SMTP id i11so1501379nzh
        for <linux-acpi@vger.kernel.org>; Tue, 07 Mar 2006 08:09:29 -0800 (PST)
In-Reply-To: <3ACA40606221794F80A5670F0AF15F840B22A242@pdsmsx403>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 3/7/06, Yu, Luming <luming.yu@intel.com> wrote:
> >I've added it as an attachment here. Please let me know if you get it.
> >
> I just found this:
>             Device (SVG)
>                 Device (LCD)
> It looks too simple to fit video.c.

I'm sorry but I'm confused. Do you mean that I shouldn't try to
support the brightness using the default video driver (ie: leave it as
a board specific driver because the board's ACPI implementation for
video support is insufficient) or did you mean that it will be easy
and simple to fit in video.c?

> But it is quite easy to implement in hotkey.c.
> Because it has dedicated device with HID and ,
> well-known method name.
>

I'm confused by hotkey here. I'm not sure how hotkey is involved here.
The Atlas board has no  keys physically. It has buttons which are
hooked up using the ASIM HID and that is what I am trying to support
since those physically exist on the board. Can you help me understand
how hotkey is involved in this?

Thanks,
jayakumar
