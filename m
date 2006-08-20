From: Thomas Renninger <trenn@suse.de>
Subject: Re: DSDT/ASL compiler error
Date: Sun, 20 Aug 2006 16:34:49 +0200 (CEST)
Message-ID: <7359733.1156084489259.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
References: <20060817170303.GA3592@cactii.net> <1155897211.4302.1318.camel@queen.suse.de> <20060818112517.GB4945@poupinou.org> <1155906597.4302.1339.camel@queen.suse.de> <20060818201858.GD4945@poupinou.org> <1155991812.4302.1357.camel@queen.suse.de> <20060820102212.GF4945@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:43151 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750801AbWHTOfF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 20 Aug 2006 10:35:05 -0400
In-Reply-To: <20060820102212.GF4945@poupinou.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Ben B <kernel@bb.cactii.net>, linux-acpi@vger.kernel.org

Am So 20.08.2006 12:22 schrieb Bruno Ducrot <ducrot@poupinou.org>:
>
>> On Sat, Aug 19, 2006 at 02:50:12PM +0200, Thomas Renninger wrote:
>> > On Fri, 2006-08-18 at 22:18 +0200, Bruno Ducrot wrote:
>> > > On Fri, Aug 18, 2006 at 03:09:56PM +0200, Thomas Renninger wrote=
:
>> > > > (unfortunately, I hoped that was the missing hint to fix some
>> > > > things on
>> > > > this system).
>> > >
>> > > What things need to be fixed? I'm just curious.
>> >
>> > - _PPC always returns 1, therefore highest freq cannot be set
>> > (also reported recently on cpufreq list)
>> > https://bugzilla.novell.com/show_bug.cgi?id=3D179702
>> >
>> > - The other one could be an EC issue:
>> > battery and AC status is not updated.
>> > May be an interference with the mouse driver from the comments,
>> > no idea yet.
>> > https://bugzilla.novell.com/show_bug.cgi?id=3D200169
>> >
>> > Any hints are greatly appreciated...
>> > AFAIK both (at least first on several Core Duo models) phenomenons
>> > seem
>> > to happen on several (all?) new HP models.
>> >
>>
>> Also I'm wondering why there is a _PR.CPU0.INI() method. I'm
>> wondering
>> if it should be a _INI instead. But it seems it's a workaround for
>> some
>> others OSs and I'm not sure if we have to call the SMM implied by
>> that
>> _INI in order to fix that since Linux should have done something
>> similar
>> already?
>>
>> Strange.
>
>The _INI funcs are declared in SSDT(s) just invoking INI().
>The SMM stuff in _INI seems to be called if _OSI function only returns
>true for "Windows 2001" (don't have the table here right now, but it
>was for a specific _OSI string setting C014 to 0x4 which is checked
>there). It didn't help, it even made things worse, slowing the whole
>system down extremly.
>
>=C2=A0=C2=A0=C2=A0=C2=A0Thomas
>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
