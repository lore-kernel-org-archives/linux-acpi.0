From: Jack Coates <jack-3OW+c+7o7Hvr/ninRC8lUQ@public.gmane.org>
Subject: Re: [ACPI-sppt] performance & fan & heatload & suspend
Date: 23 Dec 2002 09:25:10 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1040664310.10541.93.camel@chupacabra.monkeynoodle.org>
References: <3E06C494.3060408@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3E06C494.3060408-xhPu7QH+N+StU9/U+hoEgQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: thoma-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org
Cc: acpi-support-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2002-12-23 at 00:08, Malte Thoma wrote:
> Hallo,
> 
> for the ACPI-monitor and controller 'heatload' I need a cat of the
> 'fan' and 'performance' file from the /proc/acpi path.
> If you could send me the the 'echo' commands to control the fan and/or 
> performance this would be great, too. Or (perhaps better :-) you could 
> send me the website, where this (and perhaps more) echo-commands are 
> documented.
> 
> By the way: What do you think about suspend: should a graphical 
> interface should be able to put the computer to sleep (with swsusp)?
> I think it would be a good idea, but is this an action only privilegd 
> users should be able to, or should EVERY user how is allowd to adjust 
> fan/throttling/performance be also allowed to suspend a computer?
> ( Technical spoken: should there be an extra entry in /etc/sudoers for 
> suspend or can the fan/throttling/performancce entry be shared, what do 
> you think about it?
>

FWIW, a laptop typically only has a single user -- regardless of whether
you're running a multi-user OS on it. If there are two entries, the odds
are fantastically high that the same user name is going to be in both
entries. That said, flexibility is good, and someone will be sure to
complain if there's only one entry.

Me, I'd be happy if suspend worked on my laptop at all.

-- 
Jack Coates
Monkeynoodle: A Scientific Venture...



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
