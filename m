From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: Compilation error acpi-20020725-2.4.18
Date: Fri, 26 Jul 2002 16:32:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020726153205.GA27016@clara.net>
References: <20020726141906.3578.qmail@gonicus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020726141906.3578.qmail-t5zJAXK//yKELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Birger Peer K?pper <kuepper-juygj+9FDkuELgA04lAiVw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Birger Peer K?pper [kuepper-juygj+9FDkuELgA04lAiVw@public.gmane.org] wrote:
> Hello,
> I`ve patched a 2.4.18 vanilla Kernel with the acpi-20020725-2.4.18.diff Patch.
> 
> During compilation I got some errors like:
> ----------------------------------------------------------------------
> dswload.c: In function `acpi_ds_load2_end_op':
> dswload.c:451: structure has no member named `name'
> 
> Has anyone any Idea what`s wrong?
> 
> Thanks a lot....

Linus Torvalds reported the same error, I'm sure there will be a fix
soon :)


Faye

-- 
Faye Pearson,
Software Development Manager,
ClaraNET Ltd.       Tel 020 7903 3000

"Ain't that something what happened today.  One of us got traded to
Kansas City."
		-- Casey Stengel, informing outfielder Bob Cerv he'd
		   been traded.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
