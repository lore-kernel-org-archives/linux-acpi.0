From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Switching LCD off on a laptop (or change to CRT)
Date: Mon, 23 Sep 2002 17:35:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020923153550.GA324@poup.poupinou.org>
References: <871y7kkd7s.fsf@lexx.delysid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <871y7kkd7s.fsf-lBiwR96x4xkvSoioSV8wqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Mario Lang <mlang-0OxMAPPu35xAfugRpC6u6w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Mario,

On Mon, Sep 23, 2002 at 04:11:35PM +0200, Mario Lang wrote:
> hello.
> 
> I recently got a JVC MP-XP7210DE.  First of all, congrats,
> ACPI worked out of the box with 2.4.20pre7.  I have correct
> ac_adaptor info, correct battery info (even for both
> slots), and the power button works too under acpid.

Have you patched your kernel with the current acpi for linux,
or did you mean the 'old' one?

> 
> One remaining glitch I have is getting the internal
> display to switch off.  Under XP, this works fine
> with Fn-F10.  If I do this under Linux, I get a message
> telling me that this button is not implemented (on the console).

Could you send the actual message, please ?

> 
> Well, that indicates that this LCD display off thing
> must be done by the operating system.
> 
> Well, I'm blind[1], and I realllllly don't need that display,
> and switching it off would save alot of power.  Any hint
> on what I could try to achieve this would be very helpful.
> 
> Does any of the acpi patches already support that?  I think
> it should be a acpi standard, as there is a screen
> saver for Windows NT which does exactly that via ACPI (turn
> the display off).

VGA stuff are not supported for now under linux, even though it
could be done.

Could you send me your DSDT, so that I can try to get it worked
with your system?

For this, you need to get pmtools (from intel site) and do something
like:

wget http://developer.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar.gz
tar xzvfp pmtools-20010730.tar.gz
cd pmtools-20010730
make
cd acpidmp
./acpidmp DSDT > dsdt		(as root!)
gzip dsdt

then send me the resuling dsdt.gz.

I will look for a really nasty hack for your purpose, then.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
