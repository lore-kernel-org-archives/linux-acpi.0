From: Mathias Kolehmainen <mathiask-bdq14YP6qtRg9hUCZPvPmw@public.gmane.org>
Subject: Re: throttling setting being reset
Date: Tue, 23 Jul 2002 13:10:04 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.21.0207231302430.23145-100000@crak.roomfullaspies.com>
References: <20020723073727.GA17284@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020723073727.GA17284-V1rPnKwUOrA59+mn7qD7y50iERQUc4G+@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have been wondering about the temperature.  What is a normal operating
termperature range?

The laptop seems to be around 45 when nothing is happening and quite
happily goes up to near 90 when I'm running gcc.  

I've been getting some erratic crashes when the termperature rises, so
I've been trying to keep the temperature down by tweaking the throttling
file manually.  

I'm not sure how cooling is supposed to work on the laptop.  Maybe it is
supposed to run at a lower performance mode most of the time.  I thought
that I was suffering from a software issue, but maybe the thing is broken.

Anyone else out there got a SRX77p notebook from sony?  I'll check with
the linux-sony list too.


-mathias




On Tue, 23 Jul 2002, Charl P. Botha wrote:

> Hmmm, nevermind the fact that your manual throttling isn't working... your
> CPU shouldn't reach trip point during normal (even hard) use. 85C is just
> too hot.  Are you overclocked?  Cooling broken?




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
