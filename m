From: Giridhar Pemmasani <giri-IxWJ8JVbGpr5NRxSJurNR4dd74u8MsAO@public.gmane.org>
Subject: Re: [giri@lmc.cs.sunysb.edu: Resume from suspend-to-ram]
Date: Sat, 21 Feb 2004 19:49:59 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <c18uc2$rds$1@sea.gmane.org>
References: <20040220235512.GA27779@dreamland.darkstar.lan> <1077321457.9623.27.camel@gaston> <20040221041647.2F8307831D@mail.lmc.cs.sunysb.edu> <1077336792.17072.30.camel@gaston> <20040221174049.GA4526@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Luca wrote:

> Giridhar  look into  your BIOS  for something  like "Run  VGABIOS if  S3
> Resume" (I have  it under "Power Management") and set  it to "Yes". With
> this option  the firmware  will re-init the  card BIOS  before returning
> control to  Linux. If you  don't see  it then it's  a big  problem... we

Unfortunately there is no such option in BIOS for Dell Latitude D600.

> can't go in real mode once Linux  is running. It may be possible to hack
> up something in wakeup.S, before restoring processor state.

I am not sure exactly what is needed; X is able to POST (using int10?). I
haven't looked at X code, but is that using real mode?

Giri.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
