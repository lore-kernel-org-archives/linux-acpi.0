From: Nik Trevallyn-Jones <nik-DjZbVUabzA+jF4gvJNWmbtHuzzzSOjJt@public.gmane.org>
Subject: Re: Acpi-devel digest, Vol 1 #2816 - 10 msgs
Date: Tue, 20 Sep 2005 19:31:30 +1000
Message-ID: <432FD6F2.5010205@babel.homelinux.net>
References: <20050920030132.F26E389321@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050920030132.F26E389321-MRDXTZLjjMs+bN4EscsFoaQD96bmaF075NbjCUgZEJk@public.gmane.org>
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

> Try tailing the log file  :-) 
> 
>  received event "button/sleep SBTN 00000080 00000002"
> [Tue Sep 13 22:02:31 2005] notifying client 12488[500:100]
> [Tue Sep 13 22:02:31 2005] executing action "/etc/acpi/handle.pl
> button/sleep SBTN 00000080 00000002"

Awesome!! Now that I've found the acpi log file (I was tailing 
/var/log/messages), I can confirm that it has the same label on my 
distro too (FC3).

> ipw2200 will need to be rmmod from the kernel. Along with some other
> "blacklists".

That's interesting: with the previous kernel, the ipw2200 driver tried 
to resume - it just had a problem reloading the firmware...

No problems, I am happy to unload/reload drivers.

> Better yet, look now!! There's even a kernel packaged for FC Folks. See
> the article for the link to the packager's homepage etc.
> 

Yess!! Found the link! I can download a patched FC3 drop-in replacement 
kernel, and give Suspend2 a try. I'll let you know which seems better 
for me, suspend to memory, or suspend2 to disk.

> I feel so left out  :-) 

I feel for you. For almost the entire time I ran RH9 on my Dell, I 
couldn't get 3D acceleration working - I was the only kid on the block 
without it... *shiff*


Thank you again for all your help! So far, the changes have been very 
easy - I was just having trouble finding out how it actually worked (was 
spoilt by the previous version working out of the box).


Cheers!
Nik.




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
