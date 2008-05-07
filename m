From: JM <v-j-m@suomi24.fi>
Subject: Vs: Re: Acer Aspire 9813WKMI fan runs all the time after suspend to
 ram
Date: Wed, 7 May 2008 07:21:13 +0200 (CEST)
Message-ID: <27920691.1210137673091.JavaMail.apache@eni-cpps16.sth.basefarm.net>
Reply-To: v-j-m@suomi24.fi
Mime-Version: 1.0
Content-Type: text/plain;charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eni-mailout01.sth.basefarm.net ([80.76.148.7]:57855 "EHLO
	eni-mailout01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756728AbYEGFVP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 May 2008 01:21:15 -0400
Received: from [10.7.4.198] (port=53429 helo=eni-cpps16.sth.basefarm.net)
	by eni-mailout01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <v-j-m@suomi24.fi>)
	id 1Jtc5Z-0004HZ-5H
	for linux-acpi@vger.kernel.org; Wed, 07 May 2008 07:21:13 +0200
Received: from localhost ([127.0.0.1]:53427 helo=eni-cpps16.sth.basefarm.net)
	by eni-cpps16.sth.basefarm.net with esmtp (Exim 4.66)
	(envelope-from <v-j-m@suomi24.fi>)
	id 1Jtc5Z-0002pE-36
	for linux-acpi@vger.kernel.org; Wed, 07 May 2008 07:21:13 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

>
>Perhaps it would be worth experimenting instead with OSI when booting and see 
>what happens then? e.g.
>
>acpi_osi="!Windows 2006"
>
>(Perhaps OSYS also triggers an SMI trap which does or doesn't do it? Worth a 
>shot at least).
>
acpi_osi="!Windows 2006"
acpi_osi="!Windows 2001 SP2"
acpi_osi="!Windows 2001 SP1"
acpi_osi="!Windows 2001"
It is same with all. On cold boot fan stop ~1-2 seconds after Grub (Scope PR INI) and never stop after suspend.

>> Best you create a bug for that at bugzilla.kernel.org (and add me to CC
>> or post the bug no).
>> Full (or none) fan is a real blocker bug that should generally be
>> resolved.
>
>I've also had a report from a user the other day that hit the same bug on an 
>Aspire 5710 series (which seems to have the same root cause, from glancing 
>over the DSDT):
>
>http://aceracpi.googlecode.com/svn/trunk/dsdt/acer/aspire/5710.dsl
>
>> Does this BIOS expose an ACPI fan device correctly? 
>
>Acer BIOS's never expose the fan, AFAIK (and it's not available through WMI 
>either).
>
Is this kernel bug or not?

