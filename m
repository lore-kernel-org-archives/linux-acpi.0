From: Kevin Eustice <kfe-764C0pRuGfqVc3sceRu5cw@public.gmane.org>
Subject: Re: Losing lid events after resume (2.6.6)
Date: Mon, 17 May 2004 10:04:24 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040517170424.GA19417@cs.ucla.edu>
References: <20040513181051.GA29398@cs.ucla.edu> <20040517103818.GA1669@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040517103818.GA1669-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > I'm running Fedora Core 1 with a 2.6.6 kernel (with ACPI patches from
> > here applied) on an HP Omnibook 4150B. I've got a lid.sh script that
> > is triggered with the lid button is pressed, and does a "echo standby
> > > /sys/power/state". Initially, this works well. I close the lid, it
> > goes to sleep. I open the lid and press the power button, it wakes
> > up. And then goes right back to sleep. (I don't currently have any
> 
> Are you sure it is not because you receive "lid open" event?

Yup. After going to standby mode, ACPI no longer registers any event
other than the powerbutton events.

Kevin
-- 
Kevin Eustice
Graduate Student Researcher
The Laboratory for Advanced System Research @ UCLA CS
kfe-764C0pRuGfqVc3sceRu5cw@public.gmane.org
http://lasr.cs.ucla.edu/kfe

Computer Science is no more about computers than astronomy is about
telescopes.
	--E. W. Dijkstra



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
