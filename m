From: "Adrian Yee" <brewt-linux-acpi@brewt.org>
Subject: Re: Synaptic touchpad freezes and lost sync messages in dmesg
Date: Mon, 05 Feb 2007 15:33:40 -0800
Message-ID: <GMail.1170718420.189062352.5196947708@brewt.org>
References: <f6dfbef00702041218r403147dse04a771fc46e5b73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mini.brewt.org ([216.18.5.212]:51962 "HELO mini.brewt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751400AbXBEXkX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2007 18:40:23 -0500
In-Reply-To: <f6dfbef00702041218r403147dse04a771fc46e5b73@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gabor Gabris <gaborgabris@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi Gabor,

On Sun, 4 Feb 2007 21:18:14 +0100
"Gabor Gabris" <gaborgabris@gmail.com> wrote:
> I encountered problems on my laptop, which is an Albacomp Eco
> Traveller V4 (AFAIK it is a rebranded Clevo M660S), it does not bot
> Linux without ACPI (at least my UHU-Linux with kernel 2.6.17 does not
> boot with acpi=off parameter), but when I use the Synaptics touchpad
> in X, the cursor often freezes, and in dmesg i can see the following:

Are you sure your notebook uses a Synaptics touchpad?  With my Sony TX850,
Debian automatically chooses to use the synaptics driver, which results in the
freezing cursor and lost interrupts (iirc).  My notebook actually has an ALPS
touchpad, so tweaking the synaptics driver X configuration accordingly fixes
things.  Take a look at the README.alps file that comes with the synaptics
driver if this is the case.

Adrian
