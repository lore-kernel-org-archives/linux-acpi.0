From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [2.5.69] S3 does not come back / Sony Vaio C1MHP
Date: Fri, 6 Jun 2003 01:10:32 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030605231031.GI608@elf.ucw.cz>
References: <20030527101501.GB1247@paradigm.rfc822.org> <20030528214124.GB667@elf.ucw.cz> <20030529171328.GA4279@paradigm.rfc822.org> <20030529191735.GB1454@elf.ucw.cz> <20030531085706.GD5501@paradigm.rfc822.org> <20030605215350.GE19556@poupinou.org> <20030605220144.GE608@elf.ucw.cz> <1054853791.15276.48.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1054853791.15276.48.camel-2MMpYkNvuYAXoXS6vNje7nviChZXdy279dF7HbQ/qKg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Keyboard led blink, perhaps ?
> > 
> > That's hard I'm afraid. Beeping on speaker should be easier.
> 
> -ac has a pluggable morse code ops that should be ideal for this.
> Speaker is definitely easier though (and it would be nice to have
> speaker morse too)

This one needs to be called from assembly in real mode (during resume)
and shortly after entering protected. panic code is unlikely to be
helpfull.

							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
