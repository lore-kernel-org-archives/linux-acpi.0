From: Carl Thompson <cet-GxmFRYwVNOxKOnpN5g9PlQ@public.gmane.org>
Subject: RE: C2 or C3 on Presario 2110US?
Date: Thu, 13 Mar 2003 14:58:29 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1047596309.cd6dca3cc99c3@carlthompson.net>
References: <A3C83F41488BD61195C3000802252FC135C175@dubim07742.ie.ml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <A3C83F41488BD61195C3000802252FC135C175-SI4JNLCqwGbcq19Bq1crS1aTQe2KTcn/@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Breathnach, Proinnsias (Dublin)" <breatpro-Lp/cVzEoVybn/p8AFm7ortBPR1lH4CV8@public.gmane.org>
Cc: "'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hmm, I didn't realize the C states worked through the DSDT too!  I am
currently using kernel 2.4.21pre4 with ACPI 20030218.  Today I will try
ACPI 20030228 and see whether that makes a difference.  OK, so I
disassembled the DSDT and recompiled it, and apparently Compaq is pretty
good with its DSDTs these days because I just got three minor warnings
for methods not returning a value.  When I recompile the kernel I will
use the fixed DSDT.  But I don't think that these warnings would be
enough to cause no C2-C3 support.

I also forgot to mention that I have no ACPI fan support, but the fan
does in fact vary speeds depending on the temperature so I think it is
just designed to be controlled by the BIOS (or whatever).  That's OK
because it is varying speeds and seems to be working as it should (even
though it would be nice to control it).

Is it possible this machine just doesn't do C2-C3, processor limit
control or processor performance control?  If that is the case, then why
does Windows seem to be running cooler?  The fan is often off in Windows
but never off in Linux.  Also battery life seems to be better in Windows
whereas on my other laptops it's better in Linux.  And yes, I am using
CPUFreq's PowerNow support to throttle down the CPU speed and voltage to
the minimum.

Does anyone know of any tools to display the exact CPU speed, voltage
and temperature under Windows so I can see exactly what it's doing?  The
PowerNow dashboard from AMD just gives a (simulated) analog guage which
does not give accurate measurements.

Thanks for your help,
Carl Thompson


Quoting "Breathnach, Proinnsias (Dublin)" <breatpro-Lp/cVzEoVybn/p8AFm7ortBPR1lH4CV8@public.gmane.org>:

> Carl,
> 	I'm no ACPI expert here, but I'd imagine the problem is probably
> closer related to the DSDT (the tables the BIOS manufacturer included
> to
> tell the OS about what it can / can't do ...
> 
> In your case it seems that the manufacturer (of either the BIOS
> itself or
> probably the laptop) didn't include any C-State information in the
> ACPI
> tables, or if they did that this information is unreadable by the
> Linux ACPI
> parser.
> 
> Can you output your DSDT and copy the list on it ... someone with
> more
> experience may have an answer as to why it's failing like that !
> 
> What versions of the kernel / ACPI are you using are also important
> factors.
> 
> P
> 
> > -----Original Message-----
> > Actually, any sort of
> > acknowledgement would be nice.  What ever happened to the talk of
> > implementing a bug tracking system?
> >
> >
> 
> 
> 






-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
