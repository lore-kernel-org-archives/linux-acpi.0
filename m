From: "Gabor Gabris" <gaborgabris@gmail.com>
Subject: Re: Synaptic touchpad freezes and lost sync messages in dmesg
Date: Tue, 6 Feb 2007 01:58:32 +0100
Message-ID: <f6dfbef00702051658g75224b96o2c82340ec395aa6@mail.gmail.com>
References: <f6dfbef00702041218r403147dse04a771fc46e5b73@mail.gmail.com>
	 <GMail.1170718420.189062352.5196947708@brewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:33239 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965417AbXBFA6e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2007 19:58:34 -0500
Received: by an-out-0708.google.com with SMTP id b33so1177303ana
        for <linux-acpi@vger.kernel.org>; Mon, 05 Feb 2007 16:58:33 -0800 (PST)
In-Reply-To: <GMail.1170718420.189062352.5196947708@brewt.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Yee <brewt-linux-acpi@brewt.org>
Cc: linux-acpi@vger.kernel.org

I am nearly sure that it is a Synaptics device, as all OS's, that I
tried recognized it as a Synaptics touchpad (Linux, FreeBSD,NetBSD)
and the driver CD of the laptop (for Win) has a Synaptics driver. But
thanks for the hint.

Gabor

2007/2/6, Adrian Yee <brewt-linux-acpi@brewt.org>:
> Hi Gabor,
>
> On Sun, 4 Feb 2007 21:18:14 +0100
> "Gabor Gabris" <gaborgabris@gmail.com> wrote:
> > I encountered problems on my laptop, which is an Albacomp Eco
> > Traveller V4 (AFAIK it is a rebranded Clevo M660S), it does not bot
> > Linux without ACPI (at least my UHU-Linux with kernel 2.6.17 does not
> > boot with acpi=off parameter), but when I use the Synaptics touchpad
> > in X, the cursor often freezes, and in dmesg i can see the following:
>
> Are you sure your notebook uses a Synaptics touchpad?  With my Sony TX850,
> Debian automatically chooses to use the synaptics driver, which results in the
> freezing cursor and lost interrupts (iirc).  My notebook actually has an ALPS
> touchpad, so tweaking the synaptics driver X configuration accordingly fixes
> things.  Take a look at the README.alps file that comes with the synaptics
> driver if this is the case.
>
> Adrian
>
