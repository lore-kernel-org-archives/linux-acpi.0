From: Andy Dustman <andy-gRfBfDTKyCbR7s880joybQ@public.gmane.org>
Subject: Re: acpi-patch + kernel 2.4.19
Date: 07 Aug 2002 19:27:45 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1028762865.14024.8.camel@4.0.0.10.in-addr.arpa>
References: <20020807215528.GA646@enigma.daemon.sh>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020807215528.GA646-adzhR0EPeY/7X6WiDY61Ug@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Sebastian Henschel <s.henschel-TGKKaGbebvyzQB+pC5nmwQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2002-08-07 at 17:55, Sebastian Henschel wrote:

> did anyone of you try to install the current acpi-patch to the current
> linux kernel 2.4.19?

Just for fun, I tried to merge the current patch into 2.4.19 last night.
It wasn't fun.

Actually, I wrote a script that does a three-way merge, in the same
manner as diff3 -m, but working recursively. There are a number of
conflicts, which you would likely get just applying the patch directly
as well. Some of the conflicts are non-trivial, or at least, they were
non-trivial for me to fix them, but I may give it another look.

-- 
Andy Dustman         PGP: 0x930B8AB6
    @       .net     http://dustman.net/andy
"Cogito, ergo sum." -- Rene Descartes
"I yam what I yam and that's all what I yam." -- Popeye


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
