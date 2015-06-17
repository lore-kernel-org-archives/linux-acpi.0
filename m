From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/12] ACPI: constify patches and other minor fixes
Date: Thu, 18 Jun 2015 00:16:22 +0200
Message-ID: <3443528.LWJL7iWP7c@vostro.rjw.lan>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com> <1575178.P3pyudAmuh@vostro.rjw.lan> <CA+rthh_P_7jSyThmkFX-mEcQ4_62pugB5MO2fZaD7E4V5RcPyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57126 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753429AbbFQVuX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Jun 2015 17:50:23 -0400
In-Reply-To: <CA+rthh_P_7jSyThmkFX-mEcQ4_62pugB5MO2fZaD7E4V5RcPyg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathias Krause <minipli@googlemail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tuesday, June 16, 2015 07:20:32 AM Mathias Krause wrote:
> On 16 June 2015 at 00:49, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Saturday, June 13, 2015 02:26:48 PM Mathias Krause wrote:
> >> this series constifies a few variables in the ACPI code that are read
> >> only and therefore can be const. The main goal is to constify all users
> >> of struct acpi_device_id, but while digging through the code I found a
> >> few other places that could be improved too (constifying other variables
> >> in patches 1, 2, 4 and 9 as adding __init annotations where sensible in
> >> patch 7 or dropping bogus annotations in patch 3).
> >
> > I've queued up the series for 4.2 except for patches [3/12] and [4/12].
> >
> > My recollection of the __refdata in the processor driver is that it was needed
> > for some obscure reason, so that one requires some more thorough code inspection
> 
> I guess it was needed for the __cpuinit annotation (see e.g.
> v3.11-rc1:drivers/acpi/acpi_processor.c). But that one was dropped
> during the development of v3.11 in commit fe7bf106ebc2 "acpi: delete
> __cpuinit usage from all acpi files", obsoleting the need for the
> __refdata annotation.
> 
> Should I update the patch description and resend a v2?

Yes, please.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
