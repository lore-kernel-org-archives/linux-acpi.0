From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH v3 1/5] ACPI: introduce
 CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
Date: Wed, 11 Dec 2013 08:33:58 +0000
Message-ID: <20131211083358.GQ2817@xora-haswell.xora.org.uk>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org>
 <52A72D9F.1070004@linaro.org>
 <20131210224912.996FCC40CE1@trevor.secretlab.ca>
 <CAL_JsqK1EJbNud2Pxojso=Vjo9ePEuwi3OUcwoCiwCpKH24LgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:39087 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab3LKIlj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Dec 2013 03:41:39 -0500
Received: by mail-wi0-f169.google.com with SMTP id hn6so6514950wib.4
        for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2013 00:41:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAL_JsqK1EJbNud2Pxojso=Vjo9ePEuwi3OUcwoCiwCpKH24LgA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Hanjun Guo <hanjun.guo@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Al Stone <al.stone@linaro.org>, linaro-acpi@lists.linaro.org, Linaro Patches <patches@linaro.org>, linux-acpi@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Dec 10, 2013 at 08:06:08PM -0600, Rob Herring wrote:
> On Tue, Dec 10, 2013 at 4:49 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > Hi Hanjun,
> >
> > Okay, so after talking with Al and Graeme on IRC, I think I understand
> > what is going on. The fact that ACPICA doesn't allow for both normal and
> > hardware reduced support in the same build is a very big problem.
> > However, it isn't a problem for ARM since we'll never support
> > non-hardware reduced mode. The x86 folks need to work that out when/if
> > they ever add support for hardware reduced mode.
> 
> I believe SMBIOS/DMI tables are only part of full ACPI, so there is a
> need on ARM for more than hardware reduced mode.
> 
You seem to be crossing the streams here, SMBIOS/DMI are not part of ACPI.

The only mention I can even find of them in the spec is you can cross reference
memory to its SMBIOS handle. Which is optional. It even says OSPM will not
use this value.

Graeme

