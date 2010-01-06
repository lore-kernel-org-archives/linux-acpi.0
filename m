From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Add DMI quirk for Intel DP55KG mainboard
Date: Wed, 6 Jan 2010 14:51:06 +0000
Message-ID: <20100106145106.03031bcd@lxorguk.ukuu.org.uk>
References: <20100104162114.GA30113@percival.namespace.at>
	<alpine.LFD.2.00.1001041209300.4012@localhost.localdomain>
	<20100106074101.GE1392@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755916Ab0AFOtT@vger.kernel.org>
In-Reply-To: <20100106074101.GE1392@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, Christian Hofstaedtler <ch@zeha.at>, x86@kernel.org, Arjan van de Ven <arjan@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bruce.w.allan@intel.com, Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-acpi@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: linux-acpi@vger.kernel.org

> KBD is present on all PCs, not so with acpi. If machine can't handle
> kbd reboot, it is not IBM PC compatible.

Most modern PC systems are not "IBM PC compatible" in various respects.

Defaulting to ACPI reboot is fine as it can fall back to non ACPI reboot
if there is no ACPI or ACPI doesn't provide the needed info for the
system in question
