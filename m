From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Update on my Compaq Presario 730US
Date: Mon, 26 Aug 2002 11:48:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020826094829.GA2231@poup.poupinou.org>
References: <5.1.0.14.0.20020825003345.03296a68@pop-server.triad.rr.com> <5.1.0.14.2.20020825100615.019d6c78@wheresmymailserver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020825100615.019d6c78-Ohq+Lg777JlA8W4XnQNk2r5dPsmED6B0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Alberto Ornaghi <alor-G/4Acn03FKk@public.gmane.org>
Cc: Michael Notforyou <sqfreak-goaWJWIt5zpWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Aug 25, 2002 at 10:09:38AM +0200, Alberto Ornaghi wrote:
> At 00.49 25-08-2002, Michael Notforyou wrote:
> 
> >Buttons detected:
> >lid
> >power
> >power
> >sleep
> 
> double power directory is a bug of that version... please use the latest 
> 20020725 (for 2.4.18) or 20020815 (for 2.4.19)
> 
> 
> >Any of the weird (no thermal_zones, no P-states) fixed by newer versions?
> 
> IIRC this laptop doesn't have thermal control in ACPI it is hardware 
> controlled.
> 

AFAIK, the presario series have buggy DSDT.  I have already fixed the
presario-1201EA.  I also noticed that it will be one of the worst wrotten
DSDT I never seen...

Please send me the DSDT of your model, or give a link to it to a web/ftp etc.,
so that we can see at it.

For that, you need to get the pmtools from intel site:

http://developer.intel.com/technology/iapc/acpi/downloads.htm

Under pmtools-20010730, do:
make
cd acpidmp
./acpidmp DSDT > dsdt
gzip dsdt

then send me the dsdt.gz generated.

I also noticed that a well know guy from compaq for his work on most if
not all of the compaq's servers on Linux is now on this list, so that I hope
that compaq laptops will get now corrected dsdt table :)

Thanks,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
