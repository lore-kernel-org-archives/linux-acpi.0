From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: [ACPI] acpi_bus_register_driver() returns -ENODEV after resume
Date: Tue, 2 Sep 2003 15:51:07 -0700 (PDT)
Sender: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0309021549420.1737-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0309021529410.1737-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.33.0309021529410.1737-100000-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: swsusp-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=swsusp-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: swsusp-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Tue, 2 Sep 2003, Patrick Mochel wrote:

> 
> > I've received some feedback about problems loading the asus_acpi driver
> > back after swsusp resume. I managed to hit that problem on a 2.4.21 +
> > 20030619 ACPI + swsusp1.1-rc2. I don't know yet if it is present in more
> > recent versions, since this behaviour is not common (at least on my
> > machine). Usually, the module can be loaded and unloaded without problems.

Bah, I just realized that you're using 2.4. The patch may not apply, but 
it should be straightforward to make the change manually. (Sorry, I don't 
have a 2.4 tree around). 

Regardless, it is a bug if it is present in 2.4, and needs to be fixed.


	Pat



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
