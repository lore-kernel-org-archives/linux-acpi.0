From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Acer Travermate 8005 and battery info
Date: Thu, 7 Oct 2004 11:21:35 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041007092135.GA983@elf.ucw.cz>
References: <415C270F.5050306@lanil.mine.nu> <20041001102926.GD18786@elf.ucw.cz> <415D8CCF.8050602@lanil.mine.nu> <20041001194739.GE1100@openzaurus.ucw.cz> <41603BA0.9090900@lanil.mine.nu> <20041003203457.GD3379@elf.ucw.cz> <41617104.2040302@mega.ist.utl.pt> <20041005143951.GB4723@openzaurus.ucw.cz> <4162C0D1.20906@mega.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4162C0D1.20906-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >I believe that smbus is subset of i2c... So first step would be
> >"make it talk with smart battery over i2c".
> >
> >Anyway I may be wrong. You'll know for sure when the patch starts
> >working :-).
> 
> sometime in the not-so-near future :-)
> 
> i'll start studying i2c to find out the smbus "address" (sorry if this 
> is a dumb mistake) and try to scan it for the smart battery.
> 
> can it be done in userspace? or do i need to start coding in the kernel 
> right away?

No idea, perhaps i2c has some "debug-call-me-from-userspace" hooks.

> p.s.: do you mind if i reply to you and CC to the list or the reply in 
> the list es enough?

Cc me, that gives you faster reply.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
