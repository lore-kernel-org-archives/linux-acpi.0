From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 4/6] ACPI: ARM: exclude DMI calls
Date: Sat, 23 Nov 2013 00:15:17 +0100
Message-ID: <4285284.l8TssFvumi@vostro.rjw.lan>
References: <1385080915-23430-1-git-send-email-al.stone@linaro.org> <528F9C65.7010302@linaro.org> <CAOesGMgFBRjO++JSP0ddKKQ2RfG8V4fb97Hd+Oqwixi_Tt7Qwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54627 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753277Ab3KVXCf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Nov 2013 18:02:35 -0500
In-Reply-To: <CAOesGMgFBRjO++JSP0ddKKQ2RfG8V4fb97Hd+Oqwixi_Tt7Qwg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Al Stone <al.stone@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, linux-acpi@vger.kernel.org, Linaro Patches <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, linaro-acpi@lists.linaro.org

On Friday, November 22, 2013 10:53:09 AM Olof Johansson wrote:
> On Fri, Nov 22, 2013 at 10:03 AM, Al Stone <al.stone@linaro.org> wrote:
> > On 11/22/2013 06:25 AM, Rob Herring wrote:
> >>
> >> On Thu, Nov 21, 2013 at 6:41 PM,  <al.stone@linaro.org> wrote:
> >>>
> >>> From: Al Stone <al.stone@linaro.org>
> >>>
> >>> Modified #ifdef so that DMI is not used on ARM platforms which
> >>> are currently implementing ACPI reduced HW mode.
> >>
> >>
> >> It is really not allowed or is optional? There are various people that
> >> want DMI tables on ARM.
> >>
> >> Rob
> >
> >
> > True.  DMI is optional.  I see it as orthogonal to
> > reduced HW mode; I have to hope that when DMI patches
> > are forthcoming they'll do the right thing here.
> >
> > Is there a better way to do this in the #if ?
> 
> 
> Doing all of these things at compile time seems odd, shouldn't it be
> handled at runtime? What happens when someone wants to build a kernel
> that boots both on the reduced hw mode platforms and regular ones?

I agree.

My suggestion would be to harden dmi_check_system() so that it works
if DMI is not present (if it doesn't already).

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
