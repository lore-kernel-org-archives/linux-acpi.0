From: Christian Brix Folsted Andersen <folsted-TJNDrJVYK8B/SzgSGea1oA@public.gmane.org>
Subject: Re: Problems installing ACPI
Date: 21 Jan 2003 17:37:12 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1043167032.1763.4.camel@localhost.localdomain>
References: <1043083690.1702.15.camel@localhost.localdomain>	<3E2C43D3.3020307@gmx.net>	
	 <3E2C70FB.1090905@gmx.net> <1043147191.1205.8.camel@gregers.imsb.au.dk>
	<3E2D372F.5040500@gmx.net> <1043161338.1284.14.camel@gregers.imsb.au.dk>
	<3E2D722C.5090508@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E2D722C.5090508-hi6Y0CQ0nG0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Heiko Ettelbrueck <hbruckynews-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Heiko

I have both the files:

/proc/acpi/battery/state:
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      3650 mAh
present voltage:         16752 mV

/proc/acpi/battery/info:I
present:                 yes
design capacity:         4000 mAh
last full capacity:      4000 mAh
battery technology:      rechargeable
design voltage:          14400 mV
design capacity warning: 800 mAh
design capacity low:     16 mAh
capacity granularity 1:  100 mAh
capacity granularity 2:  100 mAh
model number:            BAT1
serial number:           0000
battery type:            LION
OEM info:                COMPAQ


On Tue, 2003-01-21 at 17:15, Heiko Ettelbrueck wrote:
> Christian Brix Folsted Andersen wrote:
> > But when i boot the kernel it hangs with the same error as previous.
> > However i read at this site: http://repose.cx/n160/ that passing the
> > parameter "pci=noacpi" should solve the problem. It did. Well at least
> > the booting problem.
> 
> I forgot to mention that - sorry! I also use that boot option, my 
> notebook won't work without it, too.
> 
> > I do not know if the acpi is working correctly. When i enter the power
> > control setup in kde i get this message:
> > 
> > Your computer seems to have a partial ACPI installation
> > probably ACPI was enabled, but some of the sub-option
> > were not enabled - you need to enable at least 'AC Adaptor'
> > and 'Control Method Battery' and rebuild your kernel
> > 
> > I did enable both of these. What can i do next?
> 
> I haven't used ACPI tools in KDE yet, as I prefer Gnome at the moment 
> (there's a Gnome tool called battstat_applet that shows the current 
> battery state, it works fine for me). That's why I have to guess where 
> the issue could _possibly_ be...
> 
> When your Evo has booted, please have a look into the /proc directory. 
> Do you have a directory called "acpi" there? What is inside? There 
> should be e.g. a directory "battery" which contains another directory 
> for each battery (should be "CMB0" for the Evo N160). In 
> /proc/acpi/battery/CMB0, you should find some pseudo files which provide 
> information about your batter, e.g. "info" for general information and 
> "state" for the current state of the battery. If you have these 
> directories and files, please tell me about the content of "info" and 
> "state".
> 
> Regards
> Heiko




-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
