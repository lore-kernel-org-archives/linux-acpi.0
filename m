From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: Re: Acpi-devel digest, Vol 1 #2816 - 10 msgs
Date: Tue, 20 Sep 2005 17:49:59 +0800
Message-ID: <1127209800.25800.130.camel@neuromancer.home.net>
References: <20050920030132.F26E389321@sc8-sf-spam1.sourceforge.net>
	 <432FD6F2.5010205@babel.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <432FD6F2.5010205-DjZbVUabzA+jF4gvJNWmbtHuzzzSOjJt@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-09-20 at 19:31 +1000, Nik Trevallyn-Jones wrote:

> > ipw2200 will need to be rmmod from the kernel. Along with some other
> > "blacklists".
> 
> That's interesting: with the previous kernel, the ipw2200 driver tried 
> to resume - it just had a problem reloading the firmware...
> 
> No problems, I am happy to unload/reload drivers.

If you use hibernate script, it's all automatic.

> 
> > Better yet, look now!! There's even a kernel packaged for FC Folks. See
> > the article for the link to the packager's homepage etc.
> > 
> 
> Yess!! Found the link! I can download a patched FC3 drop-in replacement 
> kernel, and give Suspend2 a try. I'll let you know which seems better 
> for me, suspend to memory, or suspend2 to disk.

Bear in mind that suspend2 or swsusp, it doesn't change whether suspend
to disk or suspend to ram works. If it works, it works.

it's either echo mem or echo ram 


> Thank you again for all your help! So far, the changes have been very 
> easy - I was just having trouble finding out how it actually worked (was 
> spoilt by the previous version working out of the box).

Well, it should be 'just works'.

Only ppl like us(techies) will know the diff

-- 
Ow Mun Heng
Gentoo/Linux on DELL D600 1.4Ghz 1.5GB RAM
98% Microsoft(tm) Free!! 
Neuromancer 17:47:27 up 1 day, 8:05, 6 users, load average: 2.59, 1.83,
1.25 




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
