From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: Re: battery life with cpufreq
Date: Mon, 19 Sep 2005 11:57:15 +0200
Message-ID: <20050919095715.GA29988@isilmar.linta.de>
References: <9cfa150205091902116057595e@mail.gmail.com> <20050919092448.GA9023@isilmar.linta.de> <9cfa150205091902354d5b4c43@mail.gmail.com> <1127123139.11913.2.camel@nouse.net> <20050919094827.GB26933@isilmar.linta.de> <9cfa1502050919025331a15ad0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9cfa1502050919025331a15ad0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fred Blaise <chapeaurouge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On Mon, Sep 19, 2005 at 11:53:34AM +0200, Fred Blaise wrote:
> Ok.. well.. speedstep* do not work here (my frequency will remain
> stuck where it last was). On the other hand, p4_clockmod, i can see in
> cpuinfo the frequency going up and down.

Yes, the "frequency" which is reported here is how it "feels", kind of a
normalized variant of 
	x x x x x x x x x x x x x x x x x x x x x x x x 
	x x x x         x x x x       x x x x        
	------------------------------------------------>t

As these "stops" don't last for long periods of time, it is quite correct to
say that the CPU only executes half as much instructions during one second,
so it runs at "half frequency".

	Dominik


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
