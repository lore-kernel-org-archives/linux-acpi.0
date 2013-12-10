From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Tue, 10 Dec 2013 12:45:58 +0000
Message-ID: <20131210124558.5E3F9C40A27@trevor.secretlab.ca>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org> < 528F9C65.7010302@linaro.org> < CAOesGMgFBRjO++JSP0ddKKQ2RfG8V4fb97Hd+Oqwixi_Tt7Qwg@mail.gmail.com> < 4285284.l8TssFvumi@vostro.rjw.lan> <528FF15C.4060300@linaro.org> < 20131123163854.GA1817@srcf.ucam.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:41757 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab3LJMqD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2013 07:46:03 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so4843458wes.41
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2013 04:46:01 -0800 (PST)
In-Reply-To: <20131123163854.GA1817@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Al Stone <al.stone@linaro.org>
Cc: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Linaro Patches <patches@linaro.org>, linaro-acpi@lists.linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Sat, 23 Nov 2013 16:38:54 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Fri, Nov 22, 2013 at 05:05:48PM -0700, Al Stone wrote:
> 
> > For reduced hardware mode, however, I have to rely on the underlying
> > ACPICA reference implementation to behave properly.  Right now, ACPICA
> > relies on compile time changes to implement either reduced HW mode or
> > legacy mode so I have to follow suit.  When I looked at making ACPICA
> > change behavior at runtime, the changes became more and more invasive.
> > Since x86/ia64 depend on ACPICA to behave also, that seemed a far
> > more dangerous approach to me.
> 
> Ugh. Really? People have been fairly careful about making sure that the 
> x86 SoC code is selected correctly at runtime, and losing that because 
> ACPICA is broken would be a shame. I think this is something that needs 
> to support runtime switching even if there's also support for building 
> kernels that only implement the reduced hardware profile.

Yeah, that is a really big problem. At the very least push the hacks
back into ACPICA and make that project sort it out (add stub functions
if needed). I don't like seeing the kernel having #ifdef blocks to stub
out normal ACPI paths.

g.

