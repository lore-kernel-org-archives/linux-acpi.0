From: "Brian S. Julin" <bri@abrij.org>
Subject: Re: [PATCH] misc: Add oqo-wmi driver for model 2 OQO backlight and
 rfkill control
Date: Wed, 3 Dec 2008 20:28:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0812031931240.2166@sheavy.abrij.org>
References: <20081127190517.GA25429@srcf.ucam.org>
 <alpine.LFD.2.00.0811281431320.3204@localhost.localdomain>
 <Pine.LNX.4.64.0811282215160.17453@sheavy.abrij.org> <20081129045045.GA13866@srcf.ucam.org>
 <20081203195537.GB22560@srcf.ucam.org> <20081203150019.7e272c19.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:42440
	"EHLO QMTA07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754794AbYLDBcO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Dec 2008 20:32:14 -0500
In-Reply-To: <20081203150019.7e272c19.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org, greg@kroah.com, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org



Yeah Matthew picked up the code before I did a final cleanup, at that
point I was still just waiting for someone(anyone) to test it.  So the edges are
rough and there's still some painter's tape stuck to the walls.  I guess I 
can afford some time to shave the fuzzies off, but Matthew and I should 
coordinate timewise if this all needs to be fixed before it's in a repository -- 
my opportunities to code are sparse, and his attention is probably a highly 
contested resource.

Thanks for the review (and Sven in other reply, too) -- a few items I 
probably would have missed cleaning.  Some stuff is the wmi core 
and sample drivers at least as they were when I coded, and those aren't 
from me.

On Wed, 3 Dec 2008, Andrew Morton wrote:
>> +static int smread_s16(u8 hi_addr, u8 lo_addr)
>> +{
>> +	s16 ret = -1;
>> +	acpi_status status;
>> +	u8 r;
>> +
>> +	/* Keep some ACPI routines off the SMBUS */
>> +	status = oqo_lock_smbus(1);
>> +	if (ACPI_FAILURE(status))
>> +		goto skip;
>
> Does this mean that we didn't take the lock?  If so, will running
> oqo_lock_smbus(0) be correct?

That does this (in DSL) after unpacking arguments and running a switch statement:

             Store (BUF1, VFLG)
                     Return (0x00)

...VFLG being a preallocated RAM value in the ACPI VM.  That's all.  Famous last 
words but I really don't see it failing ever, or if it does the ACPI VM's in
deep doodoo anyways.  At any rate it will not spin.

Really an ACPI doctor is needed to even explain why it's there at all -- 
there's a real mutex on the SMBUS, and this here is not it.

It seems to just be some sort of badly coded (in DSDT) advisory that keeps the 
machine awake.  I only even bothered to call it because it seemed like safer to 
do so than not.  We should really be the only writer, as ACPI routines merely 
read it (and only a few of them.)  The only access to it is through the WMI 
interface.  Can we just claim exclusivity on using that given this is an 
omnibus driver?

> This driver does quite a lot of casting of things which the compiler
> will happily do for us.  This could be viewed as having documentation
> benefit, but not much, and it is atypical.

Yep I know, I'm cast-and-paren trigger happy.  Keeps me sane, and has saved
my butt a few times, but can be cleaned to match style.

P.S. I think it was Sven that pointed out a

label:
  return

IIRC that was due to a cranky GCC warning FWIW.

--
Brian
