From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Oopses and ACPI problems (Linus 2.6.29-rc4)
Date: Tue, 10 Feb 2009 17:06:23 +0100
Message-ID: <71cd59b00902100806s44f40812p441fae0b157cdb9c@mail.gmail.com>
References: <alpine.LFD.2.00.0902081251090.3048@localhost.localdomain>
	 <gemini.ket9w800w44dc0hvg.linux@youmustbejoking.demon.co.uk>
	 <20090209234911.GB862@elte.hu>
	 <5030E21460%linux@youmustbejoking.demon.co.uk>
	 <20090210150431.GA26798@srcf.ucam.org>
	 <5030E7CFF4%linux@youmustbejoking.demon.co.uk>
	 <20090210154533.GA27596@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:6053 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbZBJQGZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2009 11:06:25 -0500
In-Reply-To: <20090210154533.GA27596@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Darren Salt <linux@youmustbejoking.demon.co.uk>

On Tue, Feb 10, 2009 at 4:45 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, Feb 10, 2009 at 03:15:21PM +0000, Darren Salt wrote:
>
>> As things stand, this is likely to be a problem for anybody using lenny on
>> Eee hardware and upgrading (on their own) to 2.6.29, given that that
>> workaround is present in eeepc-acpi-scripts in lenny.
>>
>> Anyway, removing that option fixes the problem.
>
> Ok. I'll look into ensuring that these don't collide, but fundamentally
> the problem here is distributions using broken options rather than
> fixing the problem properly in the first place.
>
>> > BIOS bug. There's an explicit delay in the eee bios for some reason, and
>> > I haven't found any straightforward way to avoid it.
>>
>> BIOS bug or no, the fact remains that this is (AFAICS) a regression.
>
> You don't get properly working hotkeys otherwise, to the best of my
> recollection. There's an entry on the kernel bugzilla about this
> somewhere.
> --
> Matthew Garrett | mjg59@srcf.ucam.org

http://bugzilla.kernel.org/show_bug.cgi?id=12243
If I understand things correctly, this was already the case before,
but the kernel boot was slower, so we could'nt see that.
If it's not the case, someone with a 901 should try bisecting (I only
have a 701).


-- 
Corentin Chary
http://xf.iksaif.net
