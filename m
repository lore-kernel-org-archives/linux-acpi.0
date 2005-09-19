From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: battery life with cpufreq
Date: Mon, 19 Sep 2005 12:22:51 +0200
Message-ID: <20050919102251.GB13041@isilmar.linta.de>
References: <9cfa150205091902116057595e@mail.gmail.com> <20050919092448.GA9023@isilmar.linta.de> <9cfa150205091902354d5b4c43@mail.gmail.com> <1127123139.11913.2.camel@nouse.net> <20050919094827.GB26933@isilmar.linta.de> <9cfa1502050919025331a15ad0@mail.gmail.com> <20050919095715.GA29988@isilmar.linta.de> <20050919101808.GA2411@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050919101808.GA2411-hxMeMO63rIAUgFT2KJq8fg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Troller <patrol-FIBU9iiavH4@public.gmane.org>, Fred Blaise <chapeaurouge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Hi,
>   ok, it's clear. But isn't it true that in the periods with clock stopped
> the CPU consumes much less power than in those with clock running ?

Yes, indeed. However, it consumes exactly the same amount of energy as if it
were in an "idle state" (ACPI C-States). And that's entered automatically if
there is nothing for the CPU to do. As a typical CPU in a typical notebook
only has something to do for 5% of the time, throttling to 75%, for example,
means the CPU is:
	working		 5%
	idling		20%
	throttling	75%

moving "time" around from idling to throttling or the other way around
doesn't matter anything. If you use CPU frequency scaling, though, the
"working" part consumes less CPU power. Also, the "idle state" typically
consumes less power if the CPU frequency and voltage was scaled down.

	Dominik


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
