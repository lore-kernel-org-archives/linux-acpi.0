From: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Subject: Re: battery life with cpufreq
Date: Mon, 19 Sep 2005 12:18:08 +0200
Message-ID: <20050919101808.GA2411@tangens.sinus.cz>
References: <9cfa150205091902116057595e@mail.gmail.com> <20050919092448.GA9023@isilmar.linta.de> <9cfa150205091902354d5b4c43@mail.gmail.com> <1127123139.11913.2.camel@nouse.net> <20050919094827.GB26933@isilmar.linta.de> <9cfa1502050919025331a15ad0@mail.gmail.com> <20050919095715.GA29988@isilmar.linta.de>
Reply-To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050919095715.GA29988-JwFqNg2GrOVrgjWwlLH9qw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, Fred Blaise <chapeaurouge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Yes, the "frequency" which is reported here is how it "feels", kind of a
> normalized variant of 
> 	x x x x x x x x x x x x x x x x x x x x x x x x 
> 	x x x x         x x x x       x x x x        
> 	------------------------------------------------>t
> 
> As these "stops" don't last for long periods of time, it is quite correct to
> say that the CPU only executes half as much instructions during one second,
> so it runs at "half frequency".
> 
Hi,
  ok, it's clear. But isn't it true that in the periods with clock stopped
the CPU consumes much less power than in those with clock running ? Why there
is no at least slight power saving effect then? 
  BTW I'm experiencing the same. p4-clockmod also doesn't save power on my
Clevo D610SU notebook.
                                  With regards, Pavel Troller


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
