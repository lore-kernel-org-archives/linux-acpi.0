From: Federico Di Gregorio <fog-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: vaio pcg-v505ap
Date: Fri, 11 Jul 2003 16:07:12 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030711140712.GA27350@initd.org>
References: <1057573470.983.17.camel@lana> <20030711135638.GD22636@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030711135638.GD22636-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: ACPI Devel Mailing List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Scavenging the mail folder uncovered Ducrot Bruno's letter:
[snip]
> > the problem gets worse as devices using the same irq are used. heavy
> > network traffic makes the problem worser.  also note that this vaio
> > assigns *everything* to irq 9, but i don't know if this is the problem.
> 
> Perhaps, but I have some doubt.  Normally, a ps mouse will get
> interrupt 12.  could you cat /proc/interrupts

here it is. no ps mouse is shown, but i can assure you /dev/psaux
is used by X11 (with the problems reported):

  0:    2180037          XT-PIC  timer
  1:       2831          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
  9:    1502013          XT-PIC  acpi, Ricoh Co Ltd RL5c475, usb-uhci, \
                                 usb-uhci, usb-uhci, eth0, \
				 Intel 82801CA-ICH3, radeon@PCI:1:0:0
 14:      31566          XT-PIC  ide0
 15:         20          XT-PIC  ide1
  
> > sorry for providing so little information on a problem that can be
> > completely independent from acpi. 
> 
> Do you have the same trouble without acpi, then?

does suffice to boot with acpi=no? if yes i can try in a minute, else
i'll need to compile a kernel.

-- 
Federico Di Gregorio
Debian GNU/Linux Developer & Italian Press Contact        fog-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org
  Those who do not study Lisp are doomed to reimplement it. Poorly.
                                     -- from Karl M. Hegbloom .signature


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
