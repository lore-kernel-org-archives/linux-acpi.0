From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI not working - worked with earlier versions
Date: Wed, 23 Oct 2002 16:09:36 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021023140936.GD604@poup.poupinou.org>
References: <20021023083411.3064b045.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021023083411.3064b045.hanno-Mmb7MZpHnFY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hanno =?iso-8859-1?Q?B=F6ck?= <hanno-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 23, 2002 at 08:34:11AM +0200, Hanno Böck wrote:
> Today i reinstalled Linux on my Athlon 700 System.
> With earlier versions of acpi, i had no problems. but now, i get the following error:
> >ACPI: Vendor "VIA694" System "AWRDACPI" Revision 0x0 has a known ACPI >BIOS problem.
> >ACPI: Reason: Bogus table. This is a non-recoverable error
> 
> Well, I had working acpi before, so why this error?
> I don't know if everything worked, but i could definitely start acpid and shutdown my pc with the power-button. This is no longer possible, since it seems that this "error"-check disables acpi completely.
> I don't have an acpi-proc-interface and my pc will not shut down on halt.
> 
> 

If you are really really sure, you can remove the entry in
driver/acpi/blacklist.c,
or mark it as 'non critical'.

But I remember that it has been blacklisted for good reasons (but prehaps
the all_versions need to be changed ?)

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
