From: "Thomas W. Carley" <tcarley@embedded-zone.com>
Subject: Re: DSDT database
Date: Fri, 08 Sep 2006 13:00:26 -0400
Message-ID: <4501A1AA.1070907@embedded-zone.com>
References: <45019486.2030407@embedded-zone.com> <200609081238.54362.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:3467 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750771AbWIHRAh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Sep 2006 13:00:37 -0400
In-Reply-To: <200609081238.54362.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ling.l.yu@intel.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am interested in identifying and manipulating SMBus devices. I am most
interested in the clock generator, SMBus address 0x69. However, from
what I can see each clock generator has a VERY different SMBus register
layout. From reading the standard I see that the ACPI DSDT table is
capable of enumerating SMBus devices, but from the few DSDT tables I
have looked at there is never any SMBus devises, and often the SMBus
master itself is not represented. Now, I have only looked at about 6 so
far. I was hoping that looking at more may give me an idea of how common
it is to have SMBus devices listed in the DSDT.

A a slightly off note, since I see some Intel people here, I have been
trying to get a hold of the Intel Clock Synthesizer recommendations with
little success. I have CK97 and CK00. I see references to a CK410,
CK510, etc. Does anyone know where I can find these specs? I have trying
calling and emailing Intel support with no success.

In the end, I am trying to find a standard way of at least identifying
which clock generator is on a machine with only software. That is, no
peaking at the motherboard. Short of that, any standard methods for
manipulating the clock generator would do.

Any help would be greatly appreciated, and thank you for the responses I
have received so far.

Tom Carley.

Len Brown wrote:
> On Friday 08 September 2006 12:04, Thomas W. Carley wrote:
>> ACPI list,
>>
>> I am looking into the level of SMBus support in ACPI implementations. I
>> see that the sourceforge project has 652 DSDT's in its database. I would
>> like to run some automated scripts over these to get some statistics
>> about the level of SMBus support. However, downloading them one at a
>> time will take forever. Is the DSDT database available in whole? Can
>> someone send me a link, or send the files directly?
> 
> Maybe Yu Ling knows how to get "behind the mirrors" of the web server
> and can run something for you there?
> 
> Another possibility is that you supply the script you want to run
> and folks on the list can mail you the output.  While I've never
> submitted a DSDT to the web site because I fundamentally do not
> believe it modifying DSDTs as a solution for Linux problems,
> I do have a couple DSDTs on hand.
> 
> BTW. exactly what is it that you are trying to learn?
> 
> cheers,
> -Len
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFAaGqM+ThSqsPpFsRAqM+AKDLBFbshybCsfE8V7GNQ35/M9AEBACg1zEP
T/06FxeYu0C187PZY8hpXG4=
=NO7H
-----END PGP SIGNATURE-----
