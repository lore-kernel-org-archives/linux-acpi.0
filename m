From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: swsusp acpi-20021022
Date: Thu, 31 Oct 2002 22:58:53 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021031215852.GB4331@elf.ucw.cz>
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

Hi!

> Hello All,
> 	Firstly I'm not 100% certain if this is better here or LKML, If I'm
> wrong then I'll happily move the discussion there.
> 
> I'm running kernel 2.5.44 with the acpi-20021022 aptches applied.  I do how
> ever have a small problem.  I have tested swsusp and the suspend went well.
> Unfortuantly I get an ooops on resume.  I'm happy to look at the cause
> (provide oops and ksyms) BUT the docs say more or less "If you touch your FS
> between suspend and resume then kiss your data goodbye".

If you can't resume, forcing fsck is okay. Suspend-modify-successfull
resume would be time-to-kiss-data.
								Pavel
-- 
When do you have heart between your knees?


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
