From: "John J. Lee" <jjl-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI + loop(AES) + swsusp
Date: Sun, 18 Aug 2002 14:58:27 +0100 (BST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.SOL.4.44.0208181454300.2717-100000@mimosa.csv.warwick.ac.uk>
References: <3D4EA2EE.C5252944@pp.inet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3D4EA2EE.C5252944-+kynuGyeZW3HOG6cAo2yLw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Jari Ruusu <jari.ruusu-+kynuGyeZW3HOG6cAo2yLw@public.gmane.org>
Cc: Robert Stark <rstark-viLzafFedAGELgA04lAiVw@public.gmane.org>, Linux Mailinglists <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-crypto-qDhp9YYfzQpg9hUCZPvPmw@public.gmane.org, swsusp-LcL5texQODR2DW0IdvIQ2g@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 5 Aug 2002, Jari Ruusu wrote:

> And even if loop thread did the 'refrigerator' thing, it would be really bad
> security wise because the encryption keys would be written to disk when
> kernel RAM is saved to disk. Of course that is not a problem with
> unencrypted loops.
>
> Robert, can you send me URLs of the patches that you used? It may be
> possible to add such code in '#ifdef CONFIG_SWSUSP / #endif' hunks, so that
> it gets activated only if swsusp is enabled in kernel config. I can't
> promise that it gets merged, but I will at least take a look at it.
[...]

Given your point about security, wouldn't it be nice if there were yet
another flag to indicate that encrypted partitions should just be
turned off on suspend?

This is more useful than it sounds -- not all partitions are mounted all
the time.  It might actually be convenient if you don't want to
accidentally leave a partition accessible when you walk away from a
machine and forget to losetup -d, or whatever.


John



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
