From: Pavel Vondricka <Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org>
Subject: Re: Freezing more and more (Gericom Supersonic M6T)
Date: Fri, 7 Mar 2003 23:09:59 -0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303072309.59986.Pavel.Vondricka@ff.cuni.cz>
References: <200303041529.11172.Pavel.Vondricka@ff.cuni.cz> <20030307111853.GD18420@atrey.karlin.mff.cuni.cz> <20030307150045.GQ12499@poup.poupinou.org>
Reply-To: Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030307150045.GQ12499-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Yes, it is a winmodem (ltmodem) and it has been OK all the time. I would 
suspect the HostAP WiFi driver, which usually has problems - our WiFi router 
locked up lately and there is surely no ACPI in the kernel. But the problem 
often remains even though I do not use (insert) the card and the driver 
module is not loaded.

Pavel

> On Fri, Mar 07, 2003 at 12:18:53PM +0100, Pavel Machek wrote:
> > Hi!
> >
> > > > > Could you at least not tell me, if this is a hardware or a software
> > > > > problem of ACPI, please? Should I ask for warranty repair of my
> > > > > notebook (I still have one year, I believe) or just patiently wait
> > > > > for another ACPI patch releases? Can I send you more debug info,
> > > > > how?
> > > >
> > > > Try it without acpi, if it still locks randomly, blame hardware, else
> > > > blame acpi.
> > > > 									Pavel
> > >
> > > He said he *need* acpi for irq routing.  I guess his bios is legacy
> > > free.
> >
> > He said he needs it for things like sound and modem. That should still
> > enable him to run some stress test (make -j?) without it.
>
> Correct.  But then we can not determine if the problem come from ACPI, or
> from one of his devices (Hey, we don't know what is his modem.  If it is
> a win one with a propritary driver..).

-- 
###########################################################################
# mailto:Pavel.Vondricka-1W7zqEVgo5LrBKCeMvbIDA@public.gmane.org / ICQ:143159880 
# http://web.ff.cuni.cz/~vondric
#
# Muzete mi psat cesky s libovolnym kodovanim (UTF-8, ISO-8859-2,
# windows-1250, atd. ...)
###########################################################################


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
