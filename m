From: garkein@mailueberfall.de
Subject: Re: Thinkpad T61 consuming more power on AC
Date: Tue, 08 Jul 2008 20:06:13 +0200
Message-ID: <1215540373.5364.7.camel@thinkpad>
References: <1215293883.5545.19.camel@thinkpad>
	 <1215480699.6121.25.camel@yakui_zhao.sh.intel.com>
Reply-To: garkein@mailueberfall.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752739AbYGHSGr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 14:06:47 -0400
In-Reply-To: <1215480699.6121.25.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

Am Dienstag, den 08.07.2008, 09:31 +0800 schrieb Zhao Yakui:
> The C-state mapping between CPU C3/C4/C5/C6 and ACPI C3 is defined
> in ACPI tables, which is related with the BIOS. In order to use CPU C6
> state in AC mode, we must modify the C-state mapping in ACPI tables. It
> is not easy. And IMO it is meaningless(CPU C6 can save more power than
> CPU C3. But it is not obvious). So not recommend to do so.
>    Of course if still hope to do so, please refer to the _CST object
> defined in section 8 of ACPI 3.0 spec and custom DSDT should be used.

Thanks Yakui. I have to say that I don't have any ACPI knowledge other
than common hearsay so I have to learn ACPI from the beginning and I
hope I could find some spare time to get and idea, at least.
>From what I understood so far, the way to go would be the following:

- Extract the ACPI tables of my notebook
- Read the spec and tweak the right entry
- Convince the kernel to use the customized table

Probably I could also read the ACPI tables when on battery just to load
it when in AC mode? (I could then skip step 2 of understanding what I'm
doing... ;-)

For the effectiveness:
I cannot say whether the power consumption is that big, the difference
of the fan (not) getting on my nerves _is_ significant however.
I just had the idea that the behaviour of the embedded controller for
controlling the fan may also be different in AC vs. battery mode (the
threshold temperatures), so I it's indeed not garantueed that using C6
vs. C3 alone does the trick. But I do hope so.

Thanks,
Daniel


