From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: i2c-acpi-ec.c
Date: Fri, 31 Dec 2004 16:07:24 +0100
Message-ID: <20041231150724.GK19199@poupinou.org>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41D56002.5060008-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Cc: Mathias Weyland <mweyland-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 31, 2004 at 02:19:46PM +0000, Pedro Venda wrote:
> Mathias Weyland wrote:
> >Hi
> 
> hello,
> 
> >My girlfriend bought a new notebook and asked me to install linux on it
> >(she's fearing viruses ect.). It's an acer tm 2303lc and I installed a
> >recent kernel on it. I was quite astonished when I got an empty
> >/proc/acpi/battery, so I checked the dsdt but couldn't find any errors.
> 
> yes, from what I've found, smartbatteries are much more efficient than 
> standard ones, so that's probably a good thing. I like to think so, since I 
> have one.
> 
> >After some time of googling, I read something about smartbatteries. I
> >checked my asl code, and yes, I do have one of those smartbattery-things in
> >front of me. That's quite a problem since my girlfriend will probably kill
> >me when I tell her that battery monitoring is not working.
> 
> be prepared :-)
> 
> >I've read in the acpi4linux list that you took Bruno's old code and that 
> >you
> >are working on a driver. So I wanted to ask whether you need any help 
> >(don't expect too much, I'm writing simulations for computional science and
> >I do only have some minor knowledge of kernel programming (with a 2.0
> >codebase) and how far you got now.
> 
> I started to learn about kernel programming and i2c, smb, acpi etc, but I'm 
> constantly interrupted because of academic work. So I've no time to 
> efficiently develop such beast. Beast because of my no-experience in kernel 
> programming and related subsystems.
> 
> About bruno's driver, I really don't remember well what I've done. I 
> remember correctly addressing the smartbattery and getting some very basic 
> information. nothing useful. I was happy for actually finding and talking 
> to a smart battery though :-)
> 
> My standpoint right now is about the same as you. I'm offering help but 
> won't author a driver because I'm unable to find enough free time.

I'm polishing i2c-acpi-ec right now.  Stay tunned.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
