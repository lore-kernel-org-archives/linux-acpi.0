From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: HP/Compaq NC6120 ACPI problems
Date: Thu, 31 Mar 2005 22:27:24 +0200
Message-ID: <20050331202724.GB609@openzaurus.ucw.cz>
References: <20050317200052.686d683f.andrej.prsa@guest.arnes.si> <1111088904.11380.36.camel@eeyore> <20050317215635.1c788c09.andrej.prsa@guest.arnes.si> <1111104319.8136.182.camel@tyrosine> <20050318192300.629e2148.andrej.prsa@guest.arnes.si> <1111202374.8136.210.camel@tyrosine> <1111362416.8136.225.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1111362416.8136.225.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Hmm. Yes, I can now repeat this with a 6220, though most of the time I
> > manage it it seems to be linked to a suspend to disk beforehand. I
> > suspect this /may/ be linked to the fact that on the 6120, only the
> > first lid event is received. I'll see if I can track this down over the
> > weekend.
> 
> Ha. Yes, progress, of sorts. On the 6120, you need to do
> 
> setpci -s 1f.0 bb.b=84
> 
> after every lid event in order to get any more. I /think/ this is a bug
> with the HP BIOS (the 6220 doesn't do this) - I'm in touch with HP over
> it now. As for the high kacpid load, I'm only able to trigger this after
> a suspend to disk, and using the platform option (to ensure the _WAK
> methods are called) /seems/ to avoid it. Could you try building a kernel

Well, running with "shutdown" is not really correct on acpi-enabled system.
Perhaps we should change the default?

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
