From: Keld =?iso-8859-1?Q?J=F8rn?= Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Subject: Re: problem with cpu eating too much power, prize given if solved
Date: Wed, 30 Jun 2004 00:50:08 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040629225008.GA3159@rap.rap.dk>
References: <20040624153513.GB19545@rap.rap.dk> <20040628204008.GK698@openzaurus.ucw.cz> <20040629155718.GA1866@rap.rap.dk> <20040629221019.GA25464@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040629221019.GA25464-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Keld J?rn Simonsen <keld-6PR53cSIHaE@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 30, 2004 at 12:10:19AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > Many times I just want to read the screen, eg emails or documents,
> > > > and then still the cpu will be in idle mode, where
> > > > it uses 7.5 W out of the about 15 W that the whole machine uses.
> > > > I have found out from Intel data sheets that my
> > > > Mobile Intel Celeron 2.0 GHz CPU consumes 7.5 W in idle loop/
> > > > stop grant/sleep states, (and 5.0 W i deep sleep state).
> > > >  
> > > > So I would like to have the CPU stopped completely (consuming 0 W)
> > > > while I still could read the screen. In that way I should
> > > > be able to have about double the lifetime on the battery,
> > > > going to about 7 hours from the 3.5 hours I have now.
> > > >  
> > > > I would like the machine to wake up again by any keystroke
> > > > on the keyboard or mouse input. I would like the input to be
> > > > reacted upon (not just used to wake up the system, and
> > > > then forgotten).
> > > >  
> > > 
> > > S1 is what you want... but... if you get what you asked for,
> > > do you realize that for example clock would not update on the desktop
> > > in this mode?
> > 
> > Maybe S1 is what could do this. I understand that I could not then have
> > the clock updated every second but every minute would work, and even if 
> > the screen was not updated every minute it would be fine. But I would
> > expect the clock to be accurate when the cpu is started again.
> 
> Can you verify that your hardware can do S1? (cat /proc/acpi/sleep).

It says:
S0 S3 S4 S5

/sys/power/state says:

standby mem disk

Best regards
keld


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
