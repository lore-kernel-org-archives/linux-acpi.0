From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: swsusp acpi-20021022
Date: Thu, 31 Oct 2002 12:06:54 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021031110654.GB27413@poup.poupinou.org>
References: <Pine.LNX.4.44.0210310944170.11540-100000@thor.cantech.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210310944170.11540-100000-optB1Q+C1bO+ZPExc8Iw5bpzq4S04n8Q@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Anthony J. Breeds-Taurima" <tony-xfCdrj5MXxYnC9Muvcwxkw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 31, 2002 at 09:50:36AM +0800, Anthony J. Breeds-Taurima wrote:
> Hello All,
> 	Firstly I'm not 100% certain if this is better here or LKML, If I'm
> wrong then I'll happily move the discussion there.
> 
> I'm running kernel 2.5.44 with the acpi-20021022 aptches applied.  I do how
> ever have a small problem.  I have tested swsusp and the suspend went well.
> Unfortuantly I get an ooops on resume.  I'm happy to look at the cause
> (provide oops and ksyms) BUT the docs say more or less "If you touch your FS
> between suspend and resume then kiss your data goodbye".

swsusp is a little unstable with this kernel.

> 
> What I need to know is what is the safest way to get my machine back?
> Can I just boot into another kernel and hope my FS won't be too badly
> corrupted?

No.  A simple fsck should be OK, but be warned that this kernel has 
a known bug for fs corruption, and is somehow broken in syncing ide
disks.  Take a look at 2.5.44-ac5 instead.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
