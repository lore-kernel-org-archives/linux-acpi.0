From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Dell Inspiron 2650
Date: Wed, 7 Aug 2002 09:41:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020807074153.GA18748@poup.poupinou.org>
References: <D8C1802AADD0D346BE5C0A1D117075CC02C1C98C@cceexc17.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <D8C1802AADD0D346BE5C0A1D117075CC02C1C98C-pKAD8otJBe2P0FQRY6S+e9kSKC0Mw0DFJ8am2ALHCgk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Black, Richard" <Richard.Black-VXdhtT5mjnY@public.gmane.org>
Cc: Baris Metin <baris-HcGUqKqhBWRyhfBGqJeJzQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 06, 2002 at 03:48:21PM -0500, Black, Richard wrote:
> >>I've seen the page
> >>http://www.intel.com/technology/IAPC/acpi/bios_override.htm but 
> >>could not download the ad.exe utility. The link seems to be 
> >>broken. Is there an other way to disassemble th DSDT ?
> 
> (See steps #3 and #4)
> 
> As a user do this:
> 
> 1) mkdir /tmp/acpi && cd /tmp/acpi
> 2) cat /proc/acpi/dsdt > dsdt.dat    (root power needed here)
> 3) build people.freebsd.org/~takawata/pacpidump.tar.gz (modify the Makefile to build on linux)
> 4) ./pacpidump/acpidump > dsdt.asl   (need root power here)

An alternative is to use iasl with the -d option.

Must admit that I have not try it so much, though...

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
