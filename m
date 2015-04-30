From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: acpi_power_meter IPMI region errors
Date: Fri, 01 May 2015 01:33:54 +0200
Message-ID: <4487292.Nn4liAbynN@vostro.rjw.lan>
References: <CALCETrXGnb=48PZEggM3Zj2XgcN-S=VFSnuQTb-KVGEA7aOwmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56338 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750801AbbD3XJA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Apr 2015 19:09:00 -0400
In-Reply-To: <CALCETrXGnb=48PZEggM3Zj2XgcN-S=VFSnuQTb-KVGEA7aOwmQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>

On Thursday, April 30, 2015 03:30:23 PM Andy Lutomirski wrote:
> Hi-
> 
> On a Dell server, I'm seeting:

Hi,

> [At 11.582715] [info] IPMI SSIF Interface driver
> [At 11.583038] [warning] ACPI Error: No handler for Region [SYSI]
> (ffff88041f89b1b0) [IPMI] (20141107/evregion-163)
> [At 11.583043] [warning] ACPI Error: Region IPMI (ID=7) has no handler
> (20141107/exfldio-299)
> [At 11.583047] [warning] ACPI Error: Method parse/execution failed
> [\x5c_SB_.PMI0._GHL] (Node ffff88041f89adc0), AE_NOT_EXIST
> (20141107/psparse-536)
> [At 11.583055] [warning] ACPI Error: Method parse/execution failed
> [\x5c_SB_.PMI0._PMC] (Node ffff88041f89ad20), AE_NOT_EXIST
> (20141107/psparse-536)
> [At 11.583061] [warning] ACPI Exception: AE_NOT_EXIST, Evaluating _PMC
> (20141107/power_meter-755)
> 
> If I build ipmi_si and acpi_ipmi, it's a little better:
> 
> [At 12.333895] [info] IPMI SSIF Interface driver
> [At 12.367570] [warning] ACPI Exception: AE_NOT_EXIST, Returned by
> Handler for [IPMI] (20141107/evregion-297)
> [At 12.367575] [warning] ACPI Error: Region IPMI (ID=7) has no handler
> (20141107/exfldio-299)
> [At 12.367579] [warning] ACPI Error: Method parse/execution failed
> [\x5c_SB_.PMI0._GHL] (Node ffff88041f89adc0), AE_NOT_EXIST
> (20141107/psparse-536)
> [At 12.367586] [warning] ACPI Error: Method parse/execution failed
> [\x5c_SB_.PMI0._PMC] (Node ffff88041f89ad20), AE_NOT_EXIST
> (20141107/psparse-536)
> [At 12.367592] [warning] ACPI Exception: AE_NOT_EXIST, Evaluating _PMC
> (20141107/power_meter-755)
> 
> reloading acpi_power_meter causes the errors, but not the "IPMI SSIF"
> message, to repeat.
> 
> Is this a problem?  Why is it happening?

It looks like a missing operation region handler, meaning that AML wants
to send/receive things via IPMI but it can't do that.  That may be bad or
good, depending.

I'm not sure why it's missing (Lv is more familiar with the code in question).

> My DSDT is here:
> 
> https://bugzilla.kernel.org/attachment.cgi?id=175391

What BZ entry is that?

Rafael

