From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Applications & ACPI events
Date: Mon, 6 Oct 2003 15:05:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031006130533.GA311@elf.ucw.cz>
References: <20030930165926.GH1921@fairlite.demon.co.uk> <20030930173646.GF11391@poupinou.org> <20031003193814.GE205@openzaurus.ucw.cz> <20031006124935.GQ11391@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031006124935.GQ11391-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Alan Hourihane <alanh-ASBjxr/nLg+TY6FTCsQk+9Bc4/FLrbF6@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > > When using ACPI to shutdown the machine to disk or memory, obviously an
> > > > application can read events from /proc/acpi/events to see what to do.
> > > > 
> > > > How does ACPI in the kernel wait for applications to do what they
> > > > need to when receiving an ACPI event, as it seems the kernel shuts down
> > > > everything pretty quickly ?
> > > 
> > > AFAIK, there is no support for suspending userspace drivers (like X).
> > 
> > Actually X get console switch event, so they should
> > give control of VGA to the kernel...
> 
> Exactly, you have to switch to a console.  That's the problem.

???

Kernel tells X to switch to console; there's interface to say that,
and we are using it. It should just work.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
