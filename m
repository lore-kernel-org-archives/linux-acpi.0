From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: Losing lid events after resume (2.6.6)
Date: Mon, 17 May 2004 16:39:27 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040517163826.F21811@root.org>
References: <20040513181051.GA29398@cs.ucla.edu> <20040517103818.GA1669@elf.ucw.cz>
 <20040517170424.GA19417@cs.ucla.edu> <40A909D3.1080009@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40A909D3.1080009-GANU6spQydw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Eric Valette <eric.valette-GANU6spQydw@public.gmane.org>
Cc: Kevin Eustice <kfe-764C0pRuGfqVc3sceRu5cw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 17 May 2004, Eric Valette wrote:
> > Yup. After going to standby mode, ACPI no longer registers any event
> > other than the powerbutton events.
>
> You are not alone and a similar bug with several proposed patches is
> already open (for months now) at :
>
> http://bugme.osdl.org/show_bug.cgi?id=2321
>
> Note that apparently, the rewrite of the GPE handling is underway and
> things should be fixed soon (at least that is what len says...)

A related issue for Thinkpads:
http://bugme.osdl.org/show_bug.cgi?id=2644

Basically, disabling the lid GPE even though it's marked wake/run makes
suspend fail as soon as the lid switch is pressed.

-Nate


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
