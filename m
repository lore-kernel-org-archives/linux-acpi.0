From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Acer Aspire 9813WKMI fan runs all the time after suspend to ram
Date: Tue, 6 May 2008 19:05:47 +0100
Message-ID: <200805061905.47593.carlos@strangeworlds.co.uk>
References: <28220299.1210016955623.JavaMail.apache@eni-cpps13.sth.basefarm.net> <1210085519.4802.48.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:55291 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbYEFSF6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 May 2008 14:05:58 -0400
In-Reply-To: <1210085519.4802.48.camel@linux-2bdv.site>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: v-j-m@suomi24.fi, linux-acpi@vger.kernel.org

On Tuesday 06 May 2008 15:51:59 Thomas Renninger wrote:
>> Original DSDT > 
http://aceracpi.googlecode.com/svn/trunk/dsdt/acer/aspire/9810.dsl
> [..]
> Could you find out whether some osi set variable is involved.
> (The ones that get set when BIOS (in DSDT) calls e.g.
> osi("Windows 2006"))
> Something like:
> if (osi("Windows 2006"))
>     Store(1, DTSE)
> Maybe you find out what the DTSE or MPEN variable is good for, is set by
> some _INI function of a specific device or whatever?

Looking at the DSDT link posted, those variables are never set in it. I wonder 
who, or what, is expected to set them then...

Perhaps it would be worth experimenting instead with OSI when booting and see 
what happens then? e.g.

acpi_osi="!Windows 2006"

(Perhaps OSYS also triggers an SMI trap which does or doesn't do it? Worth a 
shot at least).

> Best you create a bug for that at bugzilla.kernel.org (and add me to CC
> or post the bug no).
> Full (or none) fan is a real blocker bug that should generally be
> resolved.

I've also had a report from a user the other day that hit the same bug on an 
Aspire 5710 series (which seems to have the same root cause, from glancing 
over the DSDT):

http://aceracpi.googlecode.com/svn/trunk/dsdt/acer/aspire/5710.dsl

> Does this BIOS expose an ACPI fan device correctly? 

Acer BIOS's never expose the fan, AFAIK (and it's not available through WMI 
either).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
