From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Toshiba Satellite P10 + ati-drivers (fglrx)
Date: Sun, 25 Dec 2005 09:47:28 +0100
Message-ID: <20051225084728.GE2183@elf.ucw.cz>
References: <20051224003808.GB16285@elf.ucw.cz> <43AD0AC6.9060904@kroon.co.za> <43AD2676.10703@roarinelk.homelinux.net> <43AD2F3F.7010003@kroon.co.za> <20051224114758.GD26351@elf.ucw.cz> <43AD407A.5020708@kroon.co.za> <20051224124903.GH26351@elf.ucw.cz> <43AD49A8.3010708@kroon.co.za> <20051224135756.GI26351@elf.ucw.cz> <43AE57B4.7030008@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <43AE57B4.7030008-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jaco Kroon <jaco-P18QfuJFXGPYkQIYctQFYw@public.gmane.org>
Cc: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>, Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>, Holger Macht <hmacht-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> New weird error.  This may also be harmless though.  Just first a few
> notes, I'm back onto 2.6.14.3 kernel (fglrx doesn't work with 2.6.15-rc?
> - it just crashes the whole system), and I really need that.
> 
> With fglrx I can suspend to disk and resume.  However, I can't
> suspend-to-ram.  Well, suspend works and it comes back up fine but as
> soon as I switch back to X it hard-crashes the machine.  Now, I'm
> currently between resume and switching to X, and the last few lines from
> dmesg looks as follows:
> 
> Restarting tasks... done
>     ACPI-0284: *** Error: Region EmbeddedController(3) has no handler
>     ACPI-0508: *** Error: Method execution failed [\_SB_.EPWR.PCLK]
> (Node c14d3200), AE_NOT_EXIST
>     ACPI-0508: *** Error: Method execution failed
> [\_SB_.CPI0.LPC0.EC0_._Q1E] (Node c14ceee0), AE_NOT_EXIST

...something wrong with embedded controller... here fixed DSDT *might*
help.

> Now I have a very weird feeling down in my gut that I did not see this
> before and it's probably due to the fglrx module in my kernel.  And
> interrupt 11, btw, is for the screen (it gets shown now in
> /proc/interrupts after I restored most of my kernel).
> 
> Now, initially when I switch back to X I get the correct image on the
> bottom third of the screen with the top two thirds seemingly corrupted.
>  This is pretty normal and is identical to what I normally see when
> switching between consoles and X.  This lasts for about half a second
> before it freezes up and causes a hard-lock.  Normally the screen just
> resets itself at the time it now locks up.

I'm sorry, there's no way we can help you with fglrx. I'm glad at
least s-t-disk works.
								Pavel
-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
