From: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Subject: Re: Compaq evo n800v
Date: Wed, 12 Mar 2003 14:12:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030312131257.GA1636@hell.org.pl>
References: <1047125223.5077.28.camel@localhost.localdomain> <15980.22695.764082.140067@hotzenplotz.chateau-neukoelln.de> <20030310100824.GB32516@hell.org.pl> <15980.63370.956274.280152@hotzenplotz.chateau-neukoelln.de> <20030310204501.GA17353@hell.org.pl> <15981.52449.352495.551945@stephan.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <15981.52449.352495.551945-i6UgHu6VvmYwLeuMs8dnSMnRjscXObHh@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stephan Krings <stephan-MC3rjLPHZ0jJ0Y7HFzmx4Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thus wrote Stephan Krings:
> > I don't know how about the Evo, but on Asus those keys generate ACPI
> > events, yet there are methods in DSDT for handling those events and they
> > work irregardless to external conditions.
> Just out of curiousity: How are these methods called or do these
> methods comply with the VGA extensions, which are described in the
> ACPI spec?

No, they do not. These are internal \_SB.PCI0.PX40.ECD0._Q0E and
\_SB.PCI0.PX40.ECD0._Q0F to increase and decrease brightness (these are 
mapped to the hotkeys in the DSDT), and GPLV and SPLV to get and set it 
directly, probably designed for ospm (which I use in the driver).

> > Search your DSDT for such methods.
> Already did so: And none of the methods get hit when toggling the
> display brightness. Which is pity, because that would have made it
> possible to write a module like the one for Toshiba notebooks to alter
> display parameters programmatically.

Well, these might not be obvious to spot. Cross-referencing and indexing
help a lot in that. Check for IndexFields with interesting names, perhaps
you'll find something anyway.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
