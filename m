From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Sat, 23 Nov 2013 16:38:54 +0000
Message-ID: <20131123163854.GA1817@srcf.ucam.org>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org>
 <528F9C65.7010302@linaro.org>
 <CAOesGMgFBRjO++JSP0ddKKQ2RfG8V4fb97Hd+Oqwixi_Tt7Qwg@mail.gmail.com>
 <4285284.l8TssFvumi@vostro.rjw.lan>
 <528FF15C.4060300@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59840 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401Ab3KWQjD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Nov 2013 11:39:03 -0500
Content-Disposition: inline
In-Reply-To: <528FF15C.4060300@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Rob Herring <robherring2@gmail.com>, linux-acpi@vger.kernel.org, Linaro Patches <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, linaro-acpi@lists.linaro.org

On Fri, Nov 22, 2013 at 05:05:48PM -0700, Al Stone wrote:

> For reduced hardware mode, however, I have to rely on the underlying
> ACPICA reference implementation to behave properly.  Right now, ACPICA
> relies on compile time changes to implement either reduced HW mode or
> legacy mode so I have to follow suit.  When I looked at making ACPICA
> change behavior at runtime, the changes became more and more invasive.
> Since x86/ia64 depend on ACPICA to behave also, that seemed a far
> more dangerous approach to me.

Ugh. Really? People have been fairly careful about making sure that the 
x86 SoC code is selected correctly at runtime, and losing that because 
ACPICA is broken would be a shame. I think this is something that needs 
to support runtime switching even if there's also support for building 
kernels that only implement the reduced hardware profile.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
