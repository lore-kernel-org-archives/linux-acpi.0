From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 5/6] ACPI: do not map/unmap memory regions for FADT entries in reduced HW mode
Date: Tue, 14 Jan 2014 01:02:38 +0100
Message-ID: <11986900.5FYeBqExXg@vostro.rjw.lan>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org> <3512616.qUD2F1beoi@vostro.rjw.lan> <52D471A7.9090907@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61230 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750821AbaAMXsn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jan 2014 18:48:43 -0500
In-Reply-To: <52D471A7.9090907@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On Monday, January 13, 2014 04:07:19 PM Al Stone wrote:
> On 01/10/2014 04:32 PM, Rafael J. Wysocki wrote:
> > On Friday, January 10, 2014 03:52:19 PM al.stone@linaro.org wrote:
> >> From: Al Stone <al.stone@linaro.org>
> >>
> >> Several of the FADT fields are normally kept in specific memory
> >> regions.  Since these fields are to be ignored in hardware reduced
> >> ACPI mode, do not map those addresses when in that mode, and of
> >> course do not release the mappings that have not been made.
> >>
> >> The function acpi_os_initialize() could become a stub in the header
> >> file but is left here in case it can be of further use.
> >
> > Why exactly is this change necessary?
> 
> Two reasons: (1) why do work we do not have to do?  and (2) it
> seemed to make sense to me to have the code reflect the spec
> accurately.
> 
> > Will things work incorrectly on HW-reduced ACPI systems if we don't make it?
> 
> If the ACPI tables have all of these fields properly set to zero
> in hardware reduced, this change does not need to be made.  If a
> vendor provides broken ACPI tables where these values are valid,
> but still sets hardware reduced in the FADT, these fields could
> then be used as before -- but allowing them to be used would mean
> we can no longer claim we are implementing hardware reduced correctly.
> So things would work, but the system would by definition be in some
> sort of undefined hybrid ACPI mode.

So this is how it goes.  I'm being told that there are systems in existence
where the HW-reduced bit is set for Windows RT compatibility, but otherwise
the ACPI HW is fully functional on them.  Apparently, people are able to
install and run Linux on those systems today.

Question is, are they still going to be able to run Linux on them after the
changes in this set?

Rafael

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
